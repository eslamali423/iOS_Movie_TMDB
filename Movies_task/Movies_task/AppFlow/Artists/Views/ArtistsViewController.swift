//
//  ArtistsViewController.swift
//  Movies_task
//
//  Created by Eslam Ali  on 02/08/2023.
//

import UIKit
import RxSwift
import RxCocoa

class ArtistsViewController: UIViewController {
    //MARK: - IBOUtlets
    @IBOutlet weak var artistsTableView: UITableView!
    
    //MARK: - Variables
    let artistsViewModel = ArtistsViewModel()
    private let disposeBag = DisposeBag()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
       
        subscribeViews()
        configureTableView()
        getArtists()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationController()
    }
    
    
    //MARK: - Functions
    private func setupNavigationController() {
        setupNavigationbar(title: "Artists", titleFont: UIFont.boldSystemFont(ofSize: 16 ), backButtonTitle: "", barTintColor: R.color.main_color(), tintColor: .systemBlue , titleColor: .black , shadowColor: .clear, shadowImage: UIImage())
    }
    
    private func getArtists(){
        if artistsViewModel.nextPage {
            artistsViewModel.fetchArtitsData()
        }else {
            Helper.shared.displayToast(message: "No more data to load")
            
        }
        
    }
    
    private func configureTableView(){
        artistsTableView.register(R.nib.artistsTableViewCell)
        artistsTableView.separatorStyle = .none
        
    }
    
    //MARK: - Subscribe Views
    private func subscribeViews (){
        subscribeOnArtistsListObservable()
        subscribeOnArtistsTableviewCellTap()
        subscribeOnLoadingObservable()
    }
    
    private func subscribeOnArtistsListObservable(){
        artistsViewModel.artistsListObservable.bind(to: artistsTableView.rx.items(cellIdentifier: R.reuseIdentifier.artistsTableViewCell.identifier, cellType: ArtistsTableViewCell.self)) {row,item, artistTableViewCell in
            artistTableViewCell.cellViewModel = ArtistsTableViewCellViewModel(cellModel: item)
            
        }.disposed(by: disposeBag)
        
        
        artistsTableView.rx.didScroll.subscribe { [weak self] _ in
              guard let strongSelf = self else { return }
              let offSetY = strongSelf.artistsTableView.contentOffset.y
              let contentHeight = strongSelf.artistsTableView.contentSize.height

              if offSetY > (contentHeight - strongSelf.artistsTableView.frame.size.height) {
                  strongSelf.getArtists()
              }
          }
          .disposed(by: disposeBag)
        
        
    }
    
    private func subscribeOnArtistsTableviewCellTap(){
        artistsTableView.rx.modelSelected(ArtistModel.self).subscribe(onNext: { [weak self] artist in
            guard let strongSelf = self else {return}
             let vc = R.storyboard.artistDetails.artistDetailsViewController()!
                  
            vc.artistDetailsViewModel = ArtistDetailsViewModel(artist: artist)
            strongSelf.navigationController?.pushViewController(vc, animated: true)
        }).disposed(by: disposeBag)
    }
    
    private func subscribeOnLoadingObservable(){
        artistsViewModel.artistsListLoadingObservable.subscribe(onNext: { isLoading in
            if isLoading {
                Loading.manger.show()
            }else {
                Loading.manger.dismiss()
            }
        }).disposed(by: disposeBag)
    }
}


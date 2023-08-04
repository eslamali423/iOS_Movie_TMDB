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
        artistsTableView.rx.setDelegate(self)
        
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
        
        
//        artistsTableView.rx.didScroll.subscribe { [weak self] _ in
//              guard let strongSelf = self else { return }
//              let offSetY = strongSelf.artistsTableView.contentOffset.y
//              let contentHeight = strongSelf.artistsTableView.contentSize.height
//
//              if offSetY > (contentHeight - strongSelf.artistsTableView.frame.size.height) {
//                //  strongSelf.getArtists()
//              }
//          }
//          .disposed(by: disposeBag)
        
        
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

//MARK: - ScrollView Delegatee
extension ArtistsViewController : UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.bounces = scrollView.contentOffset.y > 10
    }
    
    // this function to detect if scroll view get the end or not and fethcing more data form API
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offset = scrollView.contentOffset
        let bounds = scrollView.bounds
        let size = scrollView.contentSize
        let inset = scrollView.contentInset
        
        let y = offset.y + bounds.size.height - inset.bottom
        let h = size.height
        
        let reloadDistance = CGFloat(30.0)
        if y > h + reloadDistance {
          
            //  TODO:- call method to get more date here then  stop spinner animation
            if artistsViewModel.nextPage {
                getArtists()
            }
        }
    }
}

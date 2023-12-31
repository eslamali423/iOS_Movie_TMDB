//
//  ArtistDetailsViewController.swift
//  Movies_task
//
//  Created by Eslam Ali  on 03/08/2023.
//

import UIKit
import RxSwift
import RxCocoa

class ArtistDetailsViewController: UIViewController {

    //MARK: - IBOutlets
    
    @IBOutlet weak var pageScrollView: UIScrollView!
    @IBOutlet weak var artistImageview: UIImageView!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var artistRateLabel: UILabel!
    @IBOutlet weak var artistOrginalLabel: UILabel!
    @IBOutlet weak var artistAgeLabel: UILabel!
    @IBOutlet weak var artistGenderLabel: UILabel!
    @IBOutlet weak var artistTitleLabel: UILabel!
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    @IBOutlet weak var artistBioLabel: UILabel!
    
    //MARK: - Variables
    var artistDetailsViewModel = ArtistDetailsViewModel()
    private let disposeBag = DisposeBag()
 
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        configureCollectionView()
        subscribeViews()
        getArtisstData()
      
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationController()
    }
    
    
    //MARK: - Functions
    private func setupNavigationController() {
        setupNavigationbar(title: "", titleFont: UIFont.boldSystemFont(ofSize: 16 ), backButtonTitle: "", barTintColor: .clear, tintColor: .systemBlue , titleColor: .black , shadowColor: .clear, shadowImage: UIImage())
    }
    
    private func getArtisstData(){
        guard let id  = artistDetailsViewModel.artist?.id else {return}
        artistDetailsViewModel.fetchArtitsData(id: id)
        artistDetailsViewModel.fetchArtitsImages(id: id)
        
    }
    
    private func setupViews(){
        let statusBarHeight = UIApplication.shared.statusBarHeight
        let navigationBarHeight = navigationController?.navigationBar.frame.size.height ?? 0
        let pageScrollViewYoffset = statusBarHeight + navigationBarHeight
        pageScrollView.contentInset = UIEdgeInsets(top: -pageScrollViewYoffset, left: 0, bottom: 0, right: 0)
    }
    
    private func configureCollectionView(){
        imagesCollectionView.register(R.nib.artistImagesCollectionViewCell)
        imagesCollectionView.formatingCollectionView(topPadding: 0, rightPadding: 0, leftPadding: 0, bottomPadding: 0, width: imagesCollectionView.frame.height , height: imagesCollectionView.frame.height, minimumInteritemSpacing: 0, minimumLineSpacing: 0, scrollDirection: .horizontal)
    }
    
    
    //MARK: - Subscribe Views
    private func subscribeViews(){
        subscribeOnArtistObservable()
        subscribeOnArtistImagesObservable()
        subscribeOnArtistImageCollectionViewCellTap()
        subscribeOnLoadingObservable()
    }
    
    private func subscribeOnArtistObservable(){
        artistDetailsViewModel.artistObservable.subscribe(onNext: { [weak self] artist in
            guard let strongSelf  = self else {return}
            strongSelf.artistNameLabel.text = artist.name ?? ""
            strongSelf.artistTitleLabel.text = strongSelf.artistDetailsViewModel.artist?.knownForDepartment ?? ""
            strongSelf.artistOrginalLabel.text = strongSelf.artistDetailsViewModel.artist?.originalName ?? ""
            strongSelf.artistBioLabel.text = artist.biography ?? ""
            strongSelf.artistRateLabel.text = "\(artist.popularity ?? 0.0)"
            strongSelf.artistAgeLabel.text = "\(artist.birthday ?? "")"
            let gender = ArtistModel.genderType(rawValue: artist.gender ?? 1)
            strongSelf.artistGenderLabel.text = gender == .male ? ("Male") : ("Female")
            if let imageUrl = URL(string: "\(APIConstants.manger.imageUrl())\(artist.profilePath  ?? "")" ) {
                strongSelf.artistImageview.sd_setImage(with: imageUrl)
            }
        }).disposed(by: disposeBag)
    }
    
    
    
    private func subscribeOnArtistImagesObservable(){
        artistDetailsViewModel.artistImageObservable.bind(to: imagesCollectionView.rx.items(cellIdentifier: R.reuseIdentifier.artistImagesCollectionViewCell.identifier, cellType: ArtistImagesCollectionViewCell.self)) {row,item, artistImageCollectionViewCell in
            artistImageCollectionViewCell.cellViewModel = ArtistImagesCollectionViewCellViewModel(cellModel: item)
            
        }.disposed(by: disposeBag)
    }
  
    
    private func subscribeOnArtistImageCollectionViewCellTap() {
        imagesCollectionView.rx.modelSelected(ImageModel.self).subscribe(onNext: { [weak self] profile in
            guard let strongSelf = self else {return}
            let vc = R.storyboard.fullImage.fullImageViewController()!
            vc.fullImageViewModel = FullImageViewModel(profile: profile)
            strongSelf.navigationController?.pushViewController(vc, animated: true)
        }).disposed(by: disposeBag)
    }
    
    private func subscribeOnLoadingObservable(){
        artistDetailsViewModel.artistLoadingObservable.subscribe(onNext: { isLoading in
            if isLoading {
                Loading.manger.show()
            }else {
                Loading.manger.dismiss()
            }
        }).disposed(by: disposeBag)
    }
    
}

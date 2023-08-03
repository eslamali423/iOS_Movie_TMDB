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
        subscribeOnArtistObservable()
        subscribeOnArtistImagesObservable()
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
        imagesCollectionView.register(UINib(nibName: "ArtistImagesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ArtistImagesCollectionViewCell")
       
        imagesCollectionView.formatingCollectionView(topPadding: 0, rightPadding: 0, leftPadding: 0, bottomPadding: 0, width: imagesCollectionView.frame.height , height: imagesCollectionView.frame.height, minimumInteritemSpacing: 0, minimumLineSpacing: 0, scrollDirection: .horizontal)
    }
    
    
    private func subscribeOnArtistObservable(){
        artistDetailsViewModel.artistObservable.subscribe(onNext: { [weak self] artist in
            guard let strongSelf  = self else {return}
            strongSelf.artistNameLabel.text = artist.name ?? ""
            strongSelf.artistTitleLabel.text = strongSelf.artistDetailsViewModel.artist?.mediaType ?? ""
            strongSelf.artistOrginalLabel.text = strongSelf.artistDetailsViewModel.artist?.originalName ?? ""
            strongSelf.artistBioLabel.text = artist.biography ?? ""
            strongSelf.artistRateLabel.text = "\(artist.popularity ?? 0.0)"
            strongSelf.artistAgeLabel.text = "\(artist.birthday ?? "")"
            strongSelf.artistGenderLabel.text = "\(artist.gender ?? 1)"
            
            if let imageUrl = URL(string: "https://image.tmdb.org/t/p/original/\(artist.profilePath  ?? "")" ) {
                strongSelf.artistImageview.sd_setImage(with: imageUrl)
            }
        }).disposed(by: disposeBag)
    }
    
    
    
    private func subscribeOnArtistImagesObservable(){
        artistDetailsViewModel.artistImageObservable.bind(to: imagesCollectionView.rx.items(cellIdentifier: "ArtistImagesCollectionViewCell", cellType: ArtistImagesCollectionViewCell.self)) {row,item, artistImageCollectionViewCell in
            artistImageCollectionViewCell.cellViewModel = ArtistImagesCollectionViewCellViewModel(cellModel: item)
            
        }.disposed(by: disposeBag)
    }
}

//
//  FullImageViewController.swift
//  Movies_task
//
//  Created by Eslam Ali  on 03/08/2023.
//

import UIKit
import RxSwift
import RxCocoa
import SDWebImage

class FullImageViewController: UIViewController {

    //MARK: - IBOutlets
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var saveImageButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    //MARK: - Variables
    private let disposeBag = DisposeBag()
    var fullImageViewModel = FullImageViewModel()
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        configureScrollView()
        subscribeOnSaveImageButtonTap()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationController()
    }
    
    
    //MARK: - Functions
    private func setupNavigationController() {
        setupNavigationbar(title: "", titleFont: UIFont.boldSystemFont(ofSize: 16 ), backButtonTitle: "", barTintColor: .clear, tintColor: .systemBlue , titleColor: .black , shadowColor: .clear, shadowImage: UIImage())
    }
    
    private func configureScrollView(){
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 10.0
    }
    
  
    private func setupViews(){
        
        let statusBarHeight = UIApplication.shared.statusBarHeight
        let navigationBarHeight = navigationController?.navigationBar.frame.size.height ?? 0
        let pageScrollViewYoffset = statusBarHeight + navigationBarHeight
        scrollView.contentInset = UIEdgeInsets(top: -pageScrollViewYoffset, left: 0, bottom: 0, right: 0)
        
        saveImageButton.layer.cornerRadius = 25
        if let imageUrl = URL(string: "https://image.tmdb.org/t/p/original/\(fullImageViewModel.profile?.file_path ?? "")") {
            imageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            imageView.sd_setImage(with: imageUrl)
        }
        
    }
    
    private func subscribeOnSaveImageButtonTap(){
        saveImageButton.rx.tap.subscribe(onNext: { [weak self] in
            guard let strongSelf = self else {return}
            let alert = UIAlertController(title: "Download Image", message: "", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Download", style: .default, handler: { action in
                
                UIImageWriteToSavedPhotosAlbum(strongSelf.imageView.image ?? UIImage(), strongSelf, nil,nil)
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: { action in
                strongSelf.dismiss(animated: true)
            }))
            strongSelf.present(alert, animated: true)
            
        }).disposed(by: disposeBag)
    }
    
}

//MARK: - ScrollView Delegate
extension FullImageViewController :UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}

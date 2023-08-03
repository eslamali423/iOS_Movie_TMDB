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
        if let imageUrl = URL(string: "\(APIConstants.manger.imageUrl())\(fullImageViewModel.profile?.file_path ?? "")") {
            imageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            imageView.sd_setImage(with: imageUrl)
        }
        
    }
    
    private func downloadImage(image: UIImage){
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(successDownloadImage),nil)
    }
    
    private func subscribeOnSaveImageButtonTap(){
        saveImageButton.rx.tap.subscribe(onNext: { [weak self] in
            guard let strongSelf = self else {return}
            let alert = UIAlertController(title: "Download Image", message: "", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Download", style: .default, handler: { action in
                strongSelf.downloadImage(image: strongSelf.imageView.image ?? UIImage() )
                
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: { action in
                strongSelf.dismiss(animated: true)
            }))
            strongSelf.present(alert, animated: true)
            
        }).disposed(by: disposeBag)
    }
    
    //MARK:- Objc Functions
    @objc private func successDownloadImage(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        Helper.shared.displayToast(message: "Image Downloaded successfully")
        }
    
}

//MARK: - ScrollView Delegate
extension FullImageViewController :UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}

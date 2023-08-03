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
        setupNavigationController()
        subscribeViews()
        configureTableView()
        getArtists()
    }
    
    
    //MARK: - Functions
    
    private func setupNavigationController() {
        setupNavigationbar(title: "Artists", titleFont: UIFont.boldSystemFont(ofSize: 16 ), backButtonTitle: "", barTintColor: UIColor(named: "main_color"), tintColor: .systemBlue , titleColor: .black , shadowColor: .clear, shadowImage: UIImage())
    }
    
    private func getArtists(){
        artistsViewModel.fetchArtitsData(page: 1)
    }
    
    private func configureTableView(){
        artistsTableView.register(UINib(nibName: "ArtistsTableViewCell", bundle: nil), forCellReuseIdentifier: "ArtistsTableViewCell")
        artistsTableView.separatorStyle = .none
        
    }
    
    //MARK: - Subscribe Views
    private func subscribeViews (){
        subscribeOnArtistsListObservable()
    }
    
    private func subscribeOnArtistsListObservable(){
        artistsViewModel.artistsListObservable.bind(to: artistsTableView.rx.items(cellIdentifier: "ArtistsTableViewCell", cellType: ArtistsTableViewCell.self)) {row,item, artistTableViewCell in
            artistTableViewCell.cellViewModel = ArtistsTableViewCellViewModel(cellModel: item)
            
        }.disposed(by: disposeBag)
    }
    
    
}


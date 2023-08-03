//
//  ArtistsViewModel.swift
//  Movies_task
//
//  Created by Eslam Ali  on 03/08/2023.
//

import Foundation
import PromiseKit
import RxSwift
import RxCocoa
import Moya

class ArtistsViewModel {
    
    //MARK: - Variables
    let artistsServices = MoyaProvider<ArtistsServices>()
    
    private var artistsListLoadingBehavior = PublishSubject<Bool>()
    var artistsListLoadingObservable : Observable<Bool> {
        return artistsListLoadingBehavior.asObserver()
    }
    
    private var artistsListBehavior = BehaviorRelay<[ArtistModel]>(value: [])
    var artistsListObservable : Observable<[ArtistModel]> {
        return artistsListBehavior.asObservable()
    }
    
    private var pageResponse : PagesModel<ArtistModel>?  = nil
    private var currentPage = 1
    var nextPage = true
    
    //MARK: - Funtions
    func fetchArtitsData() {
          firstly { () -> Promise<Any> in
              return ServicesManager.manger.CallApi(artistsServices, .getArtists(page: currentPage))
          }.done({ [weak self]  response in
              guard let strongViewModel = self else {return}
              let result = response as! Response
             guard NetworkHelper.validateResponse(response: result) else{return}
              let responseModel : PagesModel<ArtistModel>  = try CustomDecoder.decode(data: result.data)
              strongViewModel.pageResponse = responseModel
              var list = strongViewModel.artistsListBehavior.value
              list.append(contentsOf: responseModel.results ?? [])
              strongViewModel.artistsListBehavior.accept(list)
              guard let totalPage = responseModel.totalPages else {return}
              if totalPage > strongViewModel.currentPage {
                  strongViewModel.currentPage += 1
                  strongViewModel.nextPage = true
              }else {
                  strongViewModel.nextPage = false
              }
          }).ensure {
              
          }.catch { (error) in
              print(error.localizedDescription)
          }
      }
    
}

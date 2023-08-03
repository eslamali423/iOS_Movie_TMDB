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
    
    private var artistsListBehavior = PublishSubject<[ArtistModel]>()
    var artistsListObservable : Observable<[ArtistModel]> {
        return artistsListBehavior.asObserver()
    }
    
    
    //MARK: - Funtions
    func fetchArtitsData(page: Int) {
          firstly { () -> Promise<Any> in
              return ServicesManager.manger.CallApi(artistsServices, .getArtists(page: "\(page)"))
          }.done({ [weak self]  response in
              guard let strongViewModel = self else {return}
              let result = response as! Response
          //   guard NetworkHelper.validateResponse(response: result) else{return}
              let responseModel : ResponseModel<[ArtistModel]>  = try CustomDecoder.decode(data: result.data)
              guard let artistData = responseModel.results else {return}
              strongViewModel.artistsListBehavior.onNext(artistData)
          }).ensure {
              
          }.catch { (error) in
              print(error.localizedDescription)
          }
      }
    
}

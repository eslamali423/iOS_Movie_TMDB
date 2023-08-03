//
//  ArtistDetailsViewModel.swift
//  Movies_task
//
//  Created by Eslam Ali  on 03/08/2023.
//

import Foundation
import PromiseKit
import RxSwift
import RxCocoa
import Moya

class ArtistDetailsViewModel {
    
    //MARK: - Variabkles
    let artistsServices = MoyaProvider<ArtistsServices>()
    
    private var artistLoadingBehavior = PublishSubject<Bool>()
    var artistLoadingObservable : Observable<Bool> {
        return artistLoadingBehavior.asObserver()
    }
    
    private var artistBehavior = PublishSubject<ArtistModel>()
    var artistObservable : Observable<ArtistModel> {
        return artistBehavior.asObserver()
    }
    
    private var artistImagesBehavior = PublishSubject<[ImageModel]>()
    var artistImageObservable : Observable<[ImageModel]> {
        return artistImagesBehavior.asObserver()
    }
    
     var artist : ArtistModel?
  
    
    //MARK: - Initlizers
    init(artist: ArtistModel? = nil) {
        self.artist = artist

    }
    
    //MARK: - Functions
  func fetchArtitsData(id: Int) {
      artistBehavior.onNext(artist!)
          firstly { () -> Promise<Any> in
              return ServicesManager.manger.CallApi(artistsServices, .artistDetails(id: id))
          }.done({ [weak self]  response in
              guard let strongViewModel = self else {return}
              let result = response as! Response
             guard NetworkHelper.validateResponse(response: result) else{return}
              let responseModel : ArtistModel  = try CustomDecoder.decode(data: result.data)
              strongViewModel.artistBehavior.onNext(responseModel)
          }).ensure {
              
          }.catch { (error) in
              print(error.localizedDescription)
          }
      }

    func fetchArtitsImages(id: Int) {
        artistBehavior.onNext(artist!)
            firstly { () -> Promise<Any> in
                return ServicesManager.manger.CallApi(artistsServices, .artistImages(id: id))
            }.done({ [weak self]  response in
                guard let strongViewModel = self else {return}
                let result = response as! Response
               guard NetworkHelper.validateResponse(response: result) else{return}
                let responseModel : ImageDataModel  = try CustomDecoder.decode(data: result.data)
                strongViewModel.artistImagesBehavior.onNext(responseModel.profiles ?? [])
            }).ensure {
                
            }.catch { (error) in
                print(error.localizedDescription)
            }
        }
    
    
    
}

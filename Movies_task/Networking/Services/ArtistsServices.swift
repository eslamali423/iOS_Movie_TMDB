//
//  ArtistsServices.swift
//  Movies_task
//
//  Created by Eslam Ali  on 03/08/2023.
//

import Moya

enum ArtistsServices {
    case getArtists(page: Int)
    case artistDetails(id: Int)
    case artistImages(id: Int)
}

extension ArtistsServices: URLRequestBuilder {
    
    var path: String {
        switch self {
        case .getArtists(_):
            return APIConstants.manger.endPoint(.artists)
        case .artistDetails(id: let id):
            return"\(APIConstants.manger.endPoint(.person))\(id)"
        case .artistImages(id: let id):
            return"\(APIConstants.manger.endPoint(.person))\(id)/images"
        }
        
    }
    var method: Moya.Method {
        switch self {
        case .getArtists, .artistDetails, .artistImages:
            return .get
        
        }
    }
    
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case  .artistDetails, .artistImages:
            return .requestPlain
            
        case .getArtists(let page) :
            return .requestParameters(parameters: ["page": page], encoding: URLEncoding.default)
        
        }
    }
}

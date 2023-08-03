//
//  ArtistsServices.swift
//  Movies_task
//
//  Created by Eslam Ali  on 03/08/2023.
//

import Moya

enum ArtistsServices {
    case getArtists(page: String)
}

extension ArtistsServices: URLRequestBuilder {
    
    var path: String {
        switch self {
        case .getArtists(page: let page):
            return APIConstants.manger.endPoint(.artists)
        }
        
    }
    var method: Moya.Method {
        switch self {
        case .getArtists:
            return .get
        
        }
    }
    
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getArtists:
            return .requestPlain
        }
    }
}

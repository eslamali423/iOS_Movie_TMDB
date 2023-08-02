//
//  HomeServices.swift
//  Created by Eslam Ali on 16/10/2022.
//

import Moya

enum HomeServices {
    
    case homeCategories

}

extension HomeServices: URLRequestBuilder {
    
    var path: String {
        switch self {
        case .homeCategories :
            return APIConstants.manger.endPoint(.welcome)
        }
        
    }
    var method: Moya.Method {
        switch self {
        case .homeCategories:
            return .get
        
        }
    }
    
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .homeCategories:
            return .requestPlain
        }
    }
}

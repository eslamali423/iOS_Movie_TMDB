//
//  URLRequestBuilder.swift
//  Created by Eslam Ali on 16/10/2022.
//

import Moya

// MARK: - using Moya pod
// for more info please check this url https://github.com/Moya/Moya
// read the doc. and enjoy


protocol URLRequestBuilder: TargetType {
    
    var baseURL: URL { get }
    
    var requestURL: URL { get }
    
    // MARK: - Path
    var path: String { get }
    
    var headers: [String: String]? { get }
    
    // MARK: - Methods
    var method: Moya.Method { get }
    
    var encoding: ParameterEncoding { get }
    
    var urlRequest: URLRequest { get }
    
    var deviceId: String { get }
}
// MARK: - application constants

extension URLRequestBuilder {
    // MARK: - BASE URL

    var baseURL: URL {
        return URL(string: APIConstants.manger.apiURL())!
    }
    // MARK: - Request URL
    var requestURL: URL {
        return baseURL.appendingPathComponent(path)
    }
    // MARK: - application headers
    var headers: [String: String]? {
        var header = [String: String]()
        header["accept"] = "application/json"
        header["Authorization"] = "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3OGJjYTVhNzcyODhhYWRiZTQ2YWNiNTNjNWNmNmU1YiIsInN1YiI6IjYyNGIxMTg5YTkxMTdmMDA2NDdlYWFhYiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.lxeaZAMHCMHYB5haph4tEz4rFAp0fT6YZ1V8qQXnx6k"
        return header
    }
    
    
    var encoding: ParameterEncoding {
        switch method {
        case .get:
            return URLEncoding.default
        default:
            return JSONEncoding.default
        }
    }
    
    var urlRequest: URLRequest {
        var request = URLRequest(url: requestURL)
        request.httpMethod = method.rawValue
        headers?.forEach { request.addValue($1, forHTTPHeaderField: $0) }
        return request
    }
    
    var deviceId: String {
        return UIDevice.current.identifierForVendor?.uuidString ?? ""
    }
    

    
}

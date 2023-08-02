//
//  DWNetworkStatus.swift
//  Created by Eslam ALi on 10/08/2021.
//

import Foundation

// MARK: - Network response status
enum NetworkStatus : Int {
    
    case success = 200
    
    case added = 202
    
    case failed = 400
    
    case created = 201
    
    case unprocessableEntity = 401
    
    case notActive = 405
    
    case unauthenticated = 403
    
    case notAcceptable = 422
    
    case notFound = 404
    
}

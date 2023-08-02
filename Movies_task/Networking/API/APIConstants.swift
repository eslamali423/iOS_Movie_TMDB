//
//  APIConstants.swift
//  GrandMVVMTemplate
//
//  Created by Eslam Ali on 16/10/2022.
//

import Foundation

protocol APIConstantsTypes {
    func apiURL() -> String
    func endPoint(_ name: EndPoints) -> String
}

public class APIConstants: APIConstantsTypes {

    static let manger : APIConstants = APIConstants()
    
    private init(){}
    
    private func appURL() -> String {
        
        return "https://api.themoviedb.org"
    }
    
    
    
    internal func apiURL() -> String {
        return appURL() + "/3/"
    }
    
    internal func endPoint(_ name: EndPoints) -> String {
        return name.rawValue
    }
}

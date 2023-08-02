//
//  ResponseModel.swift
//  Created by Eslam Ali on 16/10/2022.
//

import Foundation

struct ResponseModel<T: Codable> : Codable{
    let status : Int?
    let msg : String?
    let results : T?
    
    enum CodingKeys: String, CodingKey {
        case status = "code"
        case msg = "message"
        case results = "results"
    }
}
struct APIResponseModel : Codable {
    let error : Int?
    enum CodingKeys: String, CodingKey {
        case error = "error"
    }
}



struct ArtiestModel:  Codable {
    let id : Int?
    let adult : Int?
}

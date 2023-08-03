//
//  PagesModel.swift
//  Movies_task
//
//  Created by Eslam Ali  on 03/08/2023.
//

import Foundation

struct PagesModel<T: Codable> : Codable{
    let page : Int?
    let totalPages : Int?
    let totalResults : Int?
    let results : [T]?
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalPages = "total_pages"
        case totalResults = "total_results"
        case results
    }
}

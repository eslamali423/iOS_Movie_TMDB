//
//  ImageModel.swift
//  Movies_task
//
//  Created by Eslam Ali  on 03/08/2023.
//

import Foundation

struct ImageDataModel : Codable {
    let profiles : [ImageModel]?
}

struct ImageModel: Codable {
    let file_path: String?
}

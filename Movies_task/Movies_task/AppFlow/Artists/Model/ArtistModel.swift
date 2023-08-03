//
//  ArtistModel.swift
//  Movies_task
//
//  Created by Eslam Ali  on 03/08/2023.
//



import Foundation


struct ArtistModel: Codable {
    let adult: Bool?
    let id: Int?
    let name, originalName: String?
    let mediaType: String?
    let popularity: Double?
    let gender: Int?
    let knownForDepartment: String?
    let profilePath: String?

    enum CodingKeys: String, CodingKey {
        case  name
        case id
        case adult
        case originalName = "original_name"
       case mediaType = "media_type"
        case popularity, gender
        case knownForDepartment = "known_for_department"
        case profilePath = "profile_path"
      
    }
}

//
//  ArtistModel.swift
//  Movies_task
//
//  Created by Eslam Ali  on 03/08/2023.
//



import Foundation


struct ArtistModel: Codable {
    
    
    enum genderType : String {
        case male = "male"
        case female = "female"
    }
    
    let adult: Bool?
    let id: Int?
    let name, originalName: String?
    let mediaType: String?
    let popularity: Double?
    let gender: Int?
    let knownForDepartment: String?
    let profilePath: String?
    let biography: String?
    let birthday :  String?
    let place_of_birth: String?
    

    enum CodingKeys: String, CodingKey {
        case  name, biography, birthday
        case id, place_of_birth
        case adult
        case originalName = "original_name"
        case mediaType = "media_type"
        case popularity, gender
        case knownForDepartment = "known_for_department"
        case profilePath = "profile_path"
      
    }
    
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        gender = try values.decodeIfPresent(Int.self, forKey: .gender)
        originalName = try values.decodeIfPresent(String.self, forKey: .originalName)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        mediaType = try values.decodeIfPresent(String.self, forKey: .mediaType)
        popularity = try values.decodeIfPresent(Double.self, forKey: .popularity)
        knownForDepartment = try values.decodeIfPresent(String.self, forKey: .knownForDepartment)
        profilePath = try values.decodeIfPresent(String.self, forKey: .profilePath)
        biography = try values.decodeIfPresent(String.self, forKey: .biography)
        birthday = try values.decodeIfPresent(String.self, forKey: .birthday)
        place_of_birth = try values.decodeIfPresent(String.self, forKey: .place_of_birth)
        do {
            adult = try values.decodeIfPresent(Bool.self, forKey: .adult)
        }catch{
            let intAdult = try values.decodeIfPresent(Int.self, forKey: .adult)
            adult = intAdult == 1
        }
    
    }
}

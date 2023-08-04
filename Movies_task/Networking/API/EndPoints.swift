//
//  EndPoints.swift
//  Created by Eslam Ali on 16/10/2022.
//

import Foundation

enum EndPoints: String {
    // MARK: - static data
    case welcome = "welcome"
    // MARK: - Auth
    case login = "auth/login"
    
    case artists = "trending/person/day"
    case person = "person/"
    case images = "/images"
}

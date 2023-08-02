//
//  CustomDecoder.swift
//
//  Created by Eslam Ali on 11/08/2021.
//

import Foundation

struct CustomDecoder {
    
    static func decode<T: Codable>(data: Data) throws -> T {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }

}

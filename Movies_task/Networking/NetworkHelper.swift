//
//  DWNetworkHelper.swift
//  Created by Eslam Ali on 16/10/2022.
//

import Foundation
import Moya
import SystemConfiguration

struct NetworkHelper {
    
    // MARK: - print response
    fileprivate static func printResponse(_ response: Response) {
        // print request data
        print("URL:")
        print(response.request?.urlRequest)
        print("Header:")
        print(response.request?.headers)
        print("STATUS:")
        print(response.statusCode)
        print("Response:")
        if let json = try? JSONSerialization.jsonObject(with: response.data, options: .mutableContainers) {
            print(json)
        } else {
            let response = String(data: response.data, encoding: .utf8)!
            print(response)
        }
    }
    
    // MARK: - validate all APIs responses
    static func validateResponse (response:Response) ->Bool {
        printResponse(response)
        
            switch response.statusCode {
            case NetworkStatus.success.rawValue :
                return true
            case NetworkStatus.added.rawValue , NetworkStatus.created.rawValue :
                return true
            case NetworkStatus.unprocessableEntity.rawValue:
                return false
            case NetworkStatus.notFound.rawValue:
                return false
            case NetworkStatus.unauthenticated.rawValue:
                return false
            case NetworkStatus.notActive.rawValue:
                return  true
            default:
                return false
            }
        
    }
    
}

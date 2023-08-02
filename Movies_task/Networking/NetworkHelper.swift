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
        guard response.statusCode == NetworkStatus.success.rawValue else{
            if response.statusCode == NetworkStatus.unprocessableEntity.rawValue {
                
            }
            return false
        }
        let decoder = JSONDecoder()
        do {
            let responseModel = try decoder.decode(ResponseModel<APIResponseModel>.self, from: response.data)
            switch responseModel.status {
            case NetworkStatus.success.rawValue :
                return true
            case NetworkStatus.added.rawValue , NetworkStatus.created.rawValue :
                print(responseModel.msg ?? "Error")
                return true
            case NetworkStatus.unprocessableEntity.rawValue:
                print(responseModel.msg ?? "Error")
                return false
            case NetworkStatus.notFound.rawValue:
                print(responseModel.msg ?? "Error")
                return false
            case NetworkStatus.unauthenticated.rawValue:
                print(responseModel.msg ?? "Error")
                return false
            case NetworkStatus.notActive.rawValue:
                print(responseModel.msg ?? "Error")
                return  true
            default:
                return false
            }
        } catch {
            print(error.localizedDescription)
            return false
        }
        
    }
    
}

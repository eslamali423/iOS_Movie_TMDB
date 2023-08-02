//
//  NetworkServices.swift
//  Created by Eslam Ali on 16/10/2022.
//

import PromiseKit
import Moya

// MARK: - using PromiseKit pod
// for more info please check this url https://github.com/mxcl/PromiseKit
// read the doc. and enjoy

class ServicesManager {
    
    static let manger = ServicesManager()
    
    // MARK: - CAll API with promiseKit
    func CallApi<T: TargetType>(_ provider:MoyaProvider<T>,_ target: T) -> Promise<Any> {
        return Promise<Any> { seal in
            provider.request(target, completion: { (result) in
                switch result {
                case let .success(moyaResponse):
                    // http status code is now 200 from here on
                    if moyaResponse.statusCode == 200{
                        seal.fulfill(moyaResponse)
                    }else{
                        seal.fulfill(moyaResponse)
                    }
                case let .failure(error):
                    print(error.localizedDescription)
                    seal.reject(error)
                }
            })
        }
    }
    
  
}


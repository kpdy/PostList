//
//  APIManager.swift
//  PostList
//
//  Created by DY on 05/12/21.
//  Copyright © 2021 DY. All rights reserved.
//

import Foundation
import Moya


#if DEBUG

// Enable console log for the debug.
let provider = MoyaProvider<Service>(session: APISession.shared,
                                     plugins: [NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))])

#else

// Disable console log for the release.
let provider = MoyaProvider<Service>(session: APISession.shared)

#endif


class APIManager {
    
    class func callAPI<T: Codable>(target: Service,
                                    completion: @escaping ((ServiceResult<T>) -> Void)) {
        
        provider.request(target) { (result) in
            
            switch result {
            case .success(let response):
                // ✅ - server has responded with success.
                // convert the data to the model object and return it back.
                
                do {
                    let decodedResponse = try JSONDecoder().decode(T.self, from: response.data)
                    DispatchQueue.main.async {
                        completion(ServiceResult.success(result: decodedResponse))
                    }
                } catch {
                    // we have some error generating the model
                    print(error)
                    DispatchQueue.main.async {
                        completion(ServiceResult.failure(error: .decodingError))
                    }
                }
                
            case .failure(let error):
                // 🚨 - Failed to execute the request.
                
                print("Error in API: ", error)
                DispatchQueue.main.async {
                    completion(ServiceResult.failure(error: .requestFailed))
                }
                
            }
        }
        
    }
    
}

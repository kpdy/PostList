//
//  Service.swift
//  PostList
//
//  Created by DY on 05/12/21.
//  Copyright © 2021 DY. All rights reserved.
//

import Foundation
import Moya

// MARK: - API Services
enum Service {
    
    case getPosts
    
}

extension Service: TargetType {
    
    /// The target's base `URL`.
    var baseURL: URL {
        
        if let url = URL(string: API.URL.BASE_URL) {
            return url
        }
        fatalError("UNABLE TO CREATE URL FOR API CALL")
    }
    
    
    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String {
        
        switch self {
            
        case .getPosts:
            return "posts"
           
        }
    }
    
    
    /// The HTTP method used in the request.
    var method: Moya.Method {
        
        switch self {
            
        case .getPosts:
            return .get
            
        }
        
    }
    
    
    /// The type of HTTP task to be performed.
    var task: Task {
        
        switch self {
            
        case .getPosts:
            return .requestPlain
            
        }
        
    }
    
    
    /// The headers to be used in the request.
    var headers: [String: String]? {
        
        return ["Content-Type": "application/json"]
        
    }
    
}



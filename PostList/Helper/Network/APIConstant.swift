//
//  APIConstant.swift
//  PostList
//
//  Created by DY on 05/12/21.
//  Copyright © 2021 DY. All rights reserved.
//

import Foundation

/// This is the Structure for API
struct API {
    
    // MARK: - API URL
    
    /// Structure for URL. This will have the API end point for the server.
    struct URL {
        
        /// development Server Base URL
        ///
        ///      API.URL.development
        ///
        private static let development                          = "https://jsonplaceholder.typicode.com/"
        
        
#if DEBUG
        // Development version
        static let BASE_URL                                     = API.URL.development
        
#elseif RELEASE
        // Production version
        static let BASE_URL                                     = API.URL.development
        
#else
        // Anything else
        static let BASE_URL                                     = API.URL.development
        
#endif
        
        
    }
    
    
}

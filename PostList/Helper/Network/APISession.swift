//
//  APISession.swift
//  PostList
//
//  Created by DY on 05/12/21.
//  Copyright © 2021 DY. All rights reserved.
//

import Foundation
import Alamofire

class APISession: Alamofire.Session {
    
    static let shared: APISession = {
        
        let configuration = URLSessionConfiguration.default
        
        // The max time interval to wait between server responses before cancelling the request. All session tasks use this value, but it is really designed for tasks running on a default or ephemeral session. Tasks running on a background session will automatically be retried.
        // The default value is 5 minutes.
        configuration.timeoutIntervalForRequest = 60 * 5
        
        // This property determines the resource timeout interval for all tasks within sessions based on this configuration. The resource timeout interval controls how long (in seconds) to wait for an entire resource to transfer before giving up. The resource timer starts when the request is initiated and counts until either the request completes or this timeout interval is reached, whichever comes first.
        // The default value is 7 days.
        configuration.timeoutIntervalForResource = 604800 // 60 * 60 * 24 * 7 = 604800(seconds)
        
        // Create an API manager object with configuration
        return APISession(configuration: configuration)
        
    }()
    
}


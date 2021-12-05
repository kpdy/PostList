//
//  APIError.swift
//  PostList
//
//  Created by DY on 05/12/21.
//  Copyright © 2021 DY. All rights reserved.
//

import Foundation

public struct DYError: LocalizedError, Equatable {
    
    private var description: String!
    
    init(description: String) {
        self.description = description
    }
    
    public var errorDescription: String? {
        return description
    }
    
    public static func ==(lhs: DYError, rhs: DYError) -> Bool {
        return lhs.description == rhs.description
    }
    
}

public extension DYError {
    
    static let requestFailed = DYError(description: NSLocalizedString("Request failed",comment: ""))
    
    static let decodingError = DYError(description: NSLocalizedString("Error Generating the model from the response!",comment: ""))
    
}


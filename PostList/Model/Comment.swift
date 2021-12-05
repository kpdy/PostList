//
//  Comment.swift
//  PostList
//
//  Created by DY on 05/12/21.
//  Copyright © 2021 DY. All rights reserved.
//

import Foundation

// MARK: - Post
struct Comment: Codable, Hashable {
    
    var postID, id: Int?
    var name, email, body: String?
    
    enum CodingKeys: String, CodingKey {
        case postID = "postId"
        case id, name, email, body
    }
    
}


struct NoComments: Codable, Hashable {
    var title: String?
}

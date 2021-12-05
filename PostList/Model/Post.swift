//
//  Post.swift
//  PostList
//
//  Created by DY on 05/12/21.
//  Copyright © 2021 DY. All rights reserved.
//

import Foundation


// MARK: - Post
struct Post: Codable, Hashable {
    
    var userID, id: Int?
    var title, body: String?

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }
    
}

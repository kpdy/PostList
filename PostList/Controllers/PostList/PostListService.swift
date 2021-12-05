//
//  PostListService.swift
//  PostList
//
//  Created by DY on 05/12/21.
//  Copyright © 2021 DY. All rights reserved.
//

import Foundation

protocol PostListServiceAPI: AnyObject {
    func getPosts(completion: @escaping ((ServiceResult<[Post]>) -> Void))
}


class PostListService: PostListServiceAPI {
    
    func getPosts(completion: @escaping ((ServiceResult<[Post]>) -> Void)) {
        APIManager.callAPI(target: .getPosts, completion: completion)
    }
    
}

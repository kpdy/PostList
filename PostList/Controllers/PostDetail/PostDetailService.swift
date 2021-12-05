//
//  PostDetailService.swift
//  PostList
//
//  Created by DY on 05/12/21.
//  Copyright © 2021 DY. All rights reserved.
//

import Foundation

protocol PostDetailServiceAPI: AnyObject {
    func getComments(postId: Int, completion: @escaping ((ServiceResult<[Comment]>) -> Void))
}


class PostDetailService: PostDetailServiceAPI {
    
    func getComments(postId: Int, completion: @escaping ((ServiceResult<[Comment]>) -> Void)) {
        APIManager.callAPI(target: .getComments(postId: postId), completion: completion)
    }
    
}

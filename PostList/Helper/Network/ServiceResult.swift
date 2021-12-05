//
//  ServiceResult.swift
//  PostList
//
//  Created by DY on 05/12/21.
//  Copyright © 2021 DY. All rights reserved.
//

import Foundation

public enum ServiceResult<T> {
    case success(result: T)
    case failure(error: DYError)
}


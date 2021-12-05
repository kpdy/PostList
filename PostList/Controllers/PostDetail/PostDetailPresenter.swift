//
//  PostDetailPresenter.swift
//  PostList
//
//  Created by DY on 05/12/21.
//  Copyright © 2021 DY. All rights reserved.
//

import Foundation

protocol PostDetailView: AnyObject {
    
    // Display an error alert.
    func showError(text: String)
    
    // Start the loading indicator.
    func startLoading()
    
    // Dismiss/Stop the loading indicator.
    func finishLoading()
    
    // Set the view as per the new Comment avaialble.
    func setComment(comments: [Comment])
    
    // Set the empty Post view.
    func setEmptyPost()
    
}

// MARK: View Model -

enum DetailsViewModel: Equatable, Hashable {
    case post(Post)
    case comment(Comment)
    case noComment(NoComments)
}

class PostDetailPresenter {
    
    private let postDetailService: PostDetailService
    weak private var postDetailView: PostDetailView?
    
    private var arrComments: [Comment] = []
    
    init(service: PostDetailService) {
        self.postDetailService = service
    }
    
    func attachView(view: PostDetailView) {
        postDetailView = view
    }
    
    func detachView() {
        postDetailView = nil
    }
    
    func getComments(postId: Int) {
        
        postDetailView?.startLoading()
        
        postDetailService.getComments(postId: postId) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let comments):
                if comments.isEmpty {
                    self.postDetailView?.setEmptyPost()
                } else {
                    self.arrComments = comments
                    self.postDetailView?.setComment(comments: comments)
                }
                
            case .failure(let error):
                print(error)
                self.postDetailView?.setEmptyPost()
                self.postDetailView?.showError(text: error.errorDescription ?? "")
            }
            
            self.postDetailView?.finishLoading()
            
        }
        
    }
    
    public func searchComments(text: String) {
        
        if text.isEmpty {
            self.postDetailView?.setComment(comments: arrComments)
            return
        }
        
        let arrFiltered = arrComments.filter { comment in
            if comment.name!.localizedCaseInsensitiveContains(text) ||
                comment.email!.localizedCaseInsensitiveContains(text) ||
                comment.body!.localizedCaseInsensitiveContains(text) {
                return true
            }
            return false
        }
        
        self.postDetailView?.setComment(comments: arrFiltered)
        
    }
    
}


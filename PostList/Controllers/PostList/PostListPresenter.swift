//
//  PostListPresenter.swift
//  PostList
//
//  Created by DY on 05/12/21.
//  Copyright © 2021 DY. All rights reserved.
//

import Foundation

protocol PostListView: AnyObject {
    
    // Display an error alert.
    func showError(text: String)
    
    // Start the loading indicator.
    func startLoading()
    
    // Dismiss/Stop the loading indicator.
    func finishLoading()
    
    // Set the view as per the new Post avaialble.
    func setPost(posts: [Post])
    
    // Set the empty Post view.
    func setEmptyPost()
    
}

class PostListPresenter {
    
    // Object of the Post List server which will be used to get the data from the server.
    private let postListService: PostListService
    
    // Reference of the PostList View delegate.
    weak private var postListView: PostListView?
    
    // Stores the post data received from the server.
    private var arrPosts: [Post] = []
    
    
    init(service: PostListService) {
        self.postListService = service
    }
    
    func attachView(view: PostListView) {
        postListView = view
    }
    
    func detachView() {
        postListView = nil
    }
    
    /// Get the latest post data from the server!
    func getPosts() {
        
        // Tell the view that we're fetching the data!
        postListView?.startLoading()
        
        // Call an API to get the data!
        postListService.getPosts { [weak self] (result) in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let posts):
                
                // process as per the data recevied!
                if posts.isEmpty {
                    self.postListView?.setEmptyPost()
                } else {
                    self.arrPosts = posts
                    self.postListView?.setPost(posts: posts)
                }
                
            case .failure(let error):
                self.postListView?.setEmptyPost()
                self.postListView?.showError(text: error.errorDescription ?? "")
            }
            
            // Tell the view that data loading process is completed!
            self.postListView?.finishLoading()
            
        }
        
    }
    
    
    /// This will filter the data as per the search text entered by the user!
    ///  this will default seach for the text if that contains in the title or in body.
    /// - Parameter text: text which you wanted to search in the post!
    public func searchPosts(text: String) {
        
        // if text if empty. do not search anything!
        if text.isEmpty {
            self.postListView?.setPost(posts: arrPosts)
            return
        }
        
        // fitler the text based on title and body
        let arrFiltered = arrPosts.filter { post in
            if post.title!.localizedCaseInsensitiveContains(text) ||
                post.body!.localizedCaseInsensitiveContains(text) {
                return true
            }
            return false
        }
        
        // Update the view!
        if arrFiltered.isEmpty {
            self.postListView?.setEmptyPost()
        } else {
            self.postListView?.setPost(posts: arrFiltered)
        }
        
    }
    
}


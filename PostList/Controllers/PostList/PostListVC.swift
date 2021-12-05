//
//  PostListVC.swift
//  PostList
//
//  Created by DY on 05/12/21.
//  Copyright © 2021 DY. All rights reserved.
//

import Foundation
import UIKit

class PostListVC: UIViewController, StoryboardSceneBased {
    
    static var sceneStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    @IBOutlet weak var tableView: UITableView!
    
    private lazy var dataSource = makeDataSource()
    
    private lazy var presenter = PostListPresenter(service: PostListService())
    
    /// Search controller to help us with filtering.
    private var searchController: UISearchController!
    
    enum Section: CaseIterable {
        case all
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load data
        presenter.attachView(view: self)
        presenter.getPosts()
        
        // Set the tableView
        tableView.register(cellType: PostListTVCell.self)
        tableView.dataSource = dataSource
        dataSource.defaultRowAnimation = .fade
        tableView.delegate = self
        
        // Set the UISearchController
        setSearchController()
        
    }
    
    deinit {
        print("🗑 PostList is gone!")
    }

    func setSearchController() {
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.autocapitalizationType = .none
        searchController.obscuresBackgroundDuringPresentation = false // The default is true.
        searchController.searchBar.placeholder = "Search for Title & Subtitle"
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false // Make the search bar always visible.
        
    }
    
    func makeDataSource() -> UITableViewDiffableDataSource<Section, Post> {
        
        return UITableViewDiffableDataSource(tableView: tableView,
                                             cellProvider: { tableView, indexPath, post in
            
            let cell: PostListTVCell = tableView.dequeueReusableCell(for: indexPath)
            cell.post = post
            return cell
            
        })
        
    }
    
}

// MARK: UITableViewDelegate Methods
extension PostListVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        defer {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
        if let objPost = dataSource.itemIdentifier(for: indexPath) {
            // TODO: push to the detail screen and also pass the selected post object.
            let objVC = PostDetailVC.instantiate()
            objVC.post = objPost
            self.navigationController?.pushViewController(objVC, animated: true)
        }
        
    }
    
}

// MARK: PostListView Methods
extension PostListVC: PostListView {
    
    func showError(text: String) {
        // Display an alert on the screen!
        tableView.isHidden = true
        showAlert(with: text)
    }
    
    func startLoading() {
        // show loading indicator
        tableView.isHidden = true
    }
    
    func finishLoading() {
        // hide loading indicator
        tableView.isHidden = false
    }
    
    func setPost(posts: [Post]) {
        // reload the table view with new post datasource
        tableView.isHidden = false
        DispatchQueue.main.async {
            
            var snapshot = NSDiffableDataSourceSnapshot<Section, Post>()
            snapshot.appendSections(Section.allCases)
            Section.allCases.enumerated().forEach { (index, section) in
                snapshot.appendItems(posts, toSection: section)
            }
            self.dataSource.apply(snapshot, animatingDifferences: true)
            
        }
        
    }
    
    func setEmptyPost() {
        // show empty tableView
        tableView.isHidden = true
    }
    
    // Present an alert with a given message.
    public func showAlert(with message: String) {
        let alertController = UIAlertController(title: "Something unexpected happens!",
                                                message: message,
                                                preferredStyle: .alert)

        alertController.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
}

// MARK: UISearchResultsUpdating Methods
extension PostListVC: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        // Strip out all the leading and trailing spaces.
        let strippedString = searchController.searchBar.text!.trimmingCharacters(in: CharacterSet.whitespaces)
        print(strippedString)
        presenter.searchPosts(text: strippedString)
        
    }
    
}

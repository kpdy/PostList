//
//  PostDetailVC.swift
//  PostList
//
//  Created by DY on 05/12/21.
//  Copyright © 2021 DY. All rights reserved.
//

import Foundation
import UIKit

class PostDetailVC: UIViewController, StoryboardSceneBased {
    
    static var sceneStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    @IBOutlet weak var tableView: UITableView!
    
    public var post: Post!
    
    private lazy var dataSource = makeDataSource()
    
    private lazy var presenter = PostDetailPresenter(service: PostDetailService())
    
    /// Search controller to help us with filtering.
    private var searchController: UISearchController!
    
    enum Section: CaseIterable {
        case post
        case comment
        case noComment
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Detail"
        
        // load data
        presenter.attachView(view: self)
        presenter.getComments(postId: post.id ?? 1)
        
        // set search controller
        setSearchController()
        
        // set tableView
        tableView.register(cellType: PostListTVCell.self)
        tableView.register(cellType: CommentsTVCell.self)
        tableView.register(cellType: EmptyTVCell.self)
//        tableView.sectionHeaderTopPadding = 0
        tableView.dataSource = dataSource
        dataSource.defaultRowAnimation = .fade
        tableView.delegate = self
        
    }
    
    func setSearchController() {
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.autocapitalizationType = .none
        searchController.obscuresBackgroundDuringPresentation = false // The default is true.
        searchController.searchBar.placeholder = "Search in Comments..."
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false // Make the search bar always visible.
        
    }
    
    deinit {
        print("🗑 PostDetailVC")
    }
    
    func makeDataSource() -> UITableViewDiffableDataSource<Section, DetailsViewModel> {
        
        return UITableViewDiffableDataSource(tableView: tableView,
                                             cellProvider: { tableView, indexPath, cellViewModel in
            
            switch cellViewModel {
            case .post(let post):
                let cell: PostListTVCell = tableView.dequeueReusableCell(for: indexPath)
                cell.accessoryType = .none
                cell.post = post
                return cell
                
            case .comment(let comment):
                let cell: CommentsTVCell = tableView.dequeueReusableCell(for: indexPath)
                cell.comment = comment
                return cell
                
            case .noComment:
                let cell: EmptyTVCell = tableView.dequeueReusableCell(for: indexPath)
                return cell
            }
            
        })
        
    }
    
}

// MARK: UITableViewDelegate Methods
extension PostDetailVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            let aView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 44.0))
            let lablel = UILabel()
            lablel.textColor = UIColor.label
            lablel.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            lablel.text = "Comments"
            lablel.textAlignment = .center
            lablel.font = UIFont.boldSystemFont(ofSize: 15.0)
            aView.backgroundColor = UIColor.systemGroupedBackground
            aView.addSubview(lablel)
            return aView
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 44.0
        }
        return 0.0
    }
    
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        CGFloat.leastNormalMagnitude
//    }
//
//    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        return nil
//    }
    
}

// MARK: UISearchResultsUpdating Methods
extension PostDetailVC: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        // Strip out all the leading and trailing spaces.
        let strippedString = searchController.searchBar.text!.trimmingCharacters(in: CharacterSet.whitespaces)
        presenter.searchComments(text: strippedString)
        
    }
    
}

// MARK: PostDetailView Methods
extension PostDetailVC: PostDetailView {
    
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
    
    func setComment(comments: [Comment]) {
        // reload the table view with new post datasource
        
        DispatchQueue.main.async {
            
            var snapshot = NSDiffableDataSourceSnapshot<Section, DetailsViewModel>()
            snapshot.appendSections(Section.allCases)
            snapshot.appendItems([DetailsViewModel.post(self.post!)], toSection: .post)
            if comments.isEmpty {
                snapshot.appendItems([DetailsViewModel.noComment(NoComments())], toSection: .noComment)
            } else {
                let commentsVM = comments.map { DetailsViewModel.comment($0) }
                snapshot.appendItems(commentsVM, toSection: .comment)
            }
            self.dataSource.apply(snapshot, animatingDifferences: true)
            
        }
        
        tableView.isHidden = false
        
    }
    
    func setEmptyPost() {
        // show empty tableView
        tableView.isHidden = true
    }
    
    // Present an alert with a given message.
    public func showAlert(with message: String) {
        let alertController = UIAlertController(title: "Oops!",
                                                message: message,
                                                preferredStyle: .alert)

        alertController.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
}

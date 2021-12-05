//
//  PostListTVCell.swift
//  PostList
//
//  Created by DY on 05/12/21.
//  Copyright © 2021 DY. All rights reserved.
//

import Foundation
import UIKit

class PostListTVCell: UITableViewCell, NibReusable {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    
    var post: Post? {
        didSet {
            setData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func setData() {
        
        lblTitle.text = post?.title
        lblSubTitle.text = post?.body
        
    }
    
}

//
//  CommentsTVCell.swift
//  PostList
//
//  Created by DY on 05/12/21.
//  Copyright © 2021 DY. All rights reserved.
//

import Foundation
import UIKit

class CommentsTVCell: UITableViewCell, NibReusable {
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblComments: UILabel!
    
    var comment: Comment? {
        didSet {
            setData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.systemGroupedBackground
    }
    
    private func setData() {
        
        lblName.text = comment?.name
        lblEmail.text = comment?.email
        lblComments.text = comment?.body
        
    }
    
}

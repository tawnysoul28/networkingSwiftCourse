//
//  PostTableViewCell.swift
//  Networking
//
//  Created by Асанцев Владимир Дмитриевич on 09.01.2022.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var postBodyLabel: UILabel!
    
    func configure(_ post: Post) {
        postTitleLabel.text = post.title
        postBodyLabel.text = post.body
    }
}

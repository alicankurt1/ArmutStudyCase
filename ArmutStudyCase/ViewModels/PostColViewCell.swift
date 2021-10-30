//
//  PostColViewCell.swift
//  ArmutStudyCase
//
//  Created by Alican Kurt on 30.10.2021.
//

import UIKit

class PostColViewCell: UICollectionViewCell {
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var postCategoryLabel: UILabel!
    @IBOutlet weak var postTitleLabel: UILabel!
    
    public func configurePostCell(withPostInfo postInfo: Posts){
        postImageView.image = UIImage(named: "header")
        postCategoryLabel.text = postInfo.category
        postTitleLabel.text = postInfo.title
    }
    
}

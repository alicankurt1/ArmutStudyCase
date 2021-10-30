//
//  PostColViewCell.swift
//  ArmutStudyCase
//
//  Created by Alican Kurt on 30.10.2021.
//

import UIKit
import SDWebImage

class PostColViewCell: UICollectionViewCell {
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var postCategoryLabel: UILabel!
    @IBOutlet weak var postTitleLabel: UILabel!
    
    public func configurePostCell(withPostInfo postInfo: Posts){
        DispatchQueue.main.async {
            self.postImageView.sd_setImage(with: URL(string: postInfo.image_url))
        }
        postCategoryLabel.text = postInfo.category
        postTitleLabel.text = postInfo.title
    }
    
}

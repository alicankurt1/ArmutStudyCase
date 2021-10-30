//
//  PopularColViewCell.swift
//  ArmutStudyCase
//
//  Created by Alican Kurt on 30.10.2021.
//

import UIKit
import SDWebImage

class PopularColViewCell: UICollectionViewCell {
    @IBOutlet weak var popularImageView: UIImageView!
    @IBOutlet weak var popularTitleLabel: UILabel!
    
    
    public func configurePopularCell(withPopularInfo popularInfo: Popular){
        DispatchQueue.main.async {
            self.popularImageView.sd_setImage(with: URL(string: popularInfo.image_url))
        }
        popularTitleLabel.text = popularInfo.name
    }
    
}

//
//  PopularColViewCell.swift
//  ArmutStudyCase
//
//  Created by Alican Kurt on 30.10.2021.
//

import UIKit

class PopularColViewCell: UICollectionViewCell {
    @IBOutlet weak var popularImageView: UIImageView!
    @IBOutlet weak var popularTitleLabel: UILabel!
    
    
    public func configurePopularCell(withPopularInfo popularInfo: Popular){
        popularImageView.image = UIImage(named: "header")
        popularTitleLabel.text = popularInfo.name
    }
    
}

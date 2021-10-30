//
//  ServiceCollectionViewCell.swift
//  ArmutStudyCase
//
//  Created by Alican Kurt on 30.10.2021.
//

import UIKit

class ServiceColViewCell: UICollectionViewCell {
    
    @IBOutlet weak var serviceImageView: UIImageView!
    @IBOutlet weak var serviceNameLabel: UILabel!
    
    
    public func configureServiceCell(withServiceInfo serviceInfo: Service){
        serviceImageView.image = UIImage(named: "tamir")
        serviceNameLabel.text = serviceInfo.name
    }
    
    
    
}

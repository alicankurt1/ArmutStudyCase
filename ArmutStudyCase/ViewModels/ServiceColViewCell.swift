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
    
    let serviceNameArray: [String:String] = [
        "Tadilat": "tadilat",
        "Temizlik": "temizlik",
        "Nakliyat": "nakliyat",
        "Tamir": "tamir",
        "Özel Ders": "ozel_ders",
        "Sağlık Eğitimi": "saglik",
        "Düğün Organizasyon": "dugun",
        "Diğer": "diger"
    ]
    
    public func configureServiceCell(withServiceInfo serviceInfo: Service){
        guard let imageName = serviceNameArray["\(serviceInfo.name)"] else{
            return
        }
        serviceImageView.image = UIImage(named: "\(imageName)")
        serviceNameLabel.text = serviceInfo.name
    }
    
    
    
}

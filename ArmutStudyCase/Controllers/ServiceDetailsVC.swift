//
//  ServiceDetailsVC.swift
//  ArmutStudyCase
//
//  Created by Alican Kurt on 30.10.2021.
//

import UIKit
import SDWebImage

class ServiceDetailsVC: UIViewController {
    @IBOutlet weak var serviceImageView: UIImageView!
    @IBOutlet weak var serviceNameLabel: UILabel!
    
    @IBOutlet weak var prosLabel: UILabel!
    @IBOutlet weak var avarageLabel: UILabel!
    @IBOutlet weak var lasMonthCompletedLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarController?.tabBar.isHidden = true
        getServiceDetailsJsonData()
    }
    
    
    private func getServiceDetailsJsonData(){
        let url = URL(string: "https://my-json-server.typicode.com/engincancan/case/service")!
        JsonWebService.shared.downloadServiceDetailsJsonData(withUrl: url) {[weak self] result in
            switch result{
            case .success(let serviceDetailsJsonData):
                
                guard let strongSelf = self,
                      let serviceDetailsData = serviceDetailsJsonData as? [ServiceDetailsModel],
                      let serviceId = ServiceInfo.shared.choosenServiceId as? Int else{
                          return
                      }
                print(serviceId)
                for serviceDetails in serviceDetailsData{
                    if serviceDetails.service_id == serviceId{
                        strongSelf.assignToComponents(serviceDetails: serviceDetails)
                        break
                    }
                }
            case .failure(let error):
                print("Failed to get serviceDetailsJsonData Error: \(error)")
            }
        }
    }
    
    private func assignToComponents(serviceDetails: ServiceDetailsModel){
        
        DispatchQueue.main.async {
            self.serviceImageView.sd_setImage(with: URL(string: serviceDetails.image_url))
            self.serviceNameLabel.text = serviceDetails.name
            self.prosLabel.text = "\(serviceDetails.pro_count) pros near you"
            self.avarageLabel.text = "\(serviceDetails.average_rating) avarage rating"
            self.lasMonthCompletedLabel.text = "Last month \(serviceDetails.completed_jobs_on_last_month) \(serviceDetails.name) job completed"
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
    }
    



}

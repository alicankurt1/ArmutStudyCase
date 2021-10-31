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
        guard let serviceId = ServiceInfo.shared.choosenServiceId as? Int else{
            return
        }
        let url = URL(string: "https://my-json-server.typicode.com/engincancan/case/service/\(serviceId)")!
        JsonWebService.shared.downloadServiceDetailsJsonData(withUrl: url) {[weak self] result in
            guard let strongSelf = self else{
                return
            }
            switch result{
            case .success(let serviceDetailsJsonData):
                guard let serviceDetailsData = serviceDetailsJsonData as? ServiceDetailsModel else{
                    return
                }
                strongSelf.assignToComponents(serviceDetails: serviceDetailsData)
            case .failure(let error):
                print("Failed to get serviceDetailsJsonData Error: \(error)")
                DispatchQueue.main.async {
                    strongSelf.makeAlertToDidntDownloadJson()
                }
            }
        }
    }
    
    private func assignToComponents(serviceDetails: ServiceDetailsModel){
        DispatchQueue.main.async {
            self.serviceImageView.sd_setImage(with: URL(string: serviceDetails.image_url))
            self.serviceNameLabel.text = serviceDetails.name
            self.prosLabel.text = "\(serviceDetails.pro_count)"
            self.avarageLabel.text = "\(serviceDetails.average_rating)"
            self.lasMonthCompletedLabel.text = "Last month \(serviceDetails.completed_jobs_on_last_month) \(serviceDetails.name) job completed"
        }
    }
    
    private func makeAlertToDidntDownloadJson(){
        let alert = UIAlertController(title: "404 Not Found", message: "The Service Details could not be loaded successfully", preferredStyle: .alert)
        let retry = UIAlertAction(title: "Retry", style: .default) { [weak self] _ in
            guard let strongSelf = self else{
                return
            }
            strongSelf.getServiceDetailsJsonData()
        }
        let backToHomePage = UIAlertAction(title: "Back", style: .cancel) { [weak self] _ in
            guard let strongSelf = self else{
                return
            }
            strongSelf.navigationController?.popViewController(animated: true)
        }
        alert.addAction(retry)
        alert.addAction(backToHomePage)
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
    }
    



}

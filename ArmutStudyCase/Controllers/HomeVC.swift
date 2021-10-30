//
//  ViewController.swift
//  ArmutStudyCase
//
//  Created by Alican Kurt on 30.10.2021.
//

import UIKit

class HomeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getHomeJsonData()
    }
    
    /// Get Home Json Data
    private func getHomeJsonData(){
        let url = URL(string: "https://my-json-server.typicode.com/engincancan/case/home")!
        JsonWebService.shared.downloadHomeJsonData(withUrl: url) { result in
            switch result{
            case .success(let homeJsonData):
                print(homeJsonData)
            case .failure(let error):
                print("Failed to get HomeJsonData Error: \(error)")
            }
        }
    }

}


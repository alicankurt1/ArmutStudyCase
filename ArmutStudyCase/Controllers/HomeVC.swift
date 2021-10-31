//
//  ViewController.swift
//  ArmutStudyCase
//
//  Created by Alican Kurt on 30.10.2021.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet weak var discountImageView: UIImageView!
    @IBOutlet weak var servicesColView: UICollectionView!
    @IBOutlet weak var popularColView: UICollectionView!
    @IBOutlet weak var postsColView: UICollectionView!
    
    private var homeJsonModel: HomeJsonModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        assignDelegates()
        getHomeJsonData()
    }
    
    /// Assign essential delegates
    private func assignDelegates(){
        discountImageView.isUserInteractionEnabled = true
        let discountRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedDiscountView))
        discountImageView.addGestureRecognizer(discountRecognizer)
        
        servicesColView.delegate = self
        servicesColView.dataSource = self
        popularColView.delegate = self
        popularColView.dataSource = self
        postsColView.delegate = self
        postsColView.dataSource = self
    }
    
    /// Get Home Json Data
    private func getHomeJsonData(){
        let url = URL(string: "https://my-json-server.typicode.com/engincancan/case/home")!
        JsonWebService.shared.downloadHomeJsonData(withUrl: url) {[weak self] result in
            guard let strongSelf = self else{
                return
            }
            switch result{
            case .success(let homeJsonData):
                strongSelf.homeJsonModel = homeJsonData
                DispatchQueue.main.async {
                    strongSelf.servicesColView.reloadData()
                    strongSelf.popularColView.reloadData()
                    strongSelf.postsColView.reloadData()
                }
            case .failure(let error):
                print("Failed to get HomeJsonData Error: \(error)")
                DispatchQueue.main.async {
                    strongSelf.makeAlertToDidntDownloadJson()
                }
                
            }
        }
    }
    
    /// Tapped Discount Image View and Go to Service Details Page with ServiceId ( Wedding )
    @objc private func tappedDiscountView(){
        let dugunId = 59
        ServiceInfo.shared.choosenServiceId = dugunId
        performSegue(withIdentifier: "toServiceDetailsVC", sender: nil)
    }
    
    /// Make Alert If Json file didn't download
    private func makeAlertToDidntDownloadJson(){
        let alert = UIAlertController(title: "404 Not Found", message: "The homepage could not be loaded successfully", preferredStyle: .alert)
        let retry = UIAlertAction(title: "Retry", style: .default) { [weak self] _ in
            guard let strongSelf = self else{
                return
            }
            strongSelf.getHomeJsonData()
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(retry)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
}


// MARK: Extension HomeVC -> Collection View Operations
extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    /// Return number of array
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let homeJsonModel = homeJsonModel{
            switch collectionView{
            case self.servicesColView:
                return homeJsonModel.all_services.count
            case self.popularColView:
                return homeJsonModel.popular.count
            case self.postsColView:
                return homeJsonModel.posts.count
            default:
                return 0
            }
        }else{
            return 0
        }

    }
    
    /// Assign variables to related cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let homeJsonModel = homeJsonModel{
            switch collectionView{
            case self.servicesColView:
                guard let serviceInfo = homeJsonModel.all_services[indexPath.row] as? Service else{
                    return UICollectionViewCell()
                }
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "serviceColCell", for: indexPath) as! ServiceColViewCell
                cell.configureServiceCell(withServiceInfo: serviceInfo)
                return cell
            case self.popularColView:
                guard let popularInfo = homeJsonModel.popular[indexPath.row] as? Popular else{
                    return UICollectionViewCell()
                }
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "popularColCell", for: indexPath) as! PopularColViewCell
                cell.configurePopularCell(withPopularInfo: popularInfo)
                return cell
            case self.postsColView:
                guard let postInfo = homeJsonModel.posts[indexPath.row] as? Posts else{
                    return UICollectionViewCell()
                }
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "postColCell", for: indexPath) as! PostColViewCell
                cell.configurePostCell(withPostInfo: postInfo)
                return cell
            default:
                return UICollectionViewCell()
            }

        }else{
            return UICollectionViewCell()
        }
    }
    
    /// What to do when a cell is selected
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let homeJsonModel = homeJsonModel{
            switch collectionView{
            case self.servicesColView:
                /// Go to ServiceDetailsVC with Service_id
                ServiceInfo.shared.choosenServiceId = homeJsonModel.all_services[indexPath.row].service_id
                performSegue(withIdentifier: "toServiceDetailsVC", sender: nil)
            case self.popularColView:
                /// Go to ServiceDetailsVC with Service_id
                ServiceInfo.shared.choosenServiceId = homeJsonModel.popular[indexPath.row].service_id
                performSegue(withIdentifier: "toServiceDetailsVC", sender: nil)
            case self.postsColView:
                /// Go to Web Browser         
                let link = homeJsonModel.posts[indexPath.row].link
                if let url = URL(string: link){
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    } else {
                        UIApplication.shared.openURL(url)
                    }
                }
            default:
                print("Failed to didSelecItemAt in Switch Case")
            }
        }
    }
    
}


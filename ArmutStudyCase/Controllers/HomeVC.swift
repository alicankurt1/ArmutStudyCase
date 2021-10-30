//
//  ViewController.swift
//  ArmutStudyCase
//
//  Created by Alican Kurt on 30.10.2021.
//

import UIKit

class HomeVC: UIViewController {
    
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
            switch result{
            case .success(let homeJsonData):
                guard let strongSelf = self else{
                    return
                }
                strongSelf.homeJsonModel = homeJsonData
                DispatchQueue.main.async {
                    strongSelf.servicesColView.reloadData()
                    strongSelf.popularColView.reloadData()
                    strongSelf.postsColView.reloadData()
                }
            case .failure(let error):
                print("Failed to get HomeJsonData Error: \(error)")
            }
        }
    }
    
}

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
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
    
    
}


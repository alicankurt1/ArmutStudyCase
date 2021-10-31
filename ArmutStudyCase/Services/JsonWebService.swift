//
//  JsonWebService.swift
//  ArmutStudyCase
//
//  Created by Alican Kurt on 30.10.2021.
//

import Foundation

// MARK: Download Json files from Web

// Json Web Service Singleton Class
class JsonWebService{
    static let shared = JsonWebService()
}


// Download /home.json from Web and assignment HomeJsonModel
extension JsonWebService{
    
    /// Download Json Data using URLSession and return HomeJsonModel or Error
    public func downloadHomeJsonData(withUrl url: URL, completion: @escaping (Result<HomeJsonModel, Error>) -> Void){
        URLSession.shared.dataTask(with: url) { data, urlResponse, error in
            guard error == nil else{
                completion(.failure(JsonWebServiceError.FailedToGetFromURLSession))
                return
            }
            if let data = data {
                do {
                    let homeJsonList = try JSONDecoder().decode(HomeJsonModel.self, from: data)
                    completion(.success(homeJsonList))
                } catch{
                    completion(.failure(JsonWebServiceError.FailedToGetFromJSONDecoder))
                }
            }
        }.resume()
    }
    
}


extension JsonWebService{
    /// Download Json Data using URLSession and return [ServiceDetailsModel] or Error
    public func downloadServiceDetailsJsonData(withUrl url: URL, completion: @escaping (Result<ServiceDetailsModel, Error>) -> Void){
        URLSession.shared.dataTask(with: url) { data, urlResponse, error in
            guard error == nil else{
                completion(.failure(JsonWebServiceError.FailedToGetFromURLSession))
                return
            }
            if let data = data {
                do {
                    let serviceDetailsJsonList = try JSONDecoder().decode(ServiceDetailsModel.self, from: data)
                    completion(.success(serviceDetailsJsonList))
                } catch{
                    completion(.failure(JsonWebServiceError.FailedToGetFromJSONDecoder))
                }
            }
        }.resume()
    }
}

// Json Web Service Errors
enum JsonWebServiceError: Error{
    case FailedToGetFromURLSession
    case FailedToGetFromJSONDecoder
}

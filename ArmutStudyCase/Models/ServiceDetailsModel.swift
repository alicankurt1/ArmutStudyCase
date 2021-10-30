//
//  ServiceJsonModel.swift
//  ArmutStudyCase
//
//  Created by Alican Kurt on 30.10.2021.
//

import Foundation


struct ServiceDetailsModel: Decodable{
    let id: Int
    let service_id: Int
    let name: String
    let long_name: String
    let image_url: String
    let pro_count: Int
    let average_rating: Float
    let completed_jobs_on_last_month: Int
}

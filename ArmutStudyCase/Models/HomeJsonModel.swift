//
//  HomeJsonModel.swift
//  ArmutStudyCase
//
//  Created by Alican Kurt on 30.10.2021.
//

import Foundation

/*
{
  "all_services": [
    {
     Service
    }
  ],
  "popular": [
    {
      Popular
    }
  ],
  "posts": [
    {
      Posts
    }
  ]
}*/

/// Home Json Struct includes All Fields in Home Json File
struct HomeJsonModel: Decodable{
    let all_services: [Service]
    let popular: [Popular]
    let posts: [Posts]
}

/// Service Details Struct
struct Service: Decodable{
    let id: Int
    let service_id: Int
    let name: String
    let long_name: String
    let image_url: String?
    let pro_count: Int?
}

/// Popular Services' Details Struct
struct Popular: Decodable{
    let id: Int
    let service_id: Int
    let name: String
    let long_name: String
    let image_url: String
    let pro_count: Int
}

/// Post Details Struct
struct Posts: Decodable{
    let link: String
    let title: String
    let category: String
    let image_url: String
}

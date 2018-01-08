//
//  JSONData.swift
//  CustomJSONtoPractice
//
//  Created by EthanLin on 2018/1/8.
//  Copyright © 2018年 EthanLin. All rights reserved.
//

import Foundation

struct JSONData: Codable {
    var websites:[Website]
    
    
    
    struct Website: Codable {
//        init(json: [String: Any]) {
//            image = json["image"] as! String
//            title = json["title"] as! String
//            webAddress = json["webAddress"] as! String
//        }
        var image:String
        var title:String
        var webAddress:String
    }
}

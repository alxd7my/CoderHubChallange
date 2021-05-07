//
//  CobonList.swift
//  LaundryProject
//
//  Created by  ALxD7MY on 07/05/2021.
//

import Foundation

class CobonList: NSObject {
    @objc var name: String?
    @objc var date: String?
    var discount: Double?
    
    init(dic: [String: Any]) {
        self.name = dic["name"] as? String
        self.date = dic["date"] as? String
        self.discount = dic["discount"] as? Double
    }
}

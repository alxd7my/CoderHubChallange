//
//  ItemsList.swift
//  LaundryProject
//
//  Created by  ALxD7MY on 05/05/2021.
//

import UIKit

class ItemsList: NSObject {
    
    @objc var name: String?
    @objc var id: String?
    @objc var details: String?
    @objc var img: String?
    @objc var category: String?
    
    var count: Int?
    var price: Double?
    var statusCode: Int?

    init(dic: [String: Any]) {
        self.name = dic["name"] as? String
        self.id = dic["id"] as? String
        self.details = dic["details"] as? String
        self.img = dic["img"] as? String
        self.price = dic["price"] as? Double
        self.statusCode = dic["statusCode"] as? Int
        self.category = dic["category"] as? String
        self.count = dic["count"] as? Int
    }
}

class OrderList: NSObject {
    
    @objc var name: String?
    @objc var id: String?
    @objc var details: String?
    @objc var img: String?
    @objc var category: String?
    @objc var userID: String?
    @objc var cobonName: String?
    var discount: Double?

    var count: Int?
    var price: Double?
    var statusCode: Int?

    init(dic: [String: Any]) {
        self.name = dic["name"] as? String
        self.id = dic["id"] as? String
        self.details = dic["details"] as? String
        self.img = dic["img"] as? String
        self.price = dic["price"] as? Double
        self.statusCode = dic["statusCode"] as? Int
        self.category = dic["category"] as? String
        self.userID = dic["userID"] as? String
        self.cobonName = dic["cobonName"] as? String
        self.discount = dic["discount"] as? Double
        self.count = dic["count"] as? Int

    }
    
}

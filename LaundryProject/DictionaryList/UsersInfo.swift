//
//  UsersInfo.swift
//  LaundryProject
//
//  Created by  ALxD7MY on 05/05/2021.
//

import Foundation


class UsersInfo: NSObject {
    @objc var firstName: String?
    @objc var lastName: String?
    @objc var email: String?
    @objc var uid: String?
    @objc var deviceNotificationID: String?
    var credit: Double?
    @objc var phoneNumber: String?
    
    init(dic: [String: Any]) {
        self.firstName = dic["firstName"] as? String
        self.lastName = dic["lastName"] as? String
        self.email = dic["email"] as? String
        self.uid = dic["uid"] as? String
        self.deviceNotificationID = dic["deviceNotificationID"] as? String
        self.credit = dic["credit"] as? Double
        self.phoneNumber = dic["phoneNumber"] as? String

    }
}

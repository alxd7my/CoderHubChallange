//
//  DateExtention.swift
//  shalehat
//
//  Created by  ALxD7MY on 07/05/2021.
//  Copyright © 2021 alxd7my. All rights reserved.
//

import Foundation
import UIKit

extension Date {
    static func getDates(forLastNDays nDays: Int) -> [String] {
        let cal = NSCalendar.current
        var date = cal.startOfDay(for: Date())

        var arrDates = [String]()

        for _ in 1 ... nDays {
            if nDays == 1 {
                date = cal.date(byAdding: Calendar.Component.day, value: 0, to: date)!
            } else {
                date = cal.date(byAdding: Calendar.Component.day, value: -1, to: date)!
            }
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyy"
            let dateString = dateFormatter.string(from: date)
            
            let time = NSNumber(value: Int(NSDate().timeIntervalSince1970))
            let second = Double(truncating: time)
            let timeStamp = NSDate(timeIntervalSince1970: second)

            let lastDayList = dateFormatter.string(from: timeStamp as Date)
            arrDates.append(dateString)

            
            arrDates.append(lastDayList)
        }
        return arrDates
    }
}

//
//  extintions.swift
//  LaundryProject
//
//  Created by  ALxD7MY on 04/05/2021.
//

import UIKit


extension UIColor {
    static func rgb(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        return UIColor(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}

let mainColorForApp =  UIColor(red: 166/255, green: 148/255, blue: 129/255, alpha: 1)

//
//  ImageExtension.swift
//  LaundryProject
//
//  Created by  ALxD7MY on 05/05/2021.
//

import Foundation
import UIKit

let imgCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    func urlToImage(_ urlString: String) {
        
        self.image = nil
        if let img = imgCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = img
            return
        }
        
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if error == nil {
                DispatchQueue.main.async(execute: {
                    if let img = UIImage(data: data!) {
                        imgCache.setObject(img, forKey: urlString as AnyObject)
                        self.image = img
                    }
                })
            }
        }).resume()
    }
    
}



//
//  ViewAnimation.swift
//  LaundryProject
//
//  Created by  ALxD7MY on 07/05/2021.
//

import Foundation
import UIKit

extension UIView {
func animationZoom(scaleX: CGFloat, y: CGFloat) {
    UIView.animate(withDuration: 0.4) {
        self.transform = CGAffineTransform(scaleX: scaleX, y: y)
    }
}

func animationRoted(angle : CGFloat) {
    self.transform = self.transform.rotated(by: angle)
}
}

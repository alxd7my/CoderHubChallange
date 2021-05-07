//
//  MyAlertView.swift
//  LaundryProject
//
//  Created by  ALxD7MY on 04/05/2021.
//

import UIKit
import Lottie

class MyAlertView: UIView {

    var text: String?
    var type: MyAlertTypes!
    var alertViewCenterY: NSLayoutConstraint?

    let backView: UIView = {
       let v = UIView()
        v.backgroundColor = UIColor(white: 0, alpha: 0.4)
        v.translatesAutoresizingMaskIntoConstraints = false
        
        return v
    }()
    
    let alertView: UIView = {
       let v = UIView()
        v.backgroundColor = .white
        v.translatesAutoresizingMaskIntoConstraints = false
        v.layer.cornerRadius = 20
        v.backgroundColor = mainColorForApp

        return v
    }()
    
    let alertText: UILabel = {
       let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 14)
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textAlignment = .center
        l.numberOfLines = 5
        return l
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        addSubview(backView)
        backView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        backView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        backView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        backView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        addSubview(alertView)
        alertView.widthAnchor.constraint(equalTo: widthAnchor, constant: -40).isActive = true
        alertView.heightAnchor.constraint(equalTo: widthAnchor, constant: -40).isActive = true
        alertView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        alertViewCenterY = alertView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 2000)
        alertViewCenterY!.isActive = true
     
        setupAnimationLottiFiles()
        
    }
    var animationView: AnimationView?

    func setupAnimationLottiFiles() {
        animationView = AnimationView(animation: nil)
        animationView!.contentMode = .scaleAspectFill
        animationView!.frame = CGRect(x: (frame.width / 2) + 90, y: (frame.width / 2) + 20, width: 150, height: 150)
        alertView.addSubview(animationView!)
        
        alertView.addSubview(alertText)
        alertText.topAnchor.constraint(equalTo: animationView!.bottomAnchor, constant: 20).isActive = true
        alertText.widthAnchor.constraint(equalTo: alertView.widthAnchor, constant: -12).isActive = true
        alertText.heightAnchor.constraint(equalToConstant: 50).isActive = true
        alertText.centerXAnchor.constraint(equalTo: alertView.centerXAnchor).isActive = true
    }
    
    func playAnimationWithType(type: MyAlertTypes) {
        let animation: Animation?
        if type == .failure {
            animation = Animation.named("failure")
        } else {
            animation = Animation.named("success")
        }
        
        animationView!.animation = animation
        animationView!.play()
        
    }
    
    func startAnimationWithTime(_ t: Double) {
        playAnimationWithType(type: type)
        alertText.text = text
        
        UIView.animate(withDuration: 0.4) {
            self.alpha = 1
            self.alertViewCenterY!.constant = 0
            self.layoutIfNeeded()
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + t) {
            UIView.animate(withDuration: 0.37) {
                self.alpha = 1
                self.alertViewCenterY!.constant = 1000
                self.layoutIfNeeded()
            }
        }
    }

}


enum MyAlertTypes {
    case success, failure
}

//
//  LoginViewController.swift
//  LaundryProject
//
//  Created by  ALxD7MY on 04/05/2021.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var myStackView: UIStackView!
    @IBOutlet weak var backgroundImage: UIView!
    @IBOutlet weak var centerMyStack: NSLayoutConstraint!
    @IBOutlet weak var logoCenterPlace: UIView!
    @IBOutlet var labelOTP: UILabel!
    @IBOutlet var textFieldOTP: UITextField!
    @IBOutlet var textFieldNumber: UITextField!
    
    var logoImg = UIImageView()
    
    @IBOutlet var stackBackView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        UIApplication.shared.statusBarUIView?.backgroundColor = .white

        // Do any additional setup after loading the view.
        generalFunctionSetup()
        logoSetup()
        logoAnimation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillDisappear(animated)
    }

    func generalFunctionSetup() {
        stackBackView.frame = CGRect(x: 0, y: 1000, width: view.frame.width - 60, height: view.frame.width - 60)
        stackBackView.backgroundColor = UIColor(white: 1, alpha: 0.47)
        stackBackView.layer.cornerRadius = 30
        stackBackView.layer.borderColor = UIColor.black.cgColor
        stackBackView.layer.borderWidth = 0.8
                
        logoCenterPlace.alpha = 0
        centerMyStack.constant = 1000
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(endEtiting)))
        setupAlertView()
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        UIApplication.shared.statusBarUIView?.backgroundColor = .white
//
//    }
    
    @objc func endEtiting() {view.endEditing(true)}
    
    func logoSetup() {
        let height = view.frame.width * (479 / 1280)
        logoImg = UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: height))
        logoImg.center = view.center
        logoImg.image = UIImage(named: "laundryLogo")
        logoImg.contentMode = .scaleAspectFit
        view.addSubview(logoImg)
    }
    
    func logoAnimation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            UIView.animate(withDuration: 2) {
                self.logoImg.center = self.logoCenterPlace.center
                self.view.layoutIfNeeded()
                self.showMyStackView()
            }
        }
    }
    
    func showMyStackView() {
        UIView.animate(withDuration: 0.8) {
            self.centerMyStack.constant = 0
            self.view.layoutIfNeeded()
            self.stackBackView.center = self.myStackView.center
        }
    }
    
    @IBAction func singInBtn(_ sender: UIButton) {
        endEtiting()
        if textFieldNumber.text != "" && textFieldOTP.text != "" {
            Auth.auth().signIn(withEmail: textFieldNumber.text!, password: textFieldOTP.text!) { (auth, err) in
                if err != nil {
                    self.callAlertView(text: "تحقق من بيانات الدخول", type: .failure, time: 1.5)
                } else {
                    self.callAlertView(text: "مرحباً بك من جديد", type: .success, time: 1.5)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        self.dismiss(animated: true, completion: nil)
                    }
                }
            }
        } else {
            self.callAlertView(text: "يرجى تعبئة جميع البيانات", type: .failure, time: 1.5)
        }

    }
    
    // alert start
    
    let customAlertView = MyAlertView()

    func setupAlertView() {
        customAlertView.translatesAutoresizingMaskIntoConstraints = false
        customAlertView.alpha = 0
        
        view.addSubview(customAlertView)
        customAlertView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        customAlertView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        customAlertView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        customAlertView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func callAlertView(text: String, type: MyAlertTypes, time: Double) {
        customAlertView.text = text
        customAlertView.type = type
        customAlertView.alpha = 1
        customAlertView.startAnimationWithTime(time)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time + 0.3) {
            self.customAlertView.alpha = 0
            self.view.layoutIfNeeded()
        }
    }
    
    // alert end

}

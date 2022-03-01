//
//  RegisterViewController.swift
//  LaundryProject
//
//  Created by  ALxD7MY on 04/05/2021.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var firstName: UITextField!
    @IBOutlet var lastName: UITextField!
    @IBOutlet var phoneNumber: UITextField!
    @IBOutlet var email: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var confirmPassword: UITextField!
    @IBOutlet var approve: UISwitch!
    @IBOutlet var signup: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(endEtiting)))
//        UIApplication.shared.statusBarUIView?.backgroundColor = mainColorForApp

        setupAlertView()
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
        
    
    
    
    @objc func endEtiting() {view.endEditing(true)}

    
    @IBAction func signupAction(_ sender: UIButton) {
        checkFieldsIsEmpty()
    }
    
    
    func checkFieldsIsEmpty() {
        endEtiting()
        if firstName.text == "" || lastName.text == "" || email.text == "" || password.text == "" || confirmPassword.text == "" || !approve.isOn {

            callAlertView(text: "يرجي التأكد من تعبئة جميع الحقول الاجبارية والموافقة على الشروط والسياسات", type: .failure, time: 1.5)

        } else {
            if password.text != confirmPassword.text {
                callAlertView(text: "كلمة المرور غير مطابقة", type: .failure, time: 1.5)
            } else if !email.text!.lowercased().contains("@gmail.com") && !email.text!.lowercased().contains("@hotmail.com") && !email.text!.lowercased().contains("@yahoo.com") && !email.text!.lowercased().contains("@outlook.com") && !email.text!.lowercased().contains("@outlook.sa") && !email.text!.lowercased().contains("@icloud.com") && !email.text!.lowercased().contains("@icloud.sa") {
                callAlertView(text: "البريد الالكتروني غير صحيح", type: .failure, time: 1.5)
            } else {
                
                Auth.auth().createUser(withEmail: email.text!, password: password.text!) { (auth, err) in
                    if err != nil {
                        print("err")
                    } else {
                        self.updateValueToDatabase(auth!.user.uid)
                    }
                }
                
                callAlertView(text: "تم انشاء حسابك بنجاح اذهب الى صفحة تسجيل الدخول", type: .success, time: 1.5)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.6) {
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    func updateValueToDatabase(_ uid: String) {
        let values = ["firstName": firstName.text!, "lastName": lastName.text!, "email": email.text!, "uid": uid, "deviceNotificationID": "NOT YET", "credit": 0.0, "phoneNumber": phoneNumber.text!] as [String : Any]
        
        Firestore.firestore().collection("users").addDocument(data: values)
    }
    
}

//
//  CartViewController.swift
//  LaundryProject
//
//  Created by  ALxD7MY on 07/05/2021.
//

import UIKit
import Firebase

var discountCobon = 0.0
var discountPercint = 0.0
var coboonName = ""
var storeTotalPrice = 0.0

class CartViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate{
    
    var titleLabel = UILabel()
    let cartViewCellID = "cartViewCellID"
    var newList = [ItemsList]()
    let keyWindow = UIApplication.shared.keyWindow

    let underView: UnderView = {
       let v = UnderView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = mainColorForApp
        v.layer.cornerRadius = 46
        return v
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return tableView
    }()
    
    let isEmptyLabel: UILabel = {
         let b = UILabel()
            b.translatesAutoresizingMaskIntoConstraints = false
            b.text = "السلة فارغة !"
            b.textAlignment = .center
            b.numberOfLines = 1
            b.font = UIFont.systemFont(ofSize: 18)
            b.textColor = .lightGray
            b.alpha = 0
         return b
     }()
    
    let statusValue = UILabel()
    let dicountNumber = UILabel()
    let t = UITextField()
    let b = UIButton(type: .system)
    let cancellBtn = UIButton(type: .system)
    let changeBtn = UIButton(type: .system)

    var cobonList = [CobonList]()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        

        isEmptyLabelFunc()
        
        titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width / 2, height: view.frame.height))
        navigationController?.navigationBar.isTranslucent = false
        tableView.register(ItemsTableViewCell.self, forCellReuseIdentifier: cartViewCellID)

        titleLabel.text = "السلة"
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 18)
        navigationItem.titleView = titleLabel
        navigationItem.title = "السلة"

        reloadCartListWithRepateCount()
        
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tableView.heightAnchor.constraint(equalTo: view.heightAnchor, constant: -300).isActive = true
        
        tableView.addSubview(isEmptyLabel)
        isEmptyLabel.widthAnchor.constraint(equalTo: tableView.widthAnchor).isActive = true
        isEmptyLabel.heightAnchor.constraint(equalTo: tableView.heightAnchor).isActive = true
        isEmptyLabel.centerXAnchor.constraint(equalTo: tableView.centerXAnchor).isActive = true
        isEmptyLabel.centerYAnchor.constraint(equalTo: tableView.centerYAnchor).isActive = true
        
        view.addSubview(underView)
        underView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 20).isActive = true
        underView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        underView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        underView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        underView.layer.shadowColor = UIColor.white.cgColor
        underView.layer.shadowOpacity = 1
        underView.layer.shadowOffset = CGSize.zero
        underView.layer.shadowRadius = 10
        
        keyWindow!.addSubview(alertView)
        alertCenterLayOut = alertView.centerYAnchor.constraint(equalTo: keyWindow!.centerYAnchor, constant: 1500)
        alertCenterLayOut!.isActive = true
        alertView.centerXAnchor.constraint(equalTo: keyWindow!.centerXAnchor).isActive = true
        alertView.heightAnchor.constraint(equalToConstant: 280).isActive = true
        alertView.widthAnchor.constraint(equalTo: keyWindow!.widthAnchor, constant: -60).isActive = true
        
        underView.CodeView.addTarget(self, action: #selector(handleShowAndDisaapperAlert), for: .touchUpInside)
     
        setupAlertForDiscount()
        cobonObserver()
        collectItmesPrice()
        
        if coboonName != "" {
            underView.CodeView.setTitle("كوبون: \(coboonName), خصم: \(discountPercint)%", for: .normal)
            underView.CodeDiscount.text = "-\(String(format: "%.2f",storeTotalPrice * discountPercint)) ر.س"
        }

    }
    
    func isEmptyLabelFunc() {
        if cartList.isEmpty {
            isEmptyLabel.alpha = 1
        } else {
            isEmptyLabel.alpha = 0
        }
    }
    
    var alertIsHidden = true
    
    @objc func handleShowAndDisaapperAlert() {
        if alertIsHidden == true {
            UIView.animate(withDuration: 0.3) {
                self.alertBackView.alpha = 1
                self.alertCenterLayOut!.constant = -140
                self.keyWindow!.layoutIfNeeded()
            }
        } else {
            UIView.animate(withDuration: 0.3) {
                self.alertBackView.alpha = 0
                self.alertCenterLayOut!.constant = 1500
                self.keyWindow!.layoutIfNeeded()
            }
        }
        
        alertIsHidden = !alertIsHidden
        handleErrorAndClose()
    }
    
    @objc func handleErrorAndClose() {
        t.isEnabled = true
        changeBtn.isHidden = true
        
        t.textColor = .black
        endEditingFunc()
        statusValue.text = "لم يتم التحقق بعد"
        statusValue.textColor = .black
        dicountNumber.text = "0%"
        dicountNumber.textColor = .black
        t.text = ""
        t.layer.borderColor = UIColor.lightGray.cgColor
        b.setTitle("التحقق من الكوبون", for: .normal)
    }
    
    let alertBackView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor(white: 0.2, alpha: 0.3)
        v.alpha = 0
        return v
    }()
    
    let alertView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .white
        v.layer.cornerRadius = 20
        return v
    }()
    
    var alertCenterLayOut: NSLayoutConstraint?
    
    func setupAlertForDiscount() {
        keyWindow!.addSubview(alertBackView)
        alertBackView.frame = keyWindow!.frame
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.alpha = 0.5
        alertBackView.addSubview(blurEffectView)
        
        alertBackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleShowAndDisaapperAlert)))
        
        keyWindow!.addSubview(alertView)
        alertCenterLayOut = alertView.centerYAnchor.constraint(equalTo: keyWindow!.centerYAnchor, constant: 1500)
        alertCenterLayOut!.isActive = true
        alertView.centerXAnchor.constraint(equalTo: keyWindow!.centerXAnchor).isActive = true
        alertView.heightAnchor.constraint(equalToConstant: 280).isActive = true
        alertView.widthAnchor.constraint(equalTo: keyWindow!.widthAnchor, constant: -60).isActive = true
        
        
        alertView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(endEditingFunc)))
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "قم بإدخال كوبون الخصم"
        l.textAlignment = .center
        l.textColor = .darkGray
        l.font = UIFont.boldSystemFont(ofSize: 18)
        
        alertView.addSubview(l)
        l.topAnchor.constraint(equalTo: alertView.topAnchor, constant: 15).isActive = true
        l.widthAnchor.constraint(equalTo: alertView.widthAnchor).isActive = true
        l.heightAnchor.constraint(equalToConstant: 30).isActive = true
        l.centerXAnchor.constraint(equalTo: alertView.centerXAnchor).isActive = true
        
        t.translatesAutoresizingMaskIntoConstraints = false
        t.placeholder = "مثال: DIS37"
        t.textAlignment = .center
        t.layer.borderWidth = 1
        t.layer.borderColor = UIColor.lightGray.cgColor
        t.layer.cornerRadius = 10
        t.delegate = self
        
        alertView.addSubview(t)
        t.topAnchor.constraint(equalTo: l.bottomAnchor, constant: 20).isActive = true
        t.widthAnchor.constraint(equalTo: alertView.widthAnchor, constant: -60).isActive = true
        t.heightAnchor.constraint(equalToConstant: 30).isActive = true
        t.centerXAnchor.constraint(equalTo: alertView.centerXAnchor).isActive = true
        
        cancellBtn.translatesAutoresizingMaskIntoConstraints = false
        cancellBtn.setTitle("الغاء", for: .normal)
        cancellBtn.tintColor = .white
        cancellBtn.backgroundColor = UIColor.rgb(r: 171, g: 103, b: 25)
        cancellBtn.layer.cornerRadius = 10
        
        cancellBtn.addTarget(self, action: #selector(handleShowAndDisaapperAlert), for: .touchUpInside)

        alertView.addSubview(cancellBtn)
        cancellBtn.bottomAnchor.constraint(equalTo: alertView.bottomAnchor, constant: -15).isActive = true
        cancellBtn.widthAnchor.constraint(equalTo: alertView.widthAnchor, constant: -60).isActive = true
        cancellBtn.heightAnchor.constraint(equalToConstant: 35).isActive = true
        cancellBtn.centerXAnchor.constraint(equalTo: alertView.centerXAnchor).isActive = true
        
        
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitle("التحقق من الكوبون", for: .normal)
        b.tintColor = .white
        b.backgroundColor = mainColorForApp
        b.layer.cornerRadius = 10
        
        b.addTarget(self, action: #selector(cobonChecker), for: .touchUpInside)
        
        alertView.addSubview(b)
        b.bottomAnchor.constraint(equalTo: cancellBtn.topAnchor, constant: -8).isActive = true
        b.widthAnchor.constraint(equalTo: alertView.widthAnchor, constant: -60).isActive = true
        b.heightAnchor.constraint(equalToConstant: 35).isActive = true
        b.centerXAnchor.constraint(equalTo: alertView.centerXAnchor).isActive = true
        
        
        let statusText = UILabel()
        statusText.text = "حالة الكوبون :"
        statusText.translatesAutoresizingMaskIntoConstraints = false
        statusText.textAlignment = .right
        
        alertView.addSubview(statusText)
        statusText.rightAnchor.constraint(equalTo: t.rightAnchor).isActive = true
        statusText.widthAnchor.constraint(equalTo: t.widthAnchor, multiplier: 1/2).isActive = true
        statusText.topAnchor.constraint(equalTo: t.bottomAnchor, constant: 15).isActive = true
        statusText.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        let dicountText = UILabel()
        dicountText.text = "نسبة الخصم :"
        dicountText.translatesAutoresizingMaskIntoConstraints = false
        dicountText.textAlignment = .right
        
        alertView.addSubview(dicountText)
        dicountText.rightAnchor.constraint(equalTo: statusText.rightAnchor).isActive = true
        dicountText.widthAnchor.constraint(equalTo: statusText.widthAnchor).isActive = true
        dicountText.topAnchor.constraint(equalTo: statusText.bottomAnchor, constant: 6).isActive = true
        dicountText.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        
        statusValue.text = "لم يتم التحقق بعد"
        statusValue.translatesAutoresizingMaskIntoConstraints = false
        statusValue.textAlignment = .right
        
        alertView.addSubview(statusValue)
        statusValue.leftAnchor.constraint(equalTo: t.leftAnchor, constant: 16).isActive = true
        statusValue.widthAnchor.constraint(equalTo: t.widthAnchor, multiplier: 1/2, constant: 15).isActive = true
        statusValue.topAnchor.constraint(equalTo: t.bottomAnchor, constant: 15).isActive = true
        statusValue.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        dicountNumber.text = "0%"
        dicountNumber.translatesAutoresizingMaskIntoConstraints = false
        dicountNumber.textAlignment = .right
        
        alertView.addSubview(dicountNumber)
        dicountNumber.leftAnchor.constraint(equalTo: statusValue.leftAnchor).isActive = true
        dicountNumber.widthAnchor.constraint(equalTo: statusValue.widthAnchor).isActive = true
        dicountNumber.topAnchor.constraint(equalTo: statusValue.bottomAnchor, constant: 6).isActive = true
        dicountNumber.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        changeBtn.translatesAutoresizingMaskIntoConstraints = false
        changeBtn.setTitle("تغيير", for: .normal)
        changeBtn.addTarget(self, action: #selector(handleErrorAndClose), for: .touchUpInside)
        changeBtn.isHidden = true
        changeBtn.tintColor = .white
        changeBtn.backgroundColor = mainColorForApp
        changeBtn.layer.cornerRadius = 5
        
        
        alertView.addSubview(changeBtn)
        changeBtn.rightAnchor.constraint(equalTo: t.rightAnchor).isActive = true
        changeBtn.centerYAnchor.constraint(equalTo: t.centerYAnchor).isActive = true
        changeBtn.heightAnchor.constraint(equalTo: t.heightAnchor).isActive = true
        changeBtn.widthAnchor.constraint(equalToConstant: 40).isActive = true
    
        underView.btn.addTarget(self, action: #selector(sendOrder), for: .touchUpInside)
        
    }
    
    @objc func sendOrder() {
        let alert = UIAlertController(title: "ارسال الطلب", message: "تأكيد الطلب؟", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "الغاء", style: .cancel, handler: nil))
        let uid = Auth.auth().currentUser?.uid
        alert.addAction(UIAlertAction(title: "ارسال", style: .default, handler: { (action) in
            for i in self.newList {
                let value = ["name": i.name!, "id": i.id!, "statusCode": 0, "category": i.category!, "count": i.count!, "price": i.price!, "img": i.img!, "details": i.details!, "userID": uid!] as [String : Any]
                self.uploadOrderToFirestore(value: value)
            }
            
            DispatchQueue.main.async {
                self.newList.removeAll()
                cartList.removeAll()
                self.isEmptyLabelFunc()
                self.tableView.reloadData()
                self.collectItmesPrice()

            }
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    func uploadOrderToFirestore(value: [String: Any]) {
        let db = Firestore.firestore().collection("orders")
        db.addDocument(data: value) { (err) in
//            print(err)
        }
        
    }

    
    func cobonObserver() {
        let db = Firestore.firestore().collection("cobon")
        db.getDocuments { (snapshot, err) in
            if err == nil {
                for document in snapshot!.documents {
                    let list = CobonList(dic: document.data())
                    self.cobonList.append(list)
                }
            }
        }
    }
    
    @objc func cobonChecker(_ sender: UIButton) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let last720DaysList = Date.getDates(forLastNDays: 720)

        for i in cobonList {
            if i.name == t.text?.uppercased() {
                if last720DaysList.contains(i.date!) {
                    checkCoboonFirebase(sender: sender, name: i.name!, expire: true, discount: i.discount!)
                } else {
                    checkCoboonFirebase(sender: sender, name: i.name!, expire: false, discount: i.discount!)
                }
            } else {
                checkCoboonFirebase(sender: sender, name: i.name!, expire: true, discount: i.discount!)
            }

        }
    }
    
    func checkCoboonFirebase(sender: UIButton, name: String, expire: Bool, discount: Double) {
        if sender.titleLabel!.text!.contains("اضافة خصم") {
            let n = discount
            let cod = name
            discountCobon = Double(discount) / 100.0
            discountPercint = discountCobon
            coboonName = cod
            handleDicountCobon()
            handleShowAndDisaapperAlert()
            underView.CodeView.setTitle("كوبون: \(cod), خصم: \(n)%", for: .normal)
        } else {
            if expire == false {
                statusValue.textColor = mainColorForApp
                statusValue.text = "صالح للاستعمال"
                let n = discount
                dicountNumber.text = "\(n)%"
                dicountNumber.textColor = mainColorForApp
                b.setTitle("اضافة خصم \(n)% (\(t.text!))", for: .normal)
                t.isEnabled = false
                t.textColor = .lightGray
                changeBtn.isHidden = false
            } else {
                statusValue.textColor = UIColor.rgb(r: 135, g: 25, b: 25)
                statusValue.text = "غير صالح للاستعمال"
                t.isEnabled = true
                changeBtn.isHidden = true
                t.textColor = .black
                dicountNumber.text = "0%"
                dicountNumber.textColor = UIColor.rgb(r: 135, g: 25, b: 25)
                t.text = ""
                b.setTitle("التحقق من الكوبون", for: .normal)
                
            }
            endEditingFunc()
            t.layer.borderColor = UIColor.lightGray.cgColor

        }
    }
    
    @objc func handleDicountCobon() {
        collectItmesPrice()
    }
    
    func collectItmesPrice() {
        storeTotalPrice = 0.0
        
        for i in newList {
            storeTotalPrice = storeTotalPrice + (i.price! * Double(i.count!))
        }
        underView.totalBeforeTax.text = "\(String(format: "%.2f", storeTotalPrice)) ر.س"
        underView.TotalMoney.text = "\(String(format: "%.2f",storeTotalPrice - (storeTotalPrice * discountPercint))) ر.س"
        underView.CodeDiscount.text = "-\(String(format: "%.2f",storeTotalPrice * discountPercint)) ر.س"

    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        let invalidCharacters = CharacterSet(charactersIn: "0123456789QWERTYUIOPASDFGHJKLZXCVBNMqwertyuiopasdfghjklzxcvbnm").inverted
        guard let text = textField.text else { return true }
        let newLength = text.count + string.count - range.length
        return newLength <= 5 && string.rangeOfCharacter(from: invalidCharacters) == nil
    }
    
    
    @objc func endEditingFunc() {
        view.endEditing(true)
        keyWindow!.endEditing(true)
    }
    
    func reloadCartListWithRepateCount() {
        newList = []
        for item in cartList {
            if newList.contains(item) {
                item.count! += 1
            } else {
                newList.append(item)
            }
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cartViewCellID, for: indexPath) as! ItemsTableViewCell
        
        let list = newList[indexPath.row]
        cell.details.text = list.details
        cell.name.text = list.name
        cell.price.text = "السعر: \(list.price! * Double(list.count!)) ريال"
        cell.count.text = "x \(list.count!)"
        
        cell.status.alpha = 0
        cell.favorite.alpha = 0
        cell.addToCart.alpha = 0
        cell.count.alpha = 1
        
        cell.img.urlToImage(list.img!)
        
        if favoriteList.contains(list) {
            cell.favorite.setTitle("💔", for: .normal)
            cell.favorite.backgroundColor = UIColor.rgb(r: 14, g: 147, b: 71)
        } else {
            cell.favorite.setTitle("♥️", for: .normal)
            cell.favorite.backgroundColor = .gray
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let cancellOrder = UIContextualAction(style: .destructive, title: "ازالة من السلة") { (action, view, completion) in
            
            let list = cartList[indexPath.row]
            let list1 = self.newList[indexPath.row]
            
            DispatchQueue.main.async {
                cartList.removeAll { (i) -> Bool in
                    list.id == i.id
                }
                
                self.newList.removeAll { (r) -> Bool in
                    list1.id == r.id
                }
                

                list1.count = 1
                self.collectItmesPrice()
                self.isEmptyLabelFunc()
                tableView.reloadData()
            }
            completion(true)
        }
        
        let swipe = UISwipeActionsConfiguration(actions: [cancellOrder])
        return swipe
    }
    
}

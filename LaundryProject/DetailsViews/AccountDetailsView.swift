//
//  AccountDetailsView.swift
//  LaundryProject
//
//  Created by  ALxD7MY on 05/05/2021.
//

import UIKit
import Firebase

class AccountDetailsViewCell: UICollectionViewCell, UITableViewDelegate, UITableViewDataSource {

    var userOrders = [OrderList]()
    
    var cellIDForItems = "cellIDForItems"
    var totalOrdersPrice = 0.0
    var mainViewController: ViewController?
    
    var userInfo: UsersInfo? {
        didSet {
            if userInfo != nil {
                name.text = "مرحباً يا " + userInfo!.firstName! + " " + userInfo!.lastName! + "\n \nالبريد الالكتروني: \n \(userInfo!.email!) \nرقم الهاتف: \n \(userInfo?.phoneNumber ?? "")"
                credit.text = "رصيدك هو: \(userInfo!.credit!) ريال"
                addUsersOrderForAcoountPage(userInfo!.uid!)
            }
        }
    }

    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.tableFooterView = UIView(frame: .zero)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 82, right: 0)
        table.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 82, right: 0)
        table.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return table
    }()
    
    let lineView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor(white: 0, alpha: 0.37)
        return v
    }()
    
    let img: UIImageView = {
       let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "profile")
        img.layer.cornerRadius = 75
        img.contentMode = .scaleAspectFill
        img.layer.masksToBounds = true
        img.layer.borderWidth = 0.2
        img.layer.borderColor = UIColor.lightGray.cgColor
        return img
    }()
    
    let credit: UILabel = {
       let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "رصيدك هو: 0 ريال"
        l.textAlignment = .center
        l.font = UIFont.systemFont(ofSize: 12)
        return l
    }()
    
    let name: UILabel = {
       let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "مرحباً يا فلان"
        l.textAlignment = .right
        l.font = UIFont.boldSystemFont(ofSize: 12)
        l.numberOfLines = 6
        return l
    }()
    
    let total: UILabel = {
       let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "اجمالي مبالغ طلباتك: 0 ريال"
        l.textAlignment = .left
        l.font = UIFont.systemFont(ofSize: 12)
        return l
    }()
    
    let signOutBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("الخروج", for: .normal)
        btn.backgroundColor = UIColor.rgb(r: 114, g: 18, b: 71)
        btn.layer.cornerRadius = 14
        btn.tintColor = .white
        btn.layer.masksToBounds = true
        return btn
    }()
    
    let isEmptyLabel: UILabel = {
         let b = UILabel()
            b.translatesAutoresizingMaskIntoConstraints = false
            b.text = "لا توجد طلبات"
            b.textAlignment = .center
            b.numberOfLines = 1
            b.font = UIFont.systemFont(ofSize: 18)
            b.textColor = .lightGray
            b.alpha = 0
         return b
     }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    func setup() {
        tableView.register(ItemsTableViewCell.self, forCellReuseIdentifier: cellIDForItems)
        
        addSubview(img)
        img.rightAnchor.constraint(equalTo: rightAnchor, constant: -12).isActive = true
        img.centerYAnchor.constraint(equalTo: topAnchor, constant: 90).isActive = true
        img.widthAnchor.constraint(equalToConstant: 150).isActive = true
        img.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        addSubview(credit)
        credit.centerXAnchor.constraint(equalTo: img.centerXAnchor).isActive = true
        credit.topAnchor.constraint(equalTo: img.bottomAnchor).isActive = true
        credit.heightAnchor.constraint(equalToConstant: 40).isActive = true
        credit.widthAnchor.constraint(equalTo: img.widthAnchor).isActive = true
        
        addSubview(lineView)
        lineView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        lineView.heightAnchor.constraint(equalToConstant: 0.8).isActive = true
        lineView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        lineView.topAnchor.constraint(equalTo: credit.bottomAnchor).isActive = true
        
        addSubview(name)
        name.topAnchor.constraint(equalTo: topAnchor, constant: 48).isActive = true
        name.rightAnchor.constraint(equalTo: credit.leftAnchor, constant: -10).isActive = true
        name.heightAnchor.constraint(equalToConstant: 120).isActive = true
        name.widthAnchor.constraint(equalToConstant: 180).isActive = true
        
        addSubview(total)
        total.leftAnchor.constraint(equalTo: leftAnchor, constant: 6).isActive = true
        total.centerYAnchor.constraint(equalTo: credit.centerYAnchor).isActive = true
        total.heightAnchor.constraint(equalToConstant: 40).isActive = true
        total.widthAnchor.constraint(equalToConstant: 280).isActive = true
        
        
        addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 20).isActive = true
        tableView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        tableView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        addSubview(isEmptyLabel)
        isEmptyLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        isEmptyLabel.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 90).isActive = true

        let info = UILabel()
        info.translatesAutoresizingMaskIntoConstraints = false
        info.text = "طلباتي:"
        info.font = UIFont.boldSystemFont(ofSize: 12)
        info.textAlignment = .right
        
        addSubview(info)
        info.topAnchor.constraint(equalTo: lineView.bottomAnchor).isActive = true
        info.heightAnchor.constraint(equalToConstant: 20).isActive = true
        info.widthAnchor.constraint(equalToConstant: 110).isActive = true
        info.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
        
        addSubview(signOutBtn)
        signOutBtn.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        signOutBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        signOutBtn.widthAnchor.constraint(equalToConstant: 79).isActive = true
        signOutBtn.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        

        signOutBtn.addTarget(self, action: #selector(trySignOut), for: .touchUpInside)
     
        isEmptyLabelFunc()
    }
    
    func isEmptyLabelFunc() {
        if userOrders.isEmpty {
            isEmptyLabel.alpha = 1
        } else {
            isEmptyLabel.alpha = 0
        }
    }
    
    func addUsersOrderForAcoountPage(_ uid: String) {
        let db = Firestore.firestore().collection("orders")
        db.getDocuments() { (snapshot, err) in
            if let err = err {
                print("حصل خطأ بالوصول: \(err)")
            } else {
                for document in snapshot!.documents {
                    let list = OrderList(dic: document.data())
                    if list.userID == uid {
                        self.userOrders.append(list)
                        
                        self.totalOrdersPrice += list.price! * 1
                        self.total.text = "اجمالي مبالغ طلباتك: \(String(format: "%.2f", self.totalOrdersPrice)) ريال"
                        self.credit.text = "رصيدك هو: \(String(format: "%.2f", self.totalOrdersPrice * 0.10)) ريال"
                        
                        DispatchQueue.main.async {
                            self.isEmptyLabelFunc()
                            self.tableView.reloadData()
                        }
                    }
                }
            }
        }
    }
    
    @objc func trySignOut() {
        do {
            try! Auth.auth().signOut()
        }
        mainViewController?.authCheck()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userOrders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIDForItems, for: indexPath) as! ItemsTableViewCell
        
        let list = userOrders[indexPath.row]
                
        cell.details.text = list.details
        cell.name.text = list.name
        cell.price.text = "السعر: \(list.price! * Double(list.count!)) ريال"
        
        updateStatusCode(list: list, cell: cell)
        
        cell.img.urlToImage(list.img!)
        cell.count.text = "x \(list.count!)"
        
        return cell
    }
    
    func updateStatusCode(list: OrderList, cell: ItemsTableViewCell) {
        switch list.statusCode {
        case 0:
            cell.status.text = "   قيد الانتظار"
            cell.status.backgroundColor = .gray
            cell.status.textColor = .white
        case 1:
            cell.status.text = "   مكتمل"
            cell.status.backgroundColor = .brown
            cell.status.textColor = .white
        case 2:
            cell.status.text = "   ملغي"
            cell.status.backgroundColor = .red
            cell.status.textColor = .white
        default:
            cell.status.text = "   جاري التوصيل"
            cell.status.backgroundColor = .blue
            cell.status.textColor = .white
        }
        
        cell.addToCart.alpha = 0
        cell.favorite.alpha = 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let cancellOrder = UIContextualAction(style: .normal, title: "الغاء الطلب") { (action, view, completion) in
            
            let list = self.userOrders[indexPath.row]
            list.statusCode = 2
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                tableView.reloadData()
            }
            
            completion(true)
        }
        
        cancellOrder.backgroundColor = .red
        let swipe = UISwipeActionsConfiguration(actions: [cancellOrder])
        return swipe
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let cancellOrder = UIContextualAction(style: .normal, title: "اعادة الطلب") { (action, view, completion) in
            
            let list = self.userOrders[indexPath.row]
            self.callAlertForConfirmed("تأكيد", "هل انت متأكد من اعادة طلب نفس هذا المنتج بنفس العدد", list: list)
            
            completion(true)
        }
        
        let swipe = UISwipeActionsConfiguration(actions: [cancellOrder])
        return swipe
    }
    
    func callAlertForConfirmed(_ t: String, _ txt: String, list: OrderList) {
        let alert = UIAlertController(title: t, message: txt, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "الغاء", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "تأكيد", style: .default, handler: { (action) in
            self.reOrderSameThisOrder(i: list)
        }))
        mainViewController?.present(alert, animated: true, completion: nil)
    }
    
    @objc func reOrderSameThisOrder(i: OrderList) {
        let value = ["name": i.name!, "id": i.id!, "statusCode": 0, "category": i.category!, "count": i.count!, "price": i.price!, "img": i.img!, "details": i.details!, "userID": i.userID ?? ""] as [String : Any]
        
        let db = Firestore.firestore().collection("orders")
        db.addDocument(data: value) { (err) in
//            print(err)
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

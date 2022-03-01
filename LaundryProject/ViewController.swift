//
//  ViewController.swift
//  LaundryProject
//
//  Created by  ALxD7MY on 04/05/2021.
//

import UIKit
import Firebase
import CoreData

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    

    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var menuBarPlace: UIView!
    
    var userInfo: UsersInfo?
    var storeItems = [ItemsList]()
    
    lazy var menuView: MenuBarView = {
        let v = MenuBarView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .clear
        v.mainViewController = self
        return v
    }()
    
    var titleLabel = UILabel()
    var cartBadge = UILabel()

//    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        authCheck()
        setupMenuBar()
        getStoreItems()
        
        collectionView.register(AccountDetailsViewCell.self, forCellWithReuseIdentifier: "x1Cell")
        collectionView.register(StroeMenuView.self, forCellWithReuseIdentifier: "x2Cell")
        collectionView.register(SupportCollectionViewCell.self, forCellWithReuseIdentifier: "x3Cell")
        
        let lefBarBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 25, height: 16))
        lefBarBtn.setBackgroundImage(UIImage(named: "cart1")?.withRenderingMode(.alwaysOriginal), for: .normal)
        lefBarBtn.addTarget(self, action: #selector(openCartFunction), for: .touchUpInside)
        setupBadgeForCart()
        lefBarBtn.addSubview(cartBadge)
        let leftBarCustomBtn = UIBarButtonItem(customView: lefBarBtn)

        lefBarBtn.addTarget(self, action: #selector(openCartFunction), for: .touchUpInside)
        navigationItem.leftBarButtonItem = leftBarCustomBtn
        
        titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        navigationController?.navigationBar.isTranslucent = false
        
        titleLabel.text = "   الرئيسية"
        navigationItem.title = "الرئيسية"
        titleLabel.textColor = .white
        titleLabel.backgroundColor = .clear
        titleLabel.textAlignment = .right
        titleLabel.font = UIFont.boldSystemFont(ofSize: 22)
        navigationItem.titleView = titleLabel
        
        
        
//        addItem(name: "غسيل بشت", category: "care", count: 1, price: 40.50, img: "https://images-na.ssl-images-amazon.com/images/I/712qKnytmTL._AC_UL300_SR300,300_.jpg", details: "غسل بشت القماش بالبخار")
//
//        addItem(name: "غسيل فستان زفاف", category: "care", count: 1, price: 63.75, img: "https://w7.pngwing.com/pngs/157/15/png-transparent-wedding-dress-gown-white-bride-bride-wedding-people-party-dress.png", details: "غسل فستان الزفاف بالبخار")
//
//        addItem(name: "غسيل جزمات رياضية", category: "care", count: 1, price: 18.25, img: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS9YVcP33olxZgZymS1spIYaLSqZplrHppRZO6hHElUIF2EuP1oZtPL_MjpyGQpCGhG23LYzLF3&usqp=CAc", details: "غسل الجزمات غسيل خاص")
//
//        addItem(name: "غسيل سجاد", category: "normal", count: 1, price: 33.5, img: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQL_BAFue9RuqC27zbpcY5TrgioR8hviHOsLfai0A-ZUU5_2-_DkE1S2-8ZwXxEH-t8WBElF8E&usqp=CAc", details: "غسل سجاد بمقاس حد اقصى ٦*٦ متر")
//
//        addItem(name: "غسيل ثوب وشماغ", category: "normal", count: 1, price: 6.75, img: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRd7LNNssEkYAmm4WNr3vln_yYsbdoHNxzUi9BmdgUJfnCZ21_CusD1fAfqQiUyZlklClEEKWLd&usqp=CAc", details: "غسل ثوب او شماغ مع كوي مجاناً")

    }
    
    func addItem(name: String, category: String, count: Int, price: Double, img: String, details: String) {
        let db = Firestore.firestore().collection("store")

        let value = ["name": name, "id": "\(db.document().documentID)", "statusCode": 0, "category": category, "count": count, "price": price, "img": img, "details": details] as [String : Any]
        
        db.addDocument(data: value) { (err) in
//            print(err)
        }
    }
    
    func setupBadgeForCart() {
        cartBadge = UILabel(frame: CGRect(x: 25, y: -5, width: 30, height: 20))
        cartBadge.layer.borderWidth = 2
        cartBadge.layer.borderColor = UIColor.clear.cgColor
        cartBadge.layer.cornerRadius = 10
        cartBadge.textAlignment = .center
        cartBadge.layer.masksToBounds = true
        cartBadge.font = UIFont.systemFont(ofSize: 12)
        cartBadge.textColor = .white
        cartBadge.backgroundColor = .red
        cartBadge.text = "0"
    }
    
//    func saveData() {
//        do {
//            try context.save()
//        } catch {
//            
//        }
//    }
//    
//    func loadData() {
//        let requset: NSFetchRequest<StoreItem> = StoreItem.fetchRequest()
//        
//        do {
//            storeItems = try context.fetch(requset)
//        } catch {
//            
//        }
//    }
    
    @objc func openCartFunction() {
        let vc = CartViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

    func setupMenuBar() {

        menuBarPlace.addSubview(menuView)
        menuView.widthAnchor.constraint(equalTo: menuBarPlace.widthAnchor).isActive = true
        menuView.heightAnchor.constraint(equalTo: menuBarPlace.heightAnchor).isActive = true
        menuView.centerXAnchor.constraint(equalTo: menuBarPlace.centerXAnchor).isActive = true
        menuView.centerYAnchor.constraint(equalTo: menuBarPlace.centerYAnchor).isActive = true
    }
    
    func authCheck() {
        let uid = Auth.auth().currentUser?.uid

        let main: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let loginView = main.instantiateViewController(withIdentifier: "loginViewStoryBoardID") as! UINavigationController
        loginView.view.backgroundColor = .white
        loginView.modalPresentationStyle = .fullScreen

        if uid != nil {
            observeUserInfo(uid!)
        } else {
            let index = IndexPath(item: 0, section: 0)
            menuView.collectionView.selectItem(at: index, animated: false, scrollPosition: .centeredHorizontally)
            collectionView.selectItem(at: index, animated: false, scrollPosition: .centeredHorizontally)
            present(loginView, animated: false, completion: nil)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        authCheck()
        
        cartBadge.text = "\(cartList.count)"
        if cartBadge.text == "0" {
            cartBadge.isHidden = true
        } else {
            cartBadge.isHidden = false
        }
    }

    
    func observeUserInfo(_ uid: String) {
        let db = Firestore.firestore()
        db.collection("users").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("حصل خطأ بالوصول: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let list = UsersInfo(dic: document.data())
                    if list.uid == uid {
                        self.userInfo = list
                        self.collectionView.reloadData()
                    }
                }
            }
        }
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func goToSelectedCell(_ i: Int) {
        let indexPath = IndexPath(item: i, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        if i == 2 {
            collectionView.isScrollEnabled = false
        } else {
            collectionView.isScrollEnabled = true
        }
    }
    
    var titleCollection = ["   الرئيسية","   الدعم الفني","   حسابي"]
    
    var currentContent: CGFloat = 0

    var storeItemsIsLoaded = false
    func getStoreItems() {
        let db = Firestore.firestore()
        db.collection("store").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("حصل خطأ بالوصول: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let list = ItemsList(dic: document.data())
                    self.storeItems.append(list)
                        DispatchQueue.main.async {
                            self.storeItemsIsLoaded = true
                            self.collectionView.reloadData()
                        }
                    }
                }
        }
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x / view.frame.width
        let indexPath = IndexPath(row: Int(x), section: 0)
        menuView.collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .centeredHorizontally)
        changeTitleForCollection(Int(x))

        if Int(x) == 2 {
            collectionView.isScrollEnabled = false
        } else {
            collectionView.isScrollEnabled = true
        }
    }
    
    func changeTitleForCollection(_ x: Int) {
        titleLabel.text = titleCollection[x]
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.row {
        case 1:
            let x3Cell = collectionView.dequeueReusableCell(withReuseIdentifier: "x3Cell", for: indexPath) as! SupportCollectionViewCell

            return x3Cell
        case 2:
            let x2Cell = collectionView.dequeueReusableCell(withReuseIdentifier: "x1Cell", for: indexPath) as! AccountDetailsViewCell
            x2Cell.mainViewController = self
            x2Cell.userInfo = userInfo
            return x2Cell
        default:
            let x2Cell = collectionView.dequeueReusableCell(withReuseIdentifier: "x2Cell", for: indexPath) as! StroeMenuView
            x2Cell.mainViewController = self
            x2Cell.storeItems = storeItems
            if storeItemsIsLoaded == true {x2Cell.showTableViewAnimation()}
            return x2Cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    
}



//
//  StoreDetailsViewController.swift
//  LaundryProject
//
//  Created by  ALxD7MY on 06/05/2021.
//

import UIKit
import Firebase

var favoriteList = [ItemsList]()
var cartList = [ItemsList]()
var FavoriteMode = false

class StoreDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var titleString: String?
    
    let myItemsStoreDetailsCell = "myItemsStoreDetailsCell"
    
    var storeItems: [ItemsList]? {
        didSet {
            observeStoreItems()
        }
    }
    
    var filterdItems = [ItemsList]()
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.tableFooterView = UIView(frame: .zero)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return table
    }()
    
    var rightBarBtn = UIBarButtonItem()
    var cartHeaderBtn = UIButton()
    var totalAmmountLabel = UILabel()
    var cartBadge = UILabel()
    let headerView = UIView()
    var totalAmmountDouble = 0.0
    var titleLabel = UILabel()
    
    let isEmptyLabel: UILabel = {
         let b = UILabel()
            b.translatesAutoresizingMaskIntoConstraints = false
            b.text = "المفضلة فارغة 💔"
            b.textAlignment = .center
            b.numberOfLines = 1
            b.font = UIFont.systemFont(ofSize: 18)
            b.textColor = .lightGray
            b.alpha = 0
         return b
     }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width / 2, height: view.frame.height))
        navigationController?.navigationBar.isTranslucent = false
        setupHeaderView()

        titleLabel.text = titleString ?? "المفضلة"
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 18)
        navigationItem.titleView = titleLabel
        
        tableView.register(ItemsTableViewCell.self, forCellReuseIdentifier: myItemsStoreDetailsCell)


        if !FavoriteMode {
        rightBarBtn = UIBarButtonItem(title: "♥️", style: .plain, target: self, action: #selector(openFavoriteView))
        navigationItem.rightBarButtonItem = rightBarBtn
        }
        
        cartHeaderBtn.addTarget(self, action: #selector(openCartView), for: .touchUpInside)

    }
    
    
    func isEmptyLabelFunc() {
        if favoriteList.isEmpty {
            isEmptyLabel.alpha = 1
        } else {
            isEmptyLabel.alpha = 0
        }
    }
    
    @objc func openCartView() {
        let vc = CartViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func openFavoriteView() {
        let vc = StoreDetailsViewController()
        FavoriteMode = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func setupHeaderView() {

        if FavoriteMode == true {
            isEmptyLabelFunc()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        headerView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(headerView)
        headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        headerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        headerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(tableView)
        tableView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        
        tableView.addSubview(isEmptyLabel)
        isEmptyLabel.widthAnchor.constraint(equalTo: tableView.widthAnchor).isActive = true
        isEmptyLabel.heightAnchor.constraint(equalTo: tableView.heightAnchor).isActive = true
        isEmptyLabel.centerXAnchor.constraint(equalTo: tableView.centerXAnchor).isActive = true
        isEmptyLabel.centerYAnchor.constraint(equalTo: tableView.centerYAnchor).isActive = true
        
        let line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = .gray
        
        headerView.addSubview(line)
        line.bottomAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        line.heightAnchor.constraint(equalToConstant: 0.8).isActive = true
        line.widthAnchor.constraint(equalTo: headerView.widthAnchor).isActive = true
        line.centerXAnchor.constraint(equalTo: headerView.centerXAnchor).isActive = true
                
        cartHeaderBtn.translatesAutoresizingMaskIntoConstraints = false
        cartHeaderBtn.setImage(UIImage(named: "cart")?.withRenderingMode(.alwaysTemplate), for: .normal)
        cartHeaderBtn.imageView!.contentMode = .scaleToFill
        cartHeaderBtn.tintColor = mainColorForApp
        
        headerView.addSubview(cartHeaderBtn)
        cartHeaderBtn.leftAnchor.constraint(equalTo: headerView.leftAnchor, constant: 10).isActive = true
        cartHeaderBtn.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        cartHeaderBtn.widthAnchor.constraint(equalToConstant: 35).isActive = true
        cartHeaderBtn.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        totalAmmountLabel.translatesAutoresizingMaskIntoConstraints = false
        totalAmmountLabel.backgroundColor = .clear
        totalAmmountLabel.font = UIFont.boldSystemFont(ofSize: 16)
        totalAmmountLabel.textAlignment = .right
        
        headerView.addSubview(totalAmmountLabel)
        totalAmmountLabel.rightAnchor.constraint(equalTo: headerView.rightAnchor, constant: -8).isActive = true
        totalAmmountLabel.widthAnchor.constraint(equalTo: headerView.widthAnchor, constant: 1/1.37).isActive = true
        totalAmmountLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        totalAmmountLabel.heightAnchor.constraint(equalTo: headerView.heightAnchor).isActive = true
        
        cartBadge.translatesAutoresizingMaskIntoConstraints = false
        cartBadge.textAlignment = .center
        cartBadge.backgroundColor = .red
        cartBadge.textColor = .white
        cartBadge.font = UIFont.boldSystemFont(ofSize: 12)
        cartBadge.text = "\(cartList.count)"
        cartBadge.layer.masksToBounds = true
        cartBadge.layer.cornerRadius = 12
        
        cartHeaderBtn.addSubview(cartBadge)
        cartBadge.centerYAnchor.constraint(equalTo: cartHeaderBtn.centerYAnchor, constant: -8).isActive = true
        cartBadge.heightAnchor.constraint(equalToConstant: 24).isActive = true
        cartBadge.widthAnchor.constraint(equalToConstant: 24).isActive = true
        cartBadge.leftAnchor.constraint(equalTo: cartHeaderBtn.rightAnchor).isActive = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if FavoriteMode == true {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                FavoriteMode = false
            }
        } else {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        collectAllCartMoney()
    }
    
    func collectAllCartMoney() {
        totalAmmountDouble = 0
        
        for i in cartList {
            totalAmmountDouble = totalAmmountDouble + i.price!
        }
        
        if cartList.count == 0 {
            cartBadge.alpha = 0
        }
        
        totalAmmountLabel.text = "الاجمالي: \(totalAmmountDouble) ر.س"
    }
    
    func observeStoreItems() {
        for i in storeItems! {
            if i.category! == "care" && titleString == "العناية الخاصة"{
                filterdItems.append(i)
            } else if i.category! == "normal" && titleString != "العناية الخاصة" {
                filterdItems.append(i)
            }
        }

        DispatchQueue.main.async {
            self.tableView.reloadData()
        }

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch titleLabel.text {
        case "المفضلة":
            return favoriteList.count
        default:
            return filterdItems.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: myItemsStoreDetailsCell, for: indexPath) as! ItemsTableViewCell
        
        var list: ItemsList?
        switch titleLabel.text {
        case "المفضلة":
            list = favoriteList[indexPath.row]
            cell.favorite.alpha = 0
            cell.addToCart.alpha = 0
        default:
            list = filterdItems[indexPath.row]
            cell.favorite.alpha = 1
            cell.addToCart.alpha = 1
        }
                
        cell.details.text = list!.details
        cell.name.text = list!.name
        cell.price.text = "السعر: \(list!.price!) ريال"
        cell.status.alpha = 0
        cell.count.alpha = 0
                
        cell.img.urlToImage(list!.img!)
        
        if favoriteList.contains(list!) {
            cell.favorite.setTitle("💔", for: .normal)
            cell.favorite.backgroundColor = UIColor.rgb(r: 14, g: 147, b: 71)
        } else {
            cell.favorite.setTitle("♥️", for: .normal)
            cell.favorite.backgroundColor = .gray
        }
        
        cell.favorite.tag = indexPath.row
        cell.addToCart.tag = indexPath.row
        cell.favorite.addTarget(self, action: #selector(addToFavoriteList(_:)), for: .touchUpInside)
        cell.addToCart.addTarget(self, action: #selector(addToCartWithAnimation(_:)), for: .touchUpInside)
        
        return cell
    }
    
    @objc func addToCartWithAnimation(_ sender: UIButton) {
        let indexPath = IndexPath(item: sender.tag, section: 0)
        let cell = tableView.cellForRow(at: indexPath) as! ItemsTableViewCell
        let list = filterdItems[indexPath.row]
        
        cartList.append(list)
        collectAllCartMoney()
    
        let imgPosition : CGPoint = cell.img.convert(cell.img.bounds.origin, to: view)
        let imgTemp = UIImageView(frame: CGRect(x: imgPosition.x, y: imgPosition.y, width: cell.img.frame.size.width, height: cell.img.frame.size.height))
        imgTemp.image = cell.img.image
    
        animation(temp: imgTemp)
    }
    
    func animation(temp : UIView)  {
        view.addSubview(temp)
        UIView.animate(withDuration: 1.0,
                       animations: {
                        temp.animationZoom(scaleX: 1.5, y: 1.5)
        }, completion: { _ in
            
            UIView.animate(withDuration: 0.5, animations: {
                
                temp.animationZoom(scaleX: 0.2, y: 0.2)
                temp.animationRoted(angle: CGFloat(Double.pi))
                
                temp.frame.origin.x = self.cartHeaderBtn.frame.origin.x
                temp.frame.origin.y = self.cartHeaderBtn.frame.origin.y
                
            }, completion: { _ in
                
                temp.removeFromSuperview()
                
                UIView.animate(withDuration: 1.0, animations: {
                    self.cartHeaderBtn.animationZoom(scaleX: 1.4, y: 1.4)
                }, completion: {_ in
                    self.cartBadge.text = "\(cartList.count)"
                    
                    if cartList.count == 0 {
                        self.cartBadge.alpha = 0
                    } else {
                        self.cartBadge.alpha = 1
                    }
                    self.cartHeaderBtn.animationZoom(scaleX: 1.0, y: 1.0)
                })
            })
        })
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch titleLabel.text {
        case "المفضلة":
            return 125
        default:
            return 175
        }
    }
    
    @objc func addToFavoriteList(_ sender: UIButton) {
        let indexPath = IndexPath(item: sender.tag, section: 0)
        let list = filterdItems[indexPath.row]
        
        if sender.titleLabel?.text == "♥️" {
            sender.setTitle("💔", for: .normal)
            sender.backgroundColor = UIColor.rgb(r: 14, g: 147, b: 71)
            favoriteList.append(list)
        } else {
            sender.setTitle("♥️", for: .normal)
            sender.backgroundColor = .gray
            
            favoriteList.removeAll { (i) -> Bool in
                i.id == list.id
            }
        }
    }
    
    func callAlertController(_ t: String,_ x: String) {
        let alert = UIAlertController(title: t, message: x, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "حسناً", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        switch titleLabel.text {
        case "المفضلة":
            let cancellOrder = UIContextualAction(style: .destructive, title: "ازالة من المفضلة") { (action, view, completion) in
                
                favoriteList.remove(at: indexPath.row)
                DispatchQueue.main.async {
                    tableView.reloadData()
                }
                self.isEmptyLabelFunc()
                
                completion(true)
            }
            let swipe = UISwipeActionsConfiguration(actions: [cancellOrder])
            return swipe
        default:
            return UISwipeActionsConfiguration()
        }
    }
    
}

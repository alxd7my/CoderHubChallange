//
//  StroeDetilsView.swift
//  LaundryProject
//
//  Created by  ALxD7MY on 06/05/2021.
//

import UIKit

class StroeMenuView: UICollectionViewCell, UITableViewDelegate, UITableViewDataSource {
    
    var storeItems: [ItemsList]?
    let cellIDForStoreItems = "cellIDForStoreItems"
    var mainViewController: ViewController?
    
    let activity: UIActivityIndicatorView = {
        let ac = UIActivityIndicatorView(style: .whiteLarge)
        ac.color = mainColorForApp
        ac.translatesAutoresizingMaskIntoConstraints = false
        return ac
    }()
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.tableFooterView = UIView(frame: .zero)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 82, right: 0)
        table.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 82, right: 0)
        table.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        table.isScrollEnabled = false
        table.alpha = 0
        return table
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    func setup() {
        tableView.register(MenuCellForMyStore.self, forCellReuseIdentifier: cellIDForStoreItems)
        
        
        addSubview(tableView)
        tableView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        tableView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        tableView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        tableView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        
        addSubview(activity)
        activity.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activity.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    override func prepareForReuse() {
           activity.startAnimating()
    }
    
    func showTableViewAnimation() {
        UIView.animate(withDuration: 0.6) {
            self.activity.stopAnimating()
            self.tableView.alpha = 1
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIDForStoreItems, for: indexPath) as! MenuCellForMyStore
        
        switch indexPath.row {
        case 1:
            cell.img.image = UIImage(named: "normalLaundry")
            cell.label.text = "الغسيل العادي"
        default:
            cell.img.image = UIImage(named: "careLaundry")
            cell.label.text = "العناية الخاصة"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsView = StoreDetailsViewController()
        
        if indexPath.row == 0 {
            detailsView.titleString = "العناية الخاصة"
        } else {
            detailsView.titleString = "الغسيل العادي"
        }
        
        detailsView.navigationItem.title = "المتجر"
        detailsView.storeItems = storeItems!
        mainViewController?.navigationController?.pushViewController(detailsView, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return frame.height / 2 - 40
    }
    
    
}

class MenuCellForMyStore: UITableViewCell {
    
    let img: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleToFill
        img.layer.borderWidth = 2
        img.layer.borderColor = UIColor.black.cgColor
        return img
    }()
    
    let label: UILabel = {
       let l = UILabel()
        l.font = UIFont.boldSystemFont(ofSize: 24)
        l.translatesAutoresizingMaskIntoConstraints = false
        l.backgroundColor = UIColor(white: 1, alpha: 0.8)
        l.layer.borderWidth = 2
        l.layer.borderColor = UIColor.black.cgColor
        l.textColor = .black
        l.textAlignment = .center
        l.layer.cornerRadius = 14
        l.layer.masksToBounds = true
        return l
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(img)
        img.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        img.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        img.heightAnchor.constraint(equalTo: heightAnchor, constant: -40).isActive = true
        img.widthAnchor.constraint(equalTo: widthAnchor, constant: -40).isActive = true
        
        img.addSubview(label)
        label.centerXAnchor.constraint(equalTo: img.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: img.centerYAnchor).isActive = true
        label.heightAnchor.constraint(equalToConstant: 60).isActive = true
        label.widthAnchor.constraint(equalTo: img.widthAnchor, multiplier: 1/1.33).isActive = true

        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectionStyle = .none
    }
}

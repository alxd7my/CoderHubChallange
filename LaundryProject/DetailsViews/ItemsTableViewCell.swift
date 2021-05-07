//
//  ItemsTableViewCell.swift
//  LaundryProject
//
//  Created by  ALxD7MY on 05/05/2021.
//

import UIKit

class ItemsTableViewCell: UITableViewCell {

    let img: UIImageView = {
       let i = UIImageView()
        i.translatesAutoresizingMaskIntoConstraints = false
        i.image = UIImage(named: "account")
        return i
    }()
    
    let name: UILabel = {
        let n = UILabel()
        n.text = ""
        n.translatesAutoresizingMaskIntoConstraints = false
        n.font = UIFont.boldSystemFont(ofSize: 14)
        n.textAlignment = .right
        return n
    }()
    
    let details: UILabel = {
        let n = UILabel()
        n.text = ""
        n.translatesAutoresizingMaskIntoConstraints = false
        n.font = UIFont.systemFont(ofSize: 13)
        n.textColor = .lightGray
        n.textAlignment = .right
        return n
    }()
    
    let price: UILabel = {
        let n = UILabel()
        n.text = ""
        n.translatesAutoresizingMaskIntoConstraints = false
        n.font = UIFont.systemFont(ofSize: 14)
        n.textAlignment = .left
        return n
    }()
    
    let status: UILabel = {
        let n = UILabel()
        n.text = ""
        n.translatesAutoresizingMaskIntoConstraints = false
        n.font = UIFont.systemFont(ofSize: 12)
        n.textAlignment = .right
        n.layer.cornerRadius = 20
        n.textColor = .white
        n.layer.masksToBounds = true
        n.backgroundColor = .gray
        return n
    }()
    
    let count: UILabel = {
        let n = UILabel()
        n.text = "x 1"
        n.translatesAutoresizingMaskIntoConstraints = false
        n.font = UIFont.systemFont(ofSize: 12)
        n.textAlignment = .right
        n.textColor = .black
        return n
    }()
    
    let addToCart: UIButton = {
        let b = UIButton(type: .system)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitle("اضافة الى السلة", for: .normal)
        b.tintColor = .white
        b.backgroundColor = mainColorForApp
        b.layer.cornerRadius = 10
        b.layer.masksToBounds = true
        return b
    }()
    
    let favorite: UIButton = {
        let b = UIButton(type: .system)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitle("♥️", for: .normal)
        b.titleLabel?.font = UIFont.boldSystemFont(ofSize: 26)
        b.tintColor = .white
        b.backgroundColor = .gray
        b.layer.cornerRadius = 10
        b.layer.masksToBounds = true
        return b
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        setup()
    }
        
    func setup() {
        addSubview(img)
        img.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
        img.topAnchor.constraint(equalTo: topAnchor, constant: 15).isActive = true
        img.heightAnchor.constraint(equalToConstant: 90).isActive = true
        img.widthAnchor.constraint(equalToConstant: 90).isActive = true
        
        addSubview(status)
        status.leftAnchor.constraint(equalTo: leftAnchor, constant: -40).isActive = true
        status.heightAnchor.constraint(equalToConstant: 40).isActive = true
        status.widthAnchor.constraint(equalToConstant: 134).isActive = true
        status.topAnchor.constraint(equalTo: topAnchor, constant: 6).isActive = true
        
        
        addSubview(name)
        name.rightAnchor.constraint(equalTo: img.leftAnchor, constant: -14).isActive = true
        name.widthAnchor.constraint(equalTo: widthAnchor, constant: -90).isActive = true
        name.topAnchor.constraint(equalTo: img.centerYAnchor, constant: -35).isActive = true
        name.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        addSubview(details)
        details.rightAnchor.constraint(equalTo: img.leftAnchor, constant: -14).isActive = true
        details.widthAnchor.constraint(equalTo: widthAnchor, constant: -90).isActive = true
        details.topAnchor.constraint(equalTo: img.centerYAnchor).isActive = true
        details.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        addSubview(addToCart)
        addToCart.heightAnchor.constraint(equalToConstant: 50).isActive = true
        addToCart.widthAnchor.constraint(equalTo: widthAnchor, constant: -90).isActive = true
        addToCart.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
        addToCart.topAnchor.constraint(equalTo: img.bottomAnchor, constant: 10).isActive = true
        
        addSubview(favorite)
        favorite.heightAnchor.constraint(equalToConstant: 50).isActive = true
        favorite.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        favorite.rightAnchor.constraint(equalTo: addToCart.leftAnchor, constant: -8).isActive = true
        favorite.topAnchor.constraint(equalTo: img.bottomAnchor, constant: 10).isActive = true
        
        addSubview(price)
        price.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        price.bottomAnchor.constraint(equalTo: addToCart.topAnchor).isActive = true
        price.heightAnchor.constraint(equalToConstant: 25).isActive = true
        price.widthAnchor.constraint(equalToConstant: 220).isActive = true
        
        addSubview(count)
        count.rightAnchor.constraint(equalTo: img.leftAnchor, constant: -8).isActive = true
        count.heightAnchor.constraint(equalToConstant: 25).isActive = true
        count.widthAnchor.constraint(equalToConstant: 30).isActive = true
        count.centerYAnchor.constraint(equalTo: price.centerYAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectionStyle = .none
        // Configure the view for the selected state
    }

}

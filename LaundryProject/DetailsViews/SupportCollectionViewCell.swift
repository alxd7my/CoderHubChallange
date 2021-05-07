//
//  SupportCollectionViewCell.swift
//  LaundryProject
//
//  Created by  ALxD7MY on 07/05/2021.
//

import UIKit
import Firebase

class SupportCollectionViewCell: UICollectionViewCell {
    
    let isEmptyLabel: UILabel = {
         let b = UILabel()
            b.translatesAutoresizingMaskIntoConstraints = false
            b.text = "المفروض هنا محادثة مباشرة \nوخرائط قوقل ماب للتحقق من نطاق االتوصيل \n \n \n🙁"
            b.textAlignment = .center
            b.numberOfLines = 10
            b.font = UIFont.systemFont(ofSize: 18)
            b.textColor = .lightGray
         return b
     }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        addSubview(isEmptyLabel)

        isEmptyLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        isEmptyLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

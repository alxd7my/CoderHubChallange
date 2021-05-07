//
//  UnderView.swift
//  shalehat
//
//  Created by  ALxD7MY on 28/08/2020.
//  Copyright © 2020 alxd7my. All rights reserved.
//

import UIKit

class UnderView: UIView {

    let totalBeforeTax: UILabel = {
       let l = UILabel()
        l.textAlignment = .center
        l.font = UIFont.boldSystemFont(ofSize: 14)
        l.text = "0.00 ر.س"
        l.textColor = .lightGray
        l.textAlignment = .left
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let totalBeforeTaxText: UILabel = {
       let l = UILabel()
        l.textAlignment = .right
        l.font = UIFont.boldSystemFont(ofSize: 14)
        l.text = "الاجمالي قبل الضريبة :"
        l.textColor = .lightGray
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let Taxes: UILabel = {
       let l = UILabel()
        l.textAlignment = .center
        l.font = UIFont.boldSystemFont(ofSize: 14)
        l.text = "0.00 ر.س"
        l.textColor = .lightGray
        l.textAlignment = .left
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let TaxesText: UILabel = {
       let l = UILabel()
        l.textAlignment = .right
        l.font = UIFont.boldSystemFont(ofSize: 14)
        l.text = "ضريبة القيمة المضافة 0% :"
        l.textColor = .lightGray
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let CodeDiscount: UILabel = {
       let l = UILabel()
        l.textAlignment = .center
        l.font = UIFont.boldSystemFont(ofSize: 14)
        l.text = "-0.00 ر.س"
        l.textColor = UIColor.rgb(r: 139, g: 25, b: 25)
        l.textAlignment = .left
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let TotalTxt: UILabel = {
       let l = UILabel()
        l.textAlignment = .right
        l.font = UIFont.boldSystemFont(ofSize: 20)
        l.text = "الاجمالي :"
        l.textColor = .white
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let TotalMoney: UILabel = {
       let l = UILabel()
        l.textAlignment = .center
        l.font = UIFont.boldSystemFont(ofSize: 20)
        l.text = "0.00 ر.س"
        l.textColor = .white
        l.textAlignment = .left
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    
    let CodeView: UIButton = {
        let b = UIButton(type: .system)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.tintColor = mainColorForApp
        b.backgroundColor = .white
        b.setTitle("اضافة كوبون خصم", for: .normal)
        b.layer.cornerRadius = 10
        return b
    }()
    
    let btn: UIButton = {
        let b = UIButton(type: .system)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitle("المتابعة", for: .normal)
        b.tintColor = mainColorForApp
        b.backgroundColor = .white
        b.layer.borderWidth = 0.8
        b.layer.borderColor = UIColor.white.cgColor
//        b.layer.masksToBounds = true
        b.layer.cornerRadius = 18
        b.layer.shadowColor = UIColor.white.cgColor
        b.layer.shadowOpacity = 0.5
        b.layer.shadowOffset = CGSize.zero
        b.layer.shadowRadius = 10
        return b
    }()
    
    let TaxLine: UIView = {
       let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .black
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("err")
    }
    
    func setup() {
        
        addSubview(btn)
        btn.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        btn.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50).isActive = true
        btn.widthAnchor.constraint(equalTo: widthAnchor, constant: -60).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        addSubview(totalBeforeTax)
        totalBeforeTax.leftAnchor.constraint(equalTo: btn.leftAnchor).isActive = true
        totalBeforeTax.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        totalBeforeTax.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/2, constant: -20).isActive = true
        totalBeforeTax.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        
        addSubview(totalBeforeTaxText)
        totalBeforeTaxText.rightAnchor.constraint(equalTo: btn.rightAnchor).isActive = true
        totalBeforeTaxText.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        totalBeforeTaxText.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/2, constant: -20).isActive = true
        totalBeforeTaxText.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        addSubview(Taxes)
        Taxes.leftAnchor.constraint(equalTo: btn.leftAnchor).isActive = true
        Taxes.topAnchor.constraint(equalTo: totalBeforeTax.bottomAnchor, constant: 10).isActive = true
        Taxes.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/2, constant: -20).isActive = true
        Taxes.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        
        addSubview(TaxesText)
        TaxesText.rightAnchor.constraint(equalTo: btn.rightAnchor).isActive = true
        TaxesText.topAnchor.constraint(equalTo: totalBeforeTaxText.bottomAnchor, constant: 10).isActive = true
        TaxesText.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/2, constant: -10).isActive = true
        TaxesText.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        
        addSubview(TaxLine)
        TaxLine.leftAnchor.constraint(equalTo: Taxes.leftAnchor).isActive = true
        TaxLine.rightAnchor.constraint(equalTo: TaxesText.rightAnchor).isActive = true
        TaxLine.centerYAnchor.constraint(equalTo: TaxesText.centerYAnchor).isActive = true
        TaxLine.heightAnchor.constraint(equalToConstant: 0.80).isActive = true
        
        addSubview(CodeDiscount)
        CodeDiscount.leftAnchor.constraint(equalTo: btn.leftAnchor).isActive = true
        CodeDiscount.topAnchor.constraint(equalTo: TaxesText.bottomAnchor, constant: 10).isActive = true
        CodeDiscount.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/2, constant: -20).isActive = true
        CodeDiscount.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        
        addSubview(CodeView)
        CodeView.rightAnchor.constraint(equalTo: btn.rightAnchor).isActive = true
        CodeView.topAnchor.constraint(equalTo: Taxes.bottomAnchor, constant: 10).isActive = true
        CodeView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/2, constant: -10).isActive = true
        CodeView.heightAnchor.constraint(equalToConstant: 30).isActive = true

        
        addSubview(TotalMoney)
        TotalMoney.leftAnchor.constraint(equalTo: btn.leftAnchor).isActive = true
        TotalMoney.topAnchor.constraint(equalTo: CodeDiscount.bottomAnchor, constant: 10).isActive = true
        TotalMoney.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/2, constant: -20).isActive = true
        TotalMoney.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        
        addSubview(TotalTxt)
        TotalTxt.rightAnchor.constraint(equalTo: btn.rightAnchor).isActive = true
        TotalTxt.topAnchor.constraint(equalTo: CodeView.bottomAnchor, constant: 10).isActive = true
        TotalTxt.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/2, constant: -20).isActive = true
        TotalTxt.heightAnchor.constraint(equalToConstant: 30).isActive = true

        
        
        
    }

}

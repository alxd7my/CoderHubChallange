//
//  MenuBarView.swift
//  LaundryProject
//
//  Created by  ALxD7MY on 05/05/2021.
//

import UIKit

class MenuBarView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var imagesList = [CustomCellMenueBarStruct]()
    var mainViewController: ViewController?
    
    lazy var collectionView: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = .clear
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.isScrollEnabled = false
        
        return collection
    }()
    
    let collectionID = "myCollectionViewIDForMainMenu"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    func setup() {
        collectionView.register(CustomMenuBarCell.self, forCellWithReuseIdentifier: collectionID)
        
        addSubview(collectionView)
        collectionView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        collectionView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        collectionView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        imagesList.append(CustomCellMenueBarStruct(img: UIImage(named: "home")!.withRenderingMode(.alwaysTemplate)))
        imagesList.append(CustomCellMenueBarStruct(img: UIImage(named: "support")!.withRenderingMode(.alwaysTemplate)))
        imagesList.append(CustomCellMenueBarStruct(img: UIImage(named: "account")!.withRenderingMode(.alwaysTemplate)))
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            self.collectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .centeredHorizontally)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionID, for: indexPath) as! CustomMenuBarCell
        
        let list = imagesList[indexPath.row]
        cell.img.image = list.img
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: frame.width * 1/3.2, height: frame.height)
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        mainViewController!.goToSelectedCell(indexPath.row)
        mainViewController!.changeTitleForCollection(indexPath.row)
    }

}


class CustomMenuBarCell: UICollectionViewCell {
    
    let img: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(img)
        img.heightAnchor.constraint(equalToConstant: 30).isActive = true
        img.widthAnchor.constraint(equalToConstant: 30).isActive = true
        img.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -8).isActive = true
        img.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    override var isSelected: Bool {
        didSet {
            UIView.animate(withDuration: 0.4) {
                self.img.tintColor = self.isSelected ? .white : .black
            }
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.4) {
                self.img.tintColor = self.isHighlighted ? .white : .black
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
}


struct CustomCellMenueBarStruct {
    var img: UIImage
}

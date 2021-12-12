//
//  MyClollectionViewCell.swift
//  CRUD_Project
//
//  Created by Abdullah Alnutayfi on 11/12/2021.
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {
    lazy var image: UIImageView = {
    
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
     
    override init(frame: CGRect) {
           super.init(frame: frame)
           setCollectionCiewCell()
       }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setCollectionCiewCell(){
        contentView.addSubview(image)
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        layer.cornerRadius = 10
       // layer.masksToBounds = false
        
        layer.shadowRadius = 10
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.10
        layer.shadowOffset = CGSize(width: 0, height: 5)
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: contentView.topAnchor),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            image.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

}

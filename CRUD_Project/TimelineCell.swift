//
//  TimelineCell.swift
//  CRUD_Project
//
//  Created by Abdullah Alnutayfi on 10/12/2021.
//

import UIKit

class TimelineCell: UITableViewCell {

    lazy var userProfilePic : UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(systemName: "person.circle.fill")
        $0.tintColor = .darkGray
        return $0
    }(UIImageView())
    
    lazy var username : UILabel = {
        $0.numberOfLines = 0
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "username"
        $0.textColor = .black
        $0.textAlignment = .left
        $0.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        return $0
    }(UILabel())
    
    lazy var creationDate : UILabel = {
        $0.numberOfLines = 0
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "10-Dec-2021"
        $0.textColor = .black
        $0.textAlignment = .left
        $0.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        return $0
    }(UILabel())
    
    lazy var timelineImage : UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(named: "timelinePic")
        $0.tintColor = .white
        return $0
    }(UIImageView())
    
    lazy var caption : UILabel = {
        $0.numberOfLines = 0
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = ""
        $0.textColor = .black
        $0.textAlignment = .left
        $0.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        
        return $0
    }(UILabel())
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCellContentView()
    }
    
    private func setupCellContentView(){
        [userProfilePic,username,creationDate,timelineImage,caption].forEach{contentView.addSubview($0)}
        
        NSLayoutConstraint.activate([
            userProfilePic.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 20),
            userProfilePic.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10),
            userProfilePic.heightAnchor.constraint(equalToConstant: 80),
            userProfilePic.widthAnchor.constraint(equalToConstant: 80),
            
            username.leadingAnchor.constraint(equalTo: userProfilePic.trailingAnchor,constant: 10),
            username.centerYAnchor.constraint(equalTo: userProfilePic.centerYAnchor),
            
            creationDate.topAnchor.constraint(equalTo: userProfilePic.bottomAnchor,constant: 10),
            creationDate.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20),
            
            timelineImage.topAnchor.constraint(equalTo: creationDate.bottomAnchor,constant: 20),
            timelineImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            timelineImage.heightAnchor.constraint(equalToConstant: 400),
            timelineImage.widthAnchor.constraint(equalToConstant: 400),
           // timelineImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            caption.topAnchor.constraint(equalTo: timelineImage.bottomAnchor,constant: 20),
            caption.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10),
            caption.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            
        ])
    }
    required init?(coder: NSCoder) {
        fatalError("")
    }
}

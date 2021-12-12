//
//  UsersCell.swift
//  CRUD_Project
//
//  Created by Abdullah Alnutayfi on 10/12/2021.
//

import UIKit

class UsersCell: UITableViewCell {

    lazy var uaername : UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "UserName"
        return $0
    }(UILabel())
    
    lazy var imgView : UIImageView = {
        $0.tintColor = .black
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        [uaername,imgView].forEach{contentView.addSubview($0)}
        NSLayoutConstraint.activate([
            imgView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imgView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -20),
            imgView.heightAnchor.constraint(equalToConstant: 100),
            imgView.widthAnchor.constraint(equalToConstant: 100),
            imgView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            uaername.topAnchor.constraint(equalTo: contentView.topAnchor),
            uaername.trailingAnchor.constraint(equalTo: imgView.leadingAnchor,constant: -20),
            uaername.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }

}

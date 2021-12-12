//
//  MyChatCell.swift
//  CRUD_Project
//
//  Created by Abdullah Alnutayfi on 11/12/2021.
//

import UIKit

class MyChatCell: UITableViewCell {

    lazy var username : UILabel = {
        $0.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    lazy var message : UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
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
        contentView.addSubview(username)
        contentView.addSubview(message)
        
        NSLayoutConstraint.activate([
            username.topAnchor.constraint(equalTo: contentView.topAnchor),
            username.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            message.topAnchor.constraint(equalTo: username.bottomAnchor),
            message.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            message.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            message.heightAnchor.constraint(equalToConstant: 70)
        ])
    }
    required init?(coder: NSCoder) {
        fatalError("")
    }
}

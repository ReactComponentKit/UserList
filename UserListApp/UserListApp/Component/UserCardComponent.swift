//
//  UserCardComponent.swift
//  UserListApp
//
//  Created by burt on 2018. 8. 28..
//  Copyright © 2018년 Burt.K. All rights reserved.
//

import UIKit
import ReactComponentKit

class UserCardComponent: UIViewComponent {
    
    private var user: User? = nil
    
    private lazy var card: UIView = {
        let view = UIView(frame: .zero)
        view.layer.cornerRadius = 8
        view.layer.shadowRadius = 1
        view.layer.shadowOpacity = 0.8
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 1)
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var emojiLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 1
        label.backgroundColor = .red
        label.layer.cornerRadius = 8
        label.clipsToBounds = true
        label.textAlignment = .center
        label.text = "😘"
        label.font = UIFont.systemFont(ofSize: 77)
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    private lazy var usernameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    
    private lazy var emailLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    
    private lazy var phoneLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    
    private lazy var updateButton: ButtonComponent = {
        let button = ButtonComponent(token: self.token, receiveState: false)
        button.title = "UPDATE"
        button.layer.cornerRadius = 8
        button.backgroundColor = .yellow
        return button
    }()
    
    private lazy var deleteButton: ButtonComponent = {
        let button = ButtonComponent(token: self.token, receiveState: false)
        button.title = "DELETE"
        button.layer.cornerRadius = 8
        button.backgroundColor = UIColor.red.withAlphaComponent(0.5)
        return button
    }()
    
    override func setupView() {
        
        addSubview(card)
        card.addSubview(emojiLabel)
        card.addSubview(nameLabel)
        card.addSubview(usernameLabel)
        card.addSubview(emailLabel)
        card.addSubview(phoneLabel)
        card.addSubview(updateButton)
        card.addSubview(deleteButton)
        
        card.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(8)
            make.right.bottom.equalToSuperview().offset(-8)
        }
        
        emojiLabel.snp.makeConstraints { (make) in
            make.width.height.equalTo(125)
            make.left.equalToSuperview().offset(8)
            make.centerY.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(emojiLabel.snp.right).offset(8)
            make.right.equalToSuperview().offset(-8)
            make.top.equalTo(emojiLabel).offset(8)
        }
        
        usernameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
        }
        
        emailLabel.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel)
            make.top.equalTo(usernameLabel.snp.bottom).offset(8)
        }
        
        phoneLabel.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel)
            make.top.equalTo(emailLabel.snp.bottom).offset(8)
        }
        
        updateButton.snp.makeConstraints { (make) in
            make.right.bottom.equalToSuperview().offset(-8)
            make.height.equalTo(30)
            make.width.equalTo(88)
        }
        
        deleteButton.snp.makeConstraints { (make) in
            make.right.equalTo(updateButton.snp.left).offset(-4)
            make.bottom.width.height.equalTo(updateButton)
        }
        
        self.backgroundColor = .clear
        
        
        updateButton.action = { [weak self] (sender) in
            guard let user = self?.user else { return }
            sender.dispatch(action: UpdateUserAction(user: user))
        }
        
        deleteButton.action = { [weak self] (sender) in
            guard let user = self?.user else { return }
            sender.dispatch(action: DeleteUserAction(user: user))
        }
    }
    
    override var contentSize: CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 160)
    }
    
    override func configure<Item>(item: Item, at indexPath: IndexPath) {
        guard let userItem = item as? UserItemModel else { return }
        self.user = userItem.user
        
        nameLabel.text = userItem.user.name
        usernameLabel.text = userItem.user.username
        emailLabel.text = userItem.user.email
        phoneLabel.text = userItem.user.phone
    }
}

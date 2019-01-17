//
//  ChatTableViewCell.swift
//  prac
//
//  Created by HigherVisibility on 16/01/2019.
//  Copyright © 2019 ahmedHigherVisibility. All rights reserved.
//

import UIKit



class ChatTableViewCell: UITableViewCell {
    let MessageLabel = UILabel()
    let backgroundBubbleView = UIView()
    
    var leadingConstraint:NSLayoutConstraint!
    var trailingConstraint : NSLayoutConstraint!
    
    var chatMessageCell : ChatMessage! {
        didSet{
        backgroundBubbleView.backgroundColor = chatMessageCell.isIncoming ? .white : .darkGray
            MessageLabel.textColor = chatMessageCell.isIncoming ? .black  : .white
            MessageLabel.text = chatMessageCell.text
            if chatMessageCell.isIncoming{
                leadingConstraint.isActive = true
                trailingConstraint.isActive = false
            }
            else{
                leadingConstraint.isActive = false
                trailingConstraint.isActive = true
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        backgroundBubbleView.backgroundColor = .clear
        backgroundBubbleView.layer.cornerRadius = 15
        backgroundBubbleView.translatesAutoresizingMaskIntoConstraints = false

        MessageLabel.translatesAutoresizingMaskIntoConstraints = false
        MessageLabel.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        MessageLabel.text = " hello "
//        MessageLabel.backgroundColor = .yellow
        
        addSubview(backgroundBubbleView)
        addSubview(MessageLabel)
        
      let constraints = [  MessageLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 25),
                           MessageLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -32), MessageLabel.widthAnchor.constraint(lessThanOrEqualToConstant : 250),
         
         backgroundBubbleView.topAnchor.constraint(equalTo: MessageLabel.topAnchor, constant: -16),
         backgroundBubbleView.bottomAnchor.constraint(equalTo: MessageLabel.bottomAnchor, constant: 16),
         backgroundBubbleView.leadingAnchor.constraint(equalTo: MessageLabel.leadingAnchor, constant: -16),
         backgroundBubbleView.trailingAnchor.constraint(equalTo: MessageLabel.trailingAnchor, constant: 10)

        ]
        NSLayoutConstraint.activate(constraints)
        
         leadingConstraint = MessageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 32)
         leadingConstraint.isActive = true
        
        
         trailingConstraint = MessageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -32)
        trailingConstraint.isActive = false
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

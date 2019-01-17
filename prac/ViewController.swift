//
//  ViewController.swift
//  prac
//
//  Created by HigherVisibility on 16/01/2019.
//  Copyright © 2019 ahmedHigherVisibility. All rights reserved.
//

import UIKit
struct ChatMessage {
    let text : String
    let isIncoming : Bool
    let date : Date
    
}
extension Date {
    static func dateFromCustomString(customString :String)-> Date{
    let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter.date(from: customString) ?? Date()
    }
    func reduceToMonthDayYear() -> Date {
        let calendar = Calendar.current
        let month = calendar.component(.month, from: self)
        let day = calendar.component(.day, from: self)
        let year = calendar.component(.year, from: self)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter.date(from: "\(month)/\(day)/\(year)") ?? Date()
    }
}

class ViewController: UITableViewController {
    let cellID = "cellID"
    var chatArr = [[ChatMessage]]()
//    var chatArr = [
//        [ChatMessage(message: "hello hi you doing?", isIncoming: true ,date : Date.customeDateFromString(custom: "01/17/2019")),
//        ChatMessage(message: "i am fine ", isIncoming: false,date : Date.customeDateFromString(custom: "01/17/2019"))
//        ],
//        [ChatMessage(message: "String is the ultimate global discovery app—making it easier than ever to find great places with our intelligent algorithms, chat about them with friends, secure reservations, and tap into a network of local hospitality Experts.", isIncoming: true,date : Date.customeDateFromString(custom: "01/18/2019"))
//        ],
//        [
//        ChatMessage(message: "The String Expert Network help make it possible to experience the world as an insider ", isIncoming: false,date : Date.customeDateFromString(custom: "01/19/2019")),
//        ChatMessage(message: "String algorithms learn as you use the app based on who's in your network and places you like; the more you recommend and request places, the smarter it gets.  ", isIncoming: false,date : Date.customeDateFromString(custom: "01/20/2019")),
//        ChatMessage(message: "From Access to Reservations, Trip Planning to Nightlife - book an experience or subscribe to your personal Expert to chat and make that next night out or trip one to remember! ", isIncoming: false,date : Date.customeDateFromString(custom: "01/21/2019"))
//        ]
//    ]
    let messagesFromServer : [ChatMessage] = [
        ChatMessage(text: "Here's my very first message", isIncoming: true, date: Date.dateFromCustomString(customString: "08/03/2018")),
        ChatMessage(text: "I'm going to message another long message that will word wrap", isIncoming: true, date: Date.dateFromCustomString(customString: "08/03/2018")),
        ChatMessage(text: "I'm going to message another long message that will word wrap, I'm going to message another long message that will word wrap, I'm going to message another long message that will word wrap", isIncoming: false, date: Date.dateFromCustomString(customString: "09/15/2018")),
        ChatMessage(text: "Yo, dawg, Whaddup!", isIncoming: false, date: Date()),
        ChatMessage(text: "This message should appear on the left with a white background bubble", isIncoming: true, date: Date.dateFromCustomString(customString: "09/15/2018")),
        ChatMessage(text: "Third Section message", isIncoming: true, date: Date.dateFromCustomString(customString: "10/31/2018"))
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        attemptToAssembleGroupedMessages()
        navigationItem.title = "Messages"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.register(ChatTableViewCell.self, forCellReuseIdentifier: cellID)
tableView.separatorStyle = .none
        
        tableView.backgroundColor = UIColor.init(white: 0.9, alpha: 1)
        // Do any additional setup after loading the view, typically from a nib.
    }
    fileprivate func attemptToAssembleGroupedMessages() {
        print("blabla")
        
        let groupedMessages = Dictionary.init(grouping: messagesFromServer) { (element) -> Date in
            
            return element.date.reduceToMonthDayYear()
        }
        
        let sortedKeys = groupedMessages.keys.sorted()
        sortedKeys.forEach { (key) in
            let values = groupedMessages[key]
            chatArr.append(values ?? [])
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatArr[section].count
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return chatArr.count
    }
    
    class titleLabel : UILabel {
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            backgroundColor = .black
            
            textColor = .white
            textAlignment = .center
            translatesAutoresizingMaskIntoConstraints = false
            font = UIFont.boldSystemFont(ofSize: 14)
           
            
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        override var intrinsicContentSize: CGSize {
           let originalIntrinsicSize =  super.intrinsicContentSize
            let height = originalIntrinsicSize.height+12
            let width = originalIntrinsicSize.width
            layer.cornerRadius = height/2
            layer.masksToBounds = true
            
            return CGSize(width: width+20, height: height)
        }
    }
    
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let containerView = UIView()
        containerView.backgroundColor = .clear

        let label = titleLabel()
        
        if let firstMessageInSection = chatArr[section].first{
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "MM/dd/yyyy"
                        let dateString = dateFormatter.string(from: firstMessageInSection.date)
            
            
                label.text =  dateString
            
                containerView.addSubview(label)
            
           label.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive=true
            label.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive=true
            
                return containerView
            
                    }
        return containerView
        }
        
    
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        if let firstMessageInSection = chatArr[section].first{
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "MM/dd/yyyy"
//            let dateString = dateFormatter.string(from: firstMessageInSection.date)
//            return dateString
//        }
//        return "section \(Date())"
//    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? ChatTableViewCell else {
            return UITableViewCell()
        }
        
        cell.MessageLabel.numberOfLines = 0
        cell.chatMessageCell = chatArr[indexPath.section][indexPath.row]
        return cell
    }
}


//
//  ViewController.swift
//  prac
//
//  Created by HigherVisibility on 16/01/2019.
//  Copyright © 2019 ahmedHigherVisibility. All rights reserved.
//

import UIKit
struct ChatMessage {
    let message : String
    let isIncoming : Bool
    
}


class ViewController: UITableViewController {
    let cellID = "cellID"
    var chatArr = [ChatMessage(message: "hello hi you doing?", isIncoming: true),
                   ChatMessage(message: "i am fine ", isIncoming: false),
                   ChatMessage(message: "hello hi you doing?", isIncoming: true),
                   ChatMessage(message: "i am fine ", isIncoming: false)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Messages"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.register(ChatTableViewCell.self, forCellReuseIdentifier: cellID)
tableView.separatorStyle = .none
        
        tableView.backgroundColor = UIColor.init(white: 0.9, alpha: 1)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatArr.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? ChatTableViewCell else {
            return UITableViewCell()
        }
        
        
        cell.MessageLabel.numberOfLines = 0
        cell.chatMessageCell = chatArr[indexPath.row] 
        return cell
    }
}


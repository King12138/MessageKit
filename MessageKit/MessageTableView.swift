//
//  MessageTableView.swift
//  MessageKit
//
//  Created by ChenHao on 1/28/16.
//  Copyright © 2016 HarriesChen. All rights reserved.
//

import UIKit

class MessageTableView: UITableView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configTableView()
    }
    
    func configTableView() {
        self.registerNib(MessageTextCellIncoming.nib, forCellReuseIdentifier: MessageTextCellIncoming.reuseIdentifier)
        
        self.registerNib(MessageTextCellOutcoming.nib, forCellReuseIdentifier: MessageTextCellOutcoming.reuseIdentifier)
        
        self.registerNib(MessagePhotoCellIncoming.nib, forCellReuseIdentifier: MessagePhotoCellIncoming.reuseIdentifier)
        
        self.registerNib(MessagePhotoCellOutcoming.nib, forCellReuseIdentifier: MessagePhotoCellOutcoming.reuseIdentifier)
    }

}

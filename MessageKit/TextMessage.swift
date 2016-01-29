//
//  TextMessage.swift
//  MessageKit
//
//  Created by ChenHao on 1/28/16.
//  Copyright © 2016 HarriesChen. All rights reserved.
//

import UIKit

public class TextMessage: BasicMessage {
    
    var messageText: String
    public init(text: String) {
        messageText = text
    }
}

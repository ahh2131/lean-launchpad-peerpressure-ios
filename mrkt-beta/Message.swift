//
//  Message.swift
//  mrkt-beta
//
//  Created by Andy Hadjigeorgiou on 12/8/14.
//  Copyright (c) 2014 vigme. All rights reserved.
//

import Foundation

class Message {
    let incoming: Bool
    let text: String
    let sentDate: NSDate
    
    init(incoming: Bool, text: String, sentDate: NSDate) {
        self.incoming = incoming
        self.text = text
        self.sentDate = sentDate
    }
}

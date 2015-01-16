//
//  Account.swift
//  mrkt-beta
//
//  Created by Andy Hadjigeorgiou on 12/8/14.
//  Copyright (c) 2014 vigme. All rights reserved.
//

class Account {
    let user: User
    var chats = [Chat]()
    
    init(user: User) {
        self.user = user
    }
}

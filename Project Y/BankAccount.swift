//
//  BankAccount.swift
//  Project Y
//
//  Created by Adam Khazi on 29/05/2015.
//  Copyright (c) 2015 Adam Khazi. All rights reserved.
//

import Foundation

import UIKit

class BankAccount: NSObject {
    var accountName: String 
    
    var bankName: String
    
    var bankBalance: Double
    
    init(accountName: String, bankName: String, bankBalance: Double) {
        self.accountName = accountName
        self.bankName = bankName
        self.bankBalance = bankBalance
        super.init()
    }
    
    
}
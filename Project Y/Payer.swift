//
//  Payer.swift
//  Project Y
//
//  Created by Adam Khazi on 11/06/2015.
//  Copyright (c) 2015 Adam Khazi. All rights reserved.
//

import Foundation
import UIKit

class Payer: NSObject {
    
    //Name of company - required
    var company: String
    
    //Name of bank person - optional
    var name: String
    
    init(company: String, name: String) {
        
        self.company = company
        self.name = name
        
        super.init()
        
    }
    
    
}
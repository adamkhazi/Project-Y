//
//  UsefulUtilities.swift
//  Project Y
//
//  Created by Adam Khazi on 08/06/2015.
//  Copyright (c) 2015 Adam Khazi. All rights reserved.
//

import Foundation
import UIKit

class UsefulUtilities: UITableViewController {
    
    /* convert string to double */
    func s2D(stringToConvert: String) -> Double
    {
        var stringConversion = NSString(string: stringToConvert)
        return stringConversion.doubleValue
    }
}

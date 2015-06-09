//
//  UITVCEnhanced.swift
//  Project Y
//
//  Created by Adam Khazi on 09/06/2015.
//  Copyright (c) 2015 Adam Khazi. All rights reserved.
//

import Foundation
import UIKit

class UITVCEnhanced: UITableViewController {
    
    /* convert string to double */
    func s2D(stringToConvert: String) -> Double
    {
        var stringConversion = NSString(string: stringToConvert)
        return stringConversion.doubleValue
    }
    
    /* convert double to string - 2 decimal places */
    func d2S(doubleToConvert: Double) -> String
    {
        var doubleConversion = NSString(format:"%.2f", (doubleToConvert as Double)) as String
        return doubleConversion
        
    }
    //TODO - remove file path to file name
    /* consistent logging */
    func log(logMessage: String, functionName: String = __FUNCTION__, fileName: String = __FILE__)
    {
        
        println("\(fileName) -> \(functionName): \(logMessage)")
    }
}

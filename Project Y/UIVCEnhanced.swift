//
//  UIVCEnhanced.swift
//  Project Y
//
//  Created by Adam Khazi on 27/06/2015.
//  Copyright (c) 2015 Adam Khazi. All rights reserved.
//

import Foundation

class UIVCEnhanced: UIViewController {
    
    // MARK: Literal Conversions
    
    /* check if a string can be converted to a valid double */
    func stringIsValidDouble(stringToCheck: String) -> Bool
    {
        if stringToCheck.rangeOfString("^(?:|0|[1-9]\\d*)(?:\\.\\d*)?$", options: .RegularExpressionSearch) != nil
        {
            return true
        }
        return false
    }
    
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
    
    // MARK: log
    
    //TODO - remove file path to file name
    /* consistent logging */
    func log(logMessage: String, functionName: String = __FUNCTION__, fileName: String = __FILE__)
    {
        
        println("\(fileName) -> \(functionName): \(logMessage)")
    }
    
    // MARK: Utility
    
    /* shake text field reference. Usually used to indicate wrong entry */
    func shakeField(textFieldToShake: UITextField)
    {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(CGPoint: CGPointMake(textFieldToShake.center.x - 10, textFieldToShake.center.y))
        animation.toValue = NSValue(CGPoint: CGPointMake(textFieldToShake.center.x + 10, textFieldToShake.center.y))
        textFieldToShake.layer.addAnimation(animation, forKey: "position")
    }
}
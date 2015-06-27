//
//  ExtendedNavBarView.swift
//  Project Y
//
//  Created by Adam Khazi on 26/06/2015.
//  Copyright (c) 2015 Adam Khazi. All rights reserved.
//

import Foundation
import UIKit

class ExtendedNavBarView: UIView {
    
    // called when the view is about to be displayed. may be called more than once
    override func willMoveToWindow(newWindow: UIWindow!){
        
        // Use the layer shadow to draw a one pixel hairline under this view
        self.layer.shadowOffset = CGSizeMake(0.0, 1.0/UIScreen.mainScreen().scale)
        self.layer.shadowRadius = 0
        
        // UINavigationBar's hairline is adaptivem its properties change with the contents it overlies. May need to experiment with these values to best match your content.
        self.layer.shadowColor = UIColor.blackColor().CGColor
        self.layer.shadowOpacity = Float(0.25)
        
    }
}
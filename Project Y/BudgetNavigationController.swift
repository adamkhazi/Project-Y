//
//  BudgetNavigationController.swift
//  Project Y
//
//  Created by Adam Khazi on 13/06/2015.
//  Copyright (c) 2015 Adam Khazi. All rights reserved.
//

import UIKit

class BudgetNavigationController: UINavigationController, UIViewControllerTransitioningDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Status bar white font
        self.navigationBar.barStyle = UIBarStyle.Black
        self.navigationBar.tintColor = UIColor.whiteColor()
        
        
    }
}

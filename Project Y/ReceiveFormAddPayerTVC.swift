//
//  ReceiveFormAddPayerTVC.swift
//  Project Y
//
//  Created by Adam Khazi on 11/06/2015.
//  Copyright (c) 2015 Adam Khazi. All rights reserved.
//

import UIKit
import CoreData

class ReceiveFormAddPayerTVC: UITableViewController {
    
    // new payer
    var payer: Payer!
    
    // field connectors
    @IBOutlet weak var companyField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /* Table view data source protocol methods START */
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 2
    }
    
    //tapping anywhere in a specific row brings up keyboard
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 {
            companyField.becomeFirstResponder()
        }
        if indexPath.row == 1 {
            nameField.becomeFirstResponder()
        }
        
    }
    
    /* Table view data source protocol methods END */

    //prepare for unwind
    //saves field data into payee object
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SavePayerDetail" {
            payer = Payer(company: companyField.text, name: nameField.text)
            
            //debug
            println("Add Screen - Prepare for segue ran. Add Screen -> Payees table")
        }
    }

}

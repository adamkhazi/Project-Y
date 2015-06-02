//
//  AddPayeeTableViewController.swift
//  Project Y
//
//  Created by Adam Khazi on 02/06/2015.
//  Copyright (c) 2015 Adam Khazi. All rights reserved.
//

import UIKit
import CoreData

class AddPayeeTableViewController: UITableViewController {

    //new payee
    var payee: Payee!
    
    //field connectors
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
    
    // MARK: - Table view data source
    
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
    
    //prepare for unwind
    //saves field data into payee object
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SavePayeeDetail" {
            payee = Payee(company: companyField.text, name: nameField.text)
            
            println(payee.company)
        }
    }
    
}

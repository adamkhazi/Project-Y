//
//  AddAccountTableViewController.swift
//  Project Y
//
//  Created by Adam Khazi on 16/05/2015.
//  Copyright (c) 2015 Adam Khazi. All rights reserved.
//

import UIKit
import CoreData

class AddAccountTableViewController: UITVCEnhanced, UITableViewDataSource{

    var bankAccount:BankAccount!
    
    @IBOutlet weak var accountName: UITextField!
    @IBOutlet weak var bankName: UITextField!
    @IBOutlet weak var bankBalance: UITextField!
    
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
        return 3
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 {
            accountName.becomeFirstResponder()
        }
        if indexPath.row == 1 {
            bankName.becomeFirstResponder()
        }
        if indexPath.row == 2 {
            bankBalance.becomeFirstResponder()
        }
    }
//     In a storyboard-based application, you will often want to do a little preparation before navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SaveAccountDetail" {
            bankAccount = BankAccount(accountName: self.accountName.text, bankName: self.bankName.text, bankBalance: s2D(self.bankBalance.text))
        }
    }
    
}

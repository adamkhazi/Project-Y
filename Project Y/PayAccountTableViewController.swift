//
//  PayAccountTableViewController.swift
//  Project Y
//
//  Created by Adam Khazi on 31/05/2015.
//  Copyright (c) 2015 Adam Khazi. All rights reserved.
//

import UIKit
import CoreData

class PayAccountTableViewController: UITVCEnhanced, UITableViewDataSource {
    
    var accounts = [NSManagedObject]()

    //holds bank account selection
    var selectedBankAccount:BankAccount!
    
    //holds currently selected account index 
    var selectedAccountIndex:Int? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    //load data from entity into nsobjectmodel
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        loadAccounts()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return accounts.count
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    //dequeues table view cells and populates them with
    //corresponding index in nsobject
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell =
        tableView.dequeueReusableCellWithIdentifier("AccountCell", forIndexPath: indexPath)
            as! UITableViewCell
        
        let account = accounts[indexPath.row]
        
        if let nameLabel = cell.viewWithTag(100) as? UILabel
        {
            nameLabel.text = account.valueForKey("name") as? String
        }
        if let bankNameLabel = cell.viewWithTag(101) as? UILabel {
            bankNameLabel.text = account.valueForKey("bank_name") as? String
        }
        if let bankBalanceLabel = cell.viewWithTag(102) as? UILabel {
            bankBalanceLabel.text =
                d2S((account.valueForKey("balance") as? Double)!)
        }
        
        //checkmark if index was selected
        if indexPath.row == selectedAccountIndex {
            cell.accessoryType = .Checkmark
        } else {
            cell.accessoryType = .None
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        //Other row is selected - need to deselect it
        if let index = selectedAccountIndex {
            let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: index, inSection: 0))
            cell?.accessoryType = .None
        }
        
        //change selected row
        selectedAccountIndex = indexPath.row
        
        //update the checkmark for the current row
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        
        cell?.accessoryType = .Checkmark
    }
    
    //function that loads accounts from entity into nsobject
    func loadAccounts(){
        
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
        
        let fetchRequest = NSFetchRequest(entityName:"Accounts")
        
        
        var error: NSError?
        
        let fetchedResults =
        managedContext.executeFetchRequest(fetchRequest,
            error: &error) as? [NSManagedObject]
        
        if let results = fetchedResults {
            accounts = results
        } else {
            println("Could not fetch \(error), \(error!.userInfo)")
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SaveAccountDetail" {
            if let cell = sender as? UITableViewCell {
                let indexPath = tableView.indexPathForCell(cell)
                
                selectedAccountIndex = indexPath?.row
                
                //get account index selected's details
                let account = accounts[indexPath!.row]
                
                //save details to an account object
                selectedBankAccount = BankAccount(accountName: (account.valueForKey("name") as? String)!, bankName: (account.valueForKey("bank_name") as? String)!, bankBalance: (account.valueForKey("balance") as? Double)!)
            }
        }
    }
}

//
//  AccountSettingsTableViewController.swift
//  Project Y
//
//  Created by Adam Khazi on 16/05/2015.
//  Copyright (c) 2015 Adam Khazi. All rights reserved.
//

import UIKit
import CoreData

class AccountSettingsTableViewController: UITVCEnhanced, UITableViewDataSource {

    var accounts = [NSManagedObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerClass(UITableViewCell.self,
            forCellReuseIdentifier: "AccountCell")
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    //moves to addaccounttableviewcontroller
    @IBAction func addAccount(sender: AnyObject) {
        //add button here does nothing
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
    //corresponding index in array
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell =
        tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
            as! UITableViewCell
        
        let account = accounts[indexPath.row]
        
        if let nameLabel = cell.viewWithTag(100) as? UILabel
        { //3
            nameLabel.text = account.valueForKey("name") as? String
        }
        if let bankNameLabel = cell.viewWithTag(101) as? UILabel {
            bankNameLabel.text = account.valueForKey("bank_name") as? String
        }
        if let bankBalanceLabel = cell.viewWithTag(102) as? UILabel
        {
            bankBalanceLabel.text =
                d2S((account.valueForKey("balance") as? Double)!)
        }
        
        return cell
    }
    
    //unwind segue - cancel
    @IBAction func cancelToAccountSettingsViewController(segue:UIStoryboardSegue) {
        
    }
    
    //unwind segue - save
    @IBAction func saveAccountDetail(segue:UIStoryboardSegue) {
        if let addAccountTableViewController = segue.sourceViewController as? AddAccountTableViewController {
            
            //add the new account to the accounts nsobject
            saveAccount(addAccountTableViewController.bankAccount)
            
            //reload data into nsobject
            loadAccounts()
            
            //update the tableView
            let indexPath = NSIndexPath(forRow: accounts.count-1, inSection: 0)
            tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
    }
    
    //saves to sql entity 'Accounts'
    func saveAccount(accountDetail: BankAccount) {
        //1
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
        //2
        let entity =  NSEntityDescription.entityForName("Accounts",
            inManagedObjectContext:
            managedContext)
        
        let account = NSManagedObject(entity: entity!,
            insertIntoManagedObjectContext:managedContext)
        
        //3
        account.setValue(accountDetail.accountName, forKey: "name")
        account.setValue(accountDetail.bankName, forKey: "bank_name")
        account.setValue(accountDetail.bankBalance, forKey: "balance")
        
        //4
        var error: NSError?
        if !managedContext.save(&error) {
            println("Could not save \(error), \(error?.userInfo)")
        }
    }
    
    //function that loads accounts from entity into nsobject
    func loadAccounts(){
        //1
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
    
        let managedContext = appDelegate.managedObjectContext!
    
        //2
        let fetchRequest = NSFetchRequest(entityName:"Accounts")
    
        //3
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
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    
     //Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        switch editingStyle {
        case .Delete:
            // remove the deleted item from the model
            let appDelegate =
            UIApplication.sharedApplication().delegate as! AppDelegate
            
            let context:NSManagedObjectContext = appDelegate.managedObjectContext!
            context.deleteObject(accounts[indexPath.row] as NSManagedObject)
            
            accounts.removeAtIndex(indexPath.row)
            context.save(nil)
            
             //Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
        default:
                return
        }
    }


    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  PayFormPayeesTableViewController.swift
//  Project Y
//
//  Created by Adam Khazi on 02/06/2015.
//  Copyright (c) 2015 Adam Khazi. All rights reserved.
//

import UIKit
import CoreData

class PayFormPayeesTableViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!

    //search active or not
    var searchActive : Bool = false
    //search bar filtered results
    var filtered = [NSManagedObject]()
    
    //for the payees table
    var payees = [NSManagedObject]()
    
    //holds selected payee
    var selectedPayee:Payee!
    
    //holds currently selected account index
    var selectedPayeeIndex:Int? = nil
    
    //holds to-save payee
    var payee:Payee!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* setup delegates */
        searchBar.delegate = self
        
//        tableView.registerClass(UITableViewCell.self,
//            forCellReuseIdentifier: "PayeeCell")
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    //load data from entity into nsobjectmodel
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        loadPayees()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        if (searchActive){
            return filtered.count
        }
        return payees.count
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    //dequeues table view cells and populates them with
    //corresponding index in nsobject
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell =
        tableView.dequeueReusableCellWithIdentifier("PayeeCell", forIndexPath: indexPath)
            as! UITableViewCell
        
        if (searchActive){ //search active
            let payee = filtered[indexPath.row]
            
            if let companyLabel = cell.viewWithTag(103) as? UILabel
            {
                companyLabel.text = payee.valueForKey("company") as? String
            }
            
            if let nameLabel = cell.viewWithTag(104) as? UILabel
            {
                nameLabel.text = payee.valueForKey( "name") as? String
            }
            
        } else { //search not active
            let payee = payees[indexPath.row]
            
            if let companyLabel = cell.viewWithTag(103) as? UILabel
            {
                companyLabel.text = payee.valueForKey("company") as? String
            }
            
            if let nameLabel = cell.viewWithTag(104) as? UILabel
            {
                nameLabel.text = payee.valueForKey( "name") as? String
            }
        }
        
        //checkmark if index was selected
        if indexPath.row == selectedPayeeIndex{
            cell.accessoryType = .Checkmark
        } else {
            cell.accessoryType = .None
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        //Other row is selected - need to deselect it
        if let index = selectedPayeeIndex {
            let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: index, inSection: 0))
            cell?.accessoryType = .None
        }
        
        //change selected row
        selectedPayeeIndex = indexPath.row
        
        //update the checkmark for the current row
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        
        cell?.accessoryType = .Checkmark
    }
    
    //function that loads payees from entity into nsobject
    func loadPayees(){
        
        //1
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
        //2
        let fetchRequest = NSFetchRequest(entityName:"Payees")
        
        //3
        var error: NSError?
        
        let fetchedResults =
        managedContext.executeFetchRequest(fetchRequest,
            error: &error) as? [NSManagedObject]
        
        if let results = fetchedResults {
            payees = results
        } else {
            println("Could not fetch \(error), \(error!.userInfo)")
        }
    }
    
    //support deleting rows of the table
    //Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        switch editingStyle {
        case .Delete:
            // remove the deleted item from the model
            let appDelegate =
            UIApplication.sharedApplication().delegate as! AppDelegate
            
            let context:NSManagedObjectContext = appDelegate.managedObjectContext!
            context.deleteObject(payees[indexPath.row] as NSManagedObject)
            
            payees.removeAtIndex(indexPath.row)
            context.save(nil)
            
            //Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
        default:
            return
        }
    }
    
    //unwind segue - save payee - from Add Payee Detail screen
    @IBAction func savePayeeDetail(segue:UIStoryboardSegue) {
        if let addPayeeTableViewController = segue.sourceViewController as? AddPayeeTableViewController {
            
            //add the new account to the accounts nsobject
            savePayee(addPayeeTableViewController.payee)
            
            //reload data into nsobject
            loadPayees()
            
            //update the tableView
            let indexPath = NSIndexPath(forRow: payees.count-1, inSection: 0)
            tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            //debug
            println("Payees Table - Unwind Segue 'savePayeeDetail' - " + "Add Payee -> Payee Table")
        }
    }
    
    //unwind segue - cancel save payee
    @IBAction func cancelSavePayee(segue:UIStoryboardSegue) {
        
    }
    
    //saves to sql entity 'Payees'
    func savePayee(payeeDetail: Payee) {
        //1
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
        //2
        let entity =  NSEntityDescription.entityForName("Payees",
            inManagedObjectContext:
            managedContext)
        
        let payee = NSManagedObject(entity: entity!,
            insertIntoManagedObjectContext:managedContext)
        
        //3
        payee.setValue(payeeDetail.company, forKey: "company")
        payee.setValue(payeeDetail.name, forKey: "name")
        
        //4
        var error: NSError?
        if !managedContext.save(&error) {
            println("Could not save \(error), \(error?.userInfo)")
        }
    }
    
    //unwind segue back to Pay Table
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //debug
        println("ran Payees Table - Prepare for segue ran. PayeesTable -> Pay Table")
        
        if segue.identifier == "SaveSelectedPayee" {
            if let cell = sender as? UITableViewCell {
                
                let indexPath = tableView.indexPathForCell(cell)
                
                selectedPayeeIndex = indexPath?.row
                
                //get account index selected's details
                let payee = payees[indexPath!.row]
                
                //save details to an account object
                selectedPayee = Payee(company: (payee.valueForKey("company") as? String)!, name: (payee.valueForKey("name") as? String)!)
                
                //debug
                println("Payees Table - Prepare for segue ran. PayeesTable -> Pay Table")
            }
        }
    }
    
    /* Search Bar conformation */
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
//        filtered = data.filter({ (text) -> Bool in
//            let tmp: NSString = text
//            let range = tmp.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
//            return range.location != NSNotFound
//        })
        
        /* returns entity */
        let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
        let request = NSFetchRequest(entityName:"Payees")
        
        request.returnsObjectsAsFaults = false      //will return the instance of the object
        
        let sortDescriptor = NSSortDescriptor(key:"company", ascending: true)
        let sortDescriptors = [sortDescriptor]
        request.sortDescriptors = sortDescriptors
        
        request.predicate = NSPredicate(format:"company contains[search] %@", searchText)
        
        var error: NSError?
        
        let fetchedResults = managedContext.executeFetchRequest(request, error: &error) as? [NSManagedObject]
        
        if let results = fetchedResults {
            filtered = results
        } else {
            println("Could not fetch \(error), \(error!.userInfo)")
        }
        
        /* Debug messages */
//        var payeeTest = filtered[0]
//        print(payeeTest.valueForKey("company") as? String)
        
//        payeeTest = filtered[1]
//        print(payeeTest.valueForKey("company") as? String)
        
        if(filtered.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
            print("search active.")
        }
        self.tableView.reloadData()
    }
    
}

//
//  ReceiveFormPayersTableTVC.swift
//  Project Y
//
//  Created by Adam Khazi on 09/06/2015.
//  Copyright (c) 2015 Adam Khazi. All rights reserved.
//

import UIKit
import CoreData

class ReceiveFormPayersTableTVC: UITVCEnhanced, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
        
    @IBOutlet weak var searchBar: UISearchBar!
    
    //search active or not
    var searchActive : Bool = false
    //search bar filtered results
    var filtered = [NSManagedObject]()
    
    //for the payers table
    var payers = [NSManagedObject]()
    
    //holds selected payer
    var selectedPayer:Payer!
    
    //holds currently selected account index
    var selectedpayerIndex:Int? = nil
    
    //holds to-save payer
    var payer:Payer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* setup delegates */
        searchBar.delegate = self
    }
    
    //load data from entity into NSManagedObject
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        loadPayers()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /* Table View Data source protocol methods START */
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        if (searchActive){
            return filtered.count
        }
        return payers.count
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    //dequeues table view cells and populates them with
    //corresponding index in nsobject
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell =
        tableView.dequeueReusableCellWithIdentifier("PayerCell", forIndexPath: indexPath)
            as! UITableViewCell
        
        if (searchActive){ //search active
            let payer = filtered[indexPath.row]
            
            if let companyLabel = cell.viewWithTag(300) as? UILabel
            {
                companyLabel.text = payer.valueForKey("company") as? String
            }
            
            if let nameLabel = cell.viewWithTag(301) as? UILabel
            {
                nameLabel.text = payer.valueForKey("name") as? String
            }
            
        } else { //search not active
            let payer = payers[indexPath.row]
            
            if let companyLabel = cell.viewWithTag(300) as? UILabel
            {
                companyLabel.text = payer.valueForKey("company") as? String
            }
            
            if let nameLabel = cell.viewWithTag(301) as? UILabel
            {
                nameLabel.text = payer.valueForKey( "name") as? String
            }
        }
        
        //checkmark if index was selected
        if indexPath.row == selectedpayerIndex{
            cell.accessoryType = .Checkmark
        } else {
            cell.accessoryType = .None
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        //Other row is selected - need to deselect it
        if let index = selectedpayerIndex {
            let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: index, inSection: 0))
            cell?.accessoryType = .None
        }
        
        //change selected row
        selectedpayerIndex = indexPath.row
        
        //update the checkmark for the current row
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        
        cell?.accessoryType = .Checkmark
    }
    
    //Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        switch editingStyle {
        case .Delete:
            // remove the deleted item from the model
            let appDelegate =
            UIApplication.sharedApplication().delegate as! AppDelegate
            
            let context:NSManagedObjectContext = appDelegate.managedObjectContext!
            context.deleteObject(payers[indexPath.row] as NSManagedObject)
            
            payers.removeAtIndex(indexPath.row)
            context.save(nil)
            
            //Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
        default:
            return
        }
    }
    
    /* Table view data source protocol method END */
    
    // loads payers from entity into nsobject
    func loadPayers(){
    
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
        let fetchRequest = NSFetchRequest(entityName:"Payer")
        
        var error: NSError?
        
        let fetchedResults =
        managedContext.executeFetchRequest(fetchRequest,
            error: &error) as? [NSManagedObject]
        
        if let results = fetchedResults {
            payers = results
        } else {
            println("Could not fetch \(error), \(error!.userInfo)")
        }
    }
    
    //unwind segue back to Receive Table
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //debug
        log("ran Payers Table -> Receive Table")
        
        if segue.identifier == "SaveSelectedPayer" {
            if let cell = sender as? UITableViewCell {
                
                if (searchActive){
                    let indexPath = tableView.indexPathForCell(cell)
                    
                    selectedpayerIndex = indexPath?.row
                    
                    //get account index selected's details
                    let payer = filtered[indexPath!.row]
                    
                    //save details to an account object
                    selectedPayer = Payer(company: (payer.valueForKey("company") as? String)!, name: (payer.valueForKey("name") as? String)!)
                }
                else {
                    let indexPath = tableView.indexPathForCell(cell)
                    
                    selectedpayerIndex = indexPath?.row
                    
                    //get account index selected's details
                    let payer = payers[indexPath!.row]
                    
                    //save details to an account object
                    selectedPayer = Payer(company: (payer.valueForKey("company") as? String)!, name: (payer.valueForKey("name") as? String)!)
                }
            }
        }
    }
    
    /* Search Bar protcol methods */
    
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
        
        let request = NSFetchRequest(entityName:"Payer")
        
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
        //        var payerTest = filtered[0]
        //        print(payerTest.valueForKey("company") as? String)
        
        //        payerTest = filtered[1]
        //        print(payerTest.valueForKey("company") as? String)
        
        if(filtered.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
            log("search active.")
        }
        self.tableView.reloadData()
    }
    
    /* Unwind segue methods from Add Payer scene START */
    
    // unwind segue - save payer - from Add Payer Detail screen
    @IBAction func savePayerDetail(segue:UIStoryboardSegue) {
        if let receiveFormAddPayerTVC = segue.sourceViewController as? ReceiveFormAddPayerTVC {
            
            //add the new account to the accounts nsobject
            savePayer(receiveFormAddPayerTVC.payer)
            
            //reload data into nsobject
            loadPayers()
            
            //update the tableView
            let indexPath = NSIndexPath(forRow: payers.count-1, inSection: 0)
            tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            
            //debug
            log("Add Payer -> Payer Table")
        }
    }
    
    // unwind segue - cancel save payer
    @IBAction func cancelSavePayer(segue:UIStoryboardSegue) {
        
    }
    
    /* Unwind segue methods from Add Payer scene END  */
    
    //saves to sql entity 'Payers'
    func savePayer(payerDetail: Payer) {
        
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
        let entity =  NSEntityDescription.entityForName("Payer",
            inManagedObjectContext:
            managedContext)
        
        let payer = NSManagedObject(entity: entity!,
            insertIntoManagedObjectContext:managedContext)
        
        payer.setValue(payerDetail.company, forKey: "company")
        payer.setValue(payerDetail.name, forKey: "name")
        
        var error: NSError?
        if !managedContext.save(&error) {
            println("Could not save \(error), \(error?.userInfo)")
        }
    }
}

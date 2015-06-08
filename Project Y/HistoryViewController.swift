//
//  SecondViewController.swift
//  Project Y
//
//  Created by Adam Khazi on 16/05/2015.
//  Copyright (c) 2015 Adam Khazi. All rights reserved.
//

import UIKit
import CoreData

class HistoryViewController: UITableViewController {
    
    //Segmented Controller State - default set
    var sControllerState = Entity.PaymentAndReceived
    
    //Core Data source - NSManagedObject
    var payments = [NSManagedObject]()
    var received = [NSManagedObject]()
    var paymentsAndReceived = [NSManagedObject]()
    
    //Segmented Control - all, payed and received options
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //Called when the view is about to be made visible
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // set to default value of segment control
        updateSControllerState()
        
        // load data into NSManagedObject
        loadTableData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /* Segmented Control Target-Action method used to send
    control events from Controller to this method */
    @IBAction func valueChanged(sender: AnyObject) {
        
        /* Debug */
        println("Segment control value changed: " +
            "\(sControllerState)")
        
        // update state since value has just changed
        updateSControllerState()
        
        
        
        
    }
    
    /* update global variable sControllerState accoroding to 
    Segment Control */
    func updateSControllerState(){
        
        switch segmentControl.selectedSegmentIndex {
            
        case 0:
            sControllerState = Entity.PaymentAndReceived
            
        case 1:
            sControllerState = Entity.Payment
            
        case 2:
            sControllerState = Entity.Received
        
        default:
            sControllerState = Entity.PaymentAndReceived

        }
    }
    
    /* TableView Data model protocol methods */
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch sControllerState {
            
            case Entity.PaymentAndReceived:
            
                return paymentsAndReceived.count
            
            case Entity.Payment:
            
                return payments.count
            
            case Entity.Received:
        
                return received.count
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell =
        tableView.dequeueReusableCellWithIdentifier("HistoryCell", forIndexPath: indexPath)
            as! UITableViewCell
        
        // references to table row labels
        let fromLabel = cell.viewWithTag(200) as? UILabel
        let toLabel = cell.viewWithTag(201) as? UILabel
        let amountLabel = cell.viewWithTag(202) as? UILabel
        
        // single object from array 
        
        
        switch sControllerState {
            
            case Entity.PaymentAndReceived:
                
                // grab single NSManagedObject from array
                let paymentsAndReceivedRow = paymentsAndReceived[indexPath.row]
                
                // Needs Change
                // update row labels with information
                fromLabel?.text = paymentsAndReceivedRow.valueForKey("account") as? String
                toLabel?.text = paymentsAndReceivedRow.valueForKey("payee") as? String
                amountLabel?.text = NSString(format:"%f", (paymentsAndReceivedRow.valueForKey("amount") as? Double)!) as String
            
            case Entity.Payment:
                
                // grab single NSManagedObject from array
                let paymentRow = payments[indexPath.row]
                
                // update row labels with information
                fromLabel?.text = paymentRow.valueForKey("account") as? String
                toLabel?.text = paymentRow.valueForKey("payee") as? String
                amountLabel?.text = NSString(format:"%f", (paymentRow.valueForKey("amount") as? Double)!) as String
            
            case Entity.Received:
            
                // grab single NSManagedObject from array
                let receivedRow = received[indexPath.row]
                
                // update row labels with information
                fromLabel?.text = receivedRow.valueForKey("payee") as? String
                toLabel?.text = receivedRow.valueForKey("account") as? String
                amountLabel?.text = NSString(format:"%f", (receivedRow.valueForKey("amount") as? Double)!) as String
            
        }
        
        return cell
    }
    
    /* TableView Data model protocol methods End */
    
    
    func loadTableData(){
        
        // get a reference to App Delegate
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        // get a reference to ManagedObjectContext
        let managedContext = appDelegate.managedObjectContext!
        
        // create a fetch request
        var (fetchRequestOne,fetchRequestTwo) = createFetchRequestBasedOnState()
        
        //Mi-Ne-Changes
        // get results by executing request
        let fetchedResults = executeFetchRequestBasedOnState(fetchRequestOne,fetchRequestTwo: fetchRequestTwo, managedContext: managedContext)
        
        //updata data for tableview, otherwise print error
        if fetchedResults.isEmpty
        {
            updateDataBasedOnState(fetchedResults)
                
        } else {
            println("loadTableData(): No data fetched")
        }

    }
    
    /* create a case based fetch request based on segment controller state */
    func createFetchRequestBasedOnState() -> (NSFetchRequest, NSFetchRequest){
        
        var fetchRequestOne: NSFetchRequest!
        var fetchRequestTwo: NSFetchRequest!
        
        switch sControllerState {
            
        case Entity.PaymentAndReceived:
            fetchRequestOne = NSFetchRequest(entityName: Entity.Payment.rawValue)
            fetchRequestTwo = NSFetchRequest(entityName: Entity.Received.rawValue)
            
            return (fetchRequestOne, fetchRequestTwo)
            
        case Entity.Payment:
             fetchRequestOne = NSFetchRequest(entityName: Entity.Payment.rawValue)
             
            return (fetchRequestOne, fetchRequestTwo)
            
        case Entity.Received:
             fetchRequestOne = NSFetchRequest(entityName: Entity.Payment.rawValue)
            
            return (fetchRequestOne, fetchRequestTwo)
        }
    }
    
    /* execute fetch request based on segment controller state */
    func executeFetchRequestBasedOnState(fetchRequestOne: NSFetchRequest, fetchRequestTwo: NSFetchRequest, managedContext: NSManagedObjectContext) -> [NSManagedObject]{
        
        // error variable to report back
        var error: NSError?
        
        // NSManagedObject array to return
        var fetchedResult: [NSManagedObject]!
        var fetchedResultExtra: [NSManagedObject]!
        
        switch sControllerState {
            
            case Entity.PaymentAndReceived:
                
                fetchedResult = managedContext.executeFetchRequest(fetchRequestOne, error:&error) as? [NSManagedObject]
                
                fetchedResultExtra = managedContext.executeFetchRequest(fetchRequestTwo, error:&error) as? [NSManagedObject]
            
                let fetchResultMerge = fetchedResult + fetchedResultExtra
                
                return fetchResultMerge
            
            case Entity.Payment:
                
                fetchedResult = managedContext.executeFetchRequest(fetchRequestOne, error:&error) as? [NSManagedObject]
                
                return fetchedResult
            
            case Entity.Received:
                
                fetchedResult = managedContext.executeFetchRequest(fetchRequestOne, error:&error) as? [NSManagedObject]
                
                return fetchedResult
        }
    }
    
    /* update appropriate NSManagedObject array with data based on state */
    func updateDataBasedOnState(results: [NSManagedObject]) {
        
        switch sControllerState {
            
            case Entity.PaymentAndReceived:
            
                paymentsAndReceived = results
            
            case Entity.Payment:
            
                payments = results
            
            case Entity.Received:
            
                received = results
        }
    }
}

/* Enumeration used to keep state of segment controller in this class */
enum Entity: String {
    case Payment = "Payment"
    case Received = "Received"
    case PaymentAndReceived = "PaymentAndReceived"
}





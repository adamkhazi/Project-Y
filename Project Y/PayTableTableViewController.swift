//
//  PayTableTableViewController.swift
//  Project Y
//
//  Created by Adam Khazi on 16/05/2015.
//  Copyright (c) 2015 Adam Khazi. All rights reserved.
//

import UIKit

class PayTableTableViewController: UITableViewController {
    
    //From: label
    @IBOutlet weak var selectedAccountNameLabel: UILabel!
    
    //store selected bank account if chosen
    var selectedBankAccount: BankAccount?
    
    //store selected payee if chosen
    var selectedPayee: Payee?
    
    //To: label
    @IBOutlet weak var selectedPayeeLabel: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    //unwind segue - selected account
    @IBAction func selectedAccount(segue:UIStoryboardSegue)
    {
        if let payAccountTableViewController = segue.sourceViewController as? PayAccountTableViewController{
            
                self.selectedBankAccount = BankAccount(
                    accountName: payAccountTableViewController.selectedBankAccount.accountName,
                    bankName: payAccountTableViewController.selectedBankAccount.bankName,
                    bankBalance: payAccountTableViewController.selectedBankAccount.bankBalance)
            
                    updateFromAccountLabel()
            
            }
    }
    
    func updateFromAccountLabel()
    {
        selectedAccountNameLabel.text = selectedBankAccount?.accountName
    }
    
    //unwind segue - selected Payee
    @IBAction func selectedPayee(segue:UIStoryboardSegue)
    {
        if let payFormPayeesTableViewController = segue.sourceViewController as? PayFormPayeesTableViewController{
            
            self.selectedPayee = Payee(
                company: payFormPayeesTableViewController.selectedPayee.company,
                name: payFormPayeesTableViewController.selectedPayee.name)
            
            updateToPayeeLabel()
            
        }
    }
    
    func updateToPayeeLabel()
    {
        selectedPayeeLabel.text = selectedPayee?.company
        
    }

}

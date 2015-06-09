//
//  ReceiveFormTVC.swift
//  Project Y
//
//  Created by Adam Khazi on 09/06/2015.
//  Copyright (c) 2015 Adam Khazi. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ReceiveFormTVC: UITVCEnhanced, UITableViewDataSource {
    
    // From: label to indicate payer chosen
    @IBOutlet weak var payerChosenLabel: UILabel!
    // Into: label to indicate account chosen
    @IBOutlet weak var accountChosenLabel: UILabel!
    // Amount: amount transferred
    @IBOutlet weak var amountField: UITextField!
    
    //store selected bank account if chosen
    var selectedBankAccount: BankAccount?
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
    }
    
    //unwind segue - selected account
    @IBAction func selectedAccount(segue:UIStoryboardSegue)
    {
        if let payAccountTableViewController = segue.sourceViewController as? PayAccountTableViewController{
            
            self.selectedBankAccount = BankAccount(
                accountName: payAccountTableViewController.selectedBankAccount.accountName,
                bankName: payAccountTableViewController.selectedBankAccount.bankName,
                bankBalance: payAccountTableViewController.selectedBankAccount.bankBalance)
            
            updateAccountLabel()
            
        }
    }
    
    // updates account chosen label in form
    func updateAccountLabel()
    {
        accountChosenLabel.text = selectedBankAccount?.accountName
    }
    
}
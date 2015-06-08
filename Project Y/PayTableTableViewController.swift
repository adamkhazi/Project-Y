//
//  PayTableTableViewController.swift
//  Project Y
//
//  Created by Adam Khazi on 16/05/2015.
//  Copyright (c) 2015 Adam Khazi. All rights reserved.
//

import UIKit

class PayTableTableViewController: UITableViewController {
    
    //Amount: text field
    @IBOutlet weak var payAmount: UITextField!
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
            
            //debug
            println("Pay Table - Unwind Segue ran. PayeesTable -> Pay Table")
        }
    }
    
    func updateToPayeeLabel()
    {
        selectedPayeeLabel.text = selectedPayee?.company
        
    }
    
    @IBAction func makePayment(sender: AnyObject) {
        
        //switch to history tab
        self.tabBarController?.selectedIndex = 2
        
        /* To use a pre-defined segue programatically*/
        //performSegueWithIdentifier("PaymentMade", sender: self)
    }
    

}

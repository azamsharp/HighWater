//
//  ProductsTableViewController.swift
//  HighWater
//
//  Created by Mohammad Azam on 8/10/16.
//  Copyright © 2016 Mohammad Azam. All rights reserved.
//

import UIKit
import StoreKit

class ProductsTableViewController: UITableViewController, SKProductsRequestDelegate, SKPaymentTransactionObserver {

    private var productId = "HighWatersProVersion"
    private var productIds = [String]()
    private var products = [SKProduct]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SKPaymentQueue.defaultQueue().addTransactionObserver(self)
        
        requestProducts()
    }
    
    private func requestProducts() {
        
        self.productIds.append(productId)
        self.productIds.append("HighWatersGoldAccount")
        
        let productIdentifiers = NSSet(array: self.productIds) as! Set<String>
        
        let productRequest = SKProductsRequest(productIdentifiers: productIdentifiers)
        
        productRequest.delegate = self
        
        productRequest.start()
        
    }
    
    
    func paymentQueue(queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        
        for transaction in transactions {
            
            switch transaction.transactionState {
                
            case .Purchased:
                
                print("purchased")
                SKPaymentQueue.defaultQueue().finishTransaction(transaction)
                
            case .Restored:
                print("restored")
                
            case .Failed:
       
                print("failed")
                SKPaymentQueue.defaultQueue().finishTransaction(transaction)
                
            default:
                print("default")
                SKPaymentQueue.defaultQueue().finishTransaction(transaction)
                
                
            }
            
        }
        
        print("updated Transactions called")
        
    }
    
    func productsRequest(request: SKProductsRequest, didReceiveResponse response: SKProductsResponse) {
        
        for product in response.products {
            
            self.products.append(product)
            
        }
        
        self.tableView.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.products.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ProductCell", forIndexPath: indexPath)

        let product = self.products[indexPath.row]
        
        cell.textLabel?.text = product.localizedTitle
        cell.detailTextLabel?.text = product.localizedDescription
        
        return cell
    }
    
    @IBAction func buyButtonPressed() {
        
        // restoring products
      //  SKPaymentQueue.defaultQueue().restoreCompletedTransactions()
        
       // SKPaymentQueue.canMakePayments()
        
        guard let product = self.products.first else {
            fatalError("Product does not exist")
        }
        
        let payment = SKPayment(product: product)
        SKPaymentQueue.defaultQueue().addPayment(payment)
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

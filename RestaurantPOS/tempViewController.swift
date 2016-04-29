//
//  tempViewController.swift
//  RestaurantPOS
//
//  Created by Parth Bhardwaj on 4/26/16.
//  Copyright © 2016 TheThreeNoobs. All rights reserved.
//

import UIKit
import Parse
import ParseUI

var finalsales = [PFObject]()

class tempViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func fromTemp(sender: AnyObject) {
        self.performSegueWithIdentifier("fromTemp", sender: nil)
    }
    
    
    @IBAction func printActiveTables(sender: AnyObject) {
//        let query = PFQuery(className: "ActiveOrders")
//        query.includeKey("active")
//        //var tableNums = [Int]()
//        
//        query.findObjectsInBackgroundWithBlock { (orders: [PFObject]?, error: NSError?) -> Void in
//            if let orders = orders {
//                print("check")
//                //print(orders.count)
//                for order in orders{
//                    //print("wtf")
//                    //print(order)
//                    var tempFoodItem = order
//                    let tableNum = tempFoodItem["active"]["tableNumber"] as! Int
//                    //print(tableNum)
//                    
//                    if tableNums.contains(tableNum){
//                        print("table number already exists in array")
//                    }else{
//                        tableNums.append(tableNum)
//                    }
//                    
//                    //activeTables[tableNum]?.append(tempFoodItem["active"] as! PFObject)
//                    
//                    if activeTables[tableNum] != nil{
//                        activeTables[tableNum]?.append(tempFoodItem["active"] as! PFObject)
//                    }else{
//                        activeTables[tableNum] = [PFObject]()
//                        activeTables[tableNum]?.append(tempFoodItem["active"] as! PFObject)
//                    }
//                    
//                    
//                }
//                
//                print(activeTables.count)
//                
//                for num in tableNums{
//                    print(activeTables[num] as [PFObject]!)
//                }
//                
////                for table in tableNums{
////                    print(table)
////                    var temp = [PFObject]()
////                    for foodOrder in orders{
////                        var finalTable = foodOrder["active"]["tableNumber"] as! Int
////                        
////                        if finalTable==table{
////                            temp.append(foodOrder["active"] as! PFObject)
////                        }
////                    }
////                }
//                
//            } else{
//                
//            }
//        }
//        
//        activeTables = [:]
    }
    
    
    @IBAction func printActiveOrders(sender: AnyObject) {
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

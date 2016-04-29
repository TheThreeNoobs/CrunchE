//
//  ChefFirstViewController.swift
//  RestaurantPOS
//
//  Created by Parth Bhardwaj on 4/6/16.
//  Copyright © 2016 TheThreeNoobs. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import MBProgressHUD

var tableNums = [Int]()
var activeTables = [Int:[PFObject]]()


class ChefFirstViewController: UIViewController, UITableViewDelegate {
    
    var loadingHUD: MBProgressHUD = MBProgressHUD()
    
    var rowClicked = 0
    
    @IBOutlet weak var menuTable: UITableView!
    
    var refresher:UIRefreshControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        refresher = UIRefreshControl()
        
        refresher.attributedTitle = NSAttributedString(string: "Pull to refresh")
        
        refresher.addTarget(self, action: "buildTable", forControlEvents: UIControlEvents.ValueChanged)
        
        self.menuTable.addSubview(refresher)
        
        buildTable()
        
        //menuTable.reloadData()
        print("reloaded")
        
        //tableView(menuTable, numberOfRowsInSection: tableNums.count)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogout(sender: AnyObject) {
        PFUser.logOut()
        NSNotificationCenter.defaultCenter().postNotificationName("userDidLogoutNotification", object: nil)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        print(" hi \(tableNums.count)")
        if tableNums.count != 0 {
            return tableNums.count
        }else{
            return 1
        }
        //return 5
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "tableNumber")
        let tableNum = indexPath.row
        print("from tableMakes \(tableNums.count)")
        
        if(tableNums.count==0){
            cell.textLabel?.text = "Nothing to show as of now"

        }else {
            cell.textLabel?.text = "Table \(tableNums[tableNum])"
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        rowClicked = indexPath.row
        print(rowClicked)
        self.performSegueWithIdentifier("toDetailsTable", sender: nil)
    }
    
    
    func buildTable(){
        let loadingNote = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        loadingNote.mode = MBProgressHUDMode.Indeterminate
        loadingNote.labelText = "Fetching the current active orders"
        let query = PFQuery(className: "newOrder")
        query.whereKeyExists("title")
        //var tableNums = [Int]()
        
        query.findObjectsInBackgroundWithBlock { (orders: [PFObject]?, error: NSError?) -> Void in
            if let orders = orders {
                print("check")
                //print(orders.count)
                for order in orders{
                    //print("wtf")
                    //print(order)
                    var tempFoodItem = order
                    let tableNum = tempFoodItem["tableNumber"] as! Int
                    //print(tableNum)
                    
                    if tableNums.contains(tableNum){
                        print("table number already exists in array")
                    }else{
                        tableNums.append(tableNum)
                    }
                    
                    //activeTables[tableNum]?.append(tempFoodItem["active"] as! PFObject)
                    
                    if activeTables[tableNum] != nil{
                        activeTables[tableNum]?.append(order)
                    }else{
                        activeTables[tableNum] = [PFObject]()
                        activeTables[tableNum]?.append(order)
                    }
                    
                    
                }
                
                print(activeTables.count)
                
                for num in tableNums{
                    print(activeTables[num] as [PFObject]!)
                }
                
                MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
                
                self.menuTable.reloadData()
                print("reloaded")
                self.refresher.endRefreshing()
                
                //                for table in tableNums{
                //                    print(table)
                //                    var temp = [PFObject]()
                //                    for foodOrder in orders{
                //                        var finalTable = foodOrder["active"]["tableNumber"] as! Int
                //
                //                        if finalTable==table{
                //                            temp.append(foodOrder["active"] as! PFObject)
                //                        }
                //                    }
                //                }
                
            } else{
                
            }
        }
        activeTables = [:]
        tableNums = []
        
        
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toDetailsTable"{
            let dvc = segue.destinationViewController as? detailedTableViewController
            //let toGiveTable = sender
            let toGiveNum = tableNums[rowClicked]
            dvc?.dishesArray = activeTables[toGiveNum]!
            print("yo")
            print(rowClicked)
        }
    }
    

}

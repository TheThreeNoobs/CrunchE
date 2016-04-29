//
//  salesViewController.swift
//  RestaurantPOS
//
//  Created by Parth Bhardwaj on 4/28/16.
//  Copyright © 2016 TheThreeNoobs. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import MBProgressHUD

class salesViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var orderDetailsTable: UITableView!
    @IBOutlet weak var totalSalesLabel: UILabel!
    @IBOutlet weak var mostOrderedLabel: UILabel!
    
    var refresher:UIRefreshControl!
    
//    var itemArr: [String] = []
//    var item: String?
    //var finalsales = [String]()
    var frequencies = [String:Int]()
    var moneyMoney = [String:Int]()
    
    var names = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refresher = UIRefreshControl()
        
        refresher.attributedTitle = NSAttributedString(string: "Pull to refresh")
        
        refresher.addTarget(self, action: "setupSales", forControlEvents: UIControlEvents.ValueChanged)
        
        self.orderDetailsTable.addSubview(refresher)

        setupSales()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return names.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("salesDetail") as! salesTableViewCell
        
        if names.count == 0{
            cell.dishName.text = "Loading Data sets"
        }else {
            let currentName = names[indexPath.row]
            cell.dishName.text = currentName
            let setPrice = moneyMoney[currentName]! as Int
            cell.totalPrice.text = "$ \(setPrice)"
            let setFrequency = frequencies[currentName]! as Int
            cell.orderedTimes.text = "Ordered \(setFrequency) times"
        }
        
        
        
        return cell
    }
    
    func setupSales(){
        let query = PFQuery(className: "sales")
        query.whereKeyExists("title")
        query.findObjectsInBackgroundWithBlock { (sales: [PFObject]?, error: NSError?) -> Void in
            
            //        var salesProperties = PFObject(className: "sales")
            //        salesProperties["title"] = self.title
            
            let loadingNote = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            loadingNote.mode = MBProgressHUDMode.Indeterminate
            loadingNote.labelText = "Building Sales Data"
            print(sales?.count)
            for item in sales! {
                let dishPrice = item["finalPrice"] as! Int
                let dishTitle = item["title"] as! String
                //self.finalsales.append(dishTitle)
                
                
                if self.frequencies[dishTitle] != nil {
                    self.frequencies[dishTitle] = self.frequencies[dishTitle]! + 1
                }else{
                    self.frequencies[dishTitle] = 1
                }
                
                if self.moneyMoney[dishTitle] != nil {
                    self.moneyMoney[dishTitle] = self.moneyMoney[dishTitle]! + dishPrice
                }else{
                    self.moneyMoney[dishTitle] = dishPrice
                }
            }
            
            MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
            print(self.moneyMoney)
            //print(self.finalsales)
            print(self.frequencies)
            
            for key in self.frequencies.keys{
                self.names.append(key)
            }
            
            
            var total = 0
            for value  in self.moneyMoney.values{
                total = total + value
            }
            
            self.totalSalesLabel.text = "$ \(total)"
            
            var max = 0
            var maxDish = ""
            for (dish,value) in self.frequencies{
                if(value>max){
                    max=value
                    maxDish=dish
                }
            }
            
            self.mostOrderedLabel.text = "\(maxDish)"
            
            self.orderDetailsTable.reloadData()
            self.refresher.endRefreshing()
        }
        
        frequencies = [:]
        moneyMoney = [:]
        names = []
    }
        
    
    @IBAction func refreshSales(sender: AnyObject) {
        
        
        let query = PFQuery(className: "sales")
        
        query.findObjectsInBackgroundWithBlock { (objects:[PFObject]?, error:NSError?) -> Void in
            for object in objects!{
                object.deleteInBackgroundWithBlock({ (success: Bool, error:NSError?) -> Void in
                    if(success){
                        print("successfully deleted items")
                    }else{
                        print(error?.description)
                    }
                })
            }
            
            self.setupSales()
        }
        
        
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

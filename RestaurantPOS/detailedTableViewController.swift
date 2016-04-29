//
//  detailedTableViewController.swift
//  RestaurantPOS
//
//  Created by Parth Bhardwaj on 4/28/16.
//  Copyright © 2016 TheThreeNoobs. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import MBProgressHUD

class detailedTableViewController: UIViewController, UITableViewDelegate {
    @IBOutlet weak var dishesTable: UITableView!
    
    
    
    var dishesArray = [PFObject]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("hey")
        print(dishesArray)

        // Do any additional setup after loading the view.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return dishesArray.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("dishCell") as! dishDetailsTableViewCell
        
        let dish = dishesArray[indexPath.row]
        let title = dish["title"] as! String
        cell.dishName.text = title
        
        let notes = dish["notes"] as! String
        cell.dishNotes.text = notes
        
        let quant = dish["quantity"] as! Int
        cell.dishQuant.text = "\(quant)"
        
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goBack(sender: AnyObject) {
        self.performSegueWithIdentifier("toActiveTables", sender: nil)
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath){
        if editingStyle == UITableViewCellEditingStyle.Delete{
            let loadingNote = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            loadingNote.mode = MBProgressHUDMode.Indeterminate
            loadingNote.labelText = "Adding order to sales"
            let query = PFQuery(className: "newOrder")
            query.whereKey("title", equalTo: dishesArray[indexPath.row]["title"])
            query.whereKey("tableNumber", equalTo: dishesArray[indexPath.row]["tableNumber"])
            
            let salesObject = PFObject(className: "sales")
            salesObject["title"] = dishesArray[indexPath.row]["title"]
            salesObject["finalPrice"] = dishesArray[indexPath.row]["totalPrice"]
            
            
            
            salesObject.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
                if(success){
                    print("sales item saved")
                }
            }
            
            query.findObjectsInBackgroundWithBlock { (objects:[PFObject]?, error:NSError?) -> Void in
                print(objects!.count)
                
                for object in objects!{
                    object.deleteInBackgroundWithBlock({ (success: Bool, error:NSError?) -> Void in
                        if(success){
                            print("food Item removed")
                            MBProgressHUD.hideAllHUDsForView(self.view, animated: true)

                        }else{
                            print(error?.description)
                        }
                    })
                }
            }
            
            
            dishesArray.removeAtIndex(indexPath.row)
            
            dishesTable.reloadData()

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

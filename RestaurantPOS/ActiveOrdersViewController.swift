//
//  ActiveOrdersViewController.swift
//  RestaurantPOS
//
//  Created by Parth Bhardwaj on 4/26/16.
//  Copyright © 2016 TheThreeNoobs. All rights reserved.
//

import UIKit
import Parse
import ParseUI

var temp = 0


class ActiveOrdersViewController: UIViewController, UITableViewDelegate {
    @IBOutlet weak var activeOrdersTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        
        temp = 5
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return temp
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "tableNumber")
        cell.textLabel?.text="num"
        return cell
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

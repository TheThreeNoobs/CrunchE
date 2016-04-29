//
//  StaffMenuViewController.swift
//  RestaurantPOS
//
//  Created by Shakeel Daswani on 4/24/16.
//  Copyright © 2016 TheThreeNoobs. All rights reserved.
//

import UIKit
import Parse
import MBProgressHUD

class StaffMenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var menuTable: UITableView!
    var posts: [PFObject]?
    
    
    func refreshControlAction(refreshControl: UIRefreshControl) {
        self.menuTable.reloadData()
        showMenu()
        refreshControl.endRefreshing()
        self.menuTable.reloadData()
        
    }
    
    func loadDataFromNetwork() {
        
        
        // Display HUD right before the request is made
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        
        
        
        showMenu()
        
        
        // Hide HUD once the network request comes back (must be done on main UI thread)
        MBProgressHUD.hideHUDForView(self.view, animated: true)
        
        // ... Remainder of response handling code ...
        
    }
    
    override func viewDidLoad() {
        self.menuTable.reloadData()
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        
        refreshControl.addTarget(self, action: "refreshControlAction:", forControlEvents: UIControlEvents.ValueChanged)
        //This line displays the spinning refresh
        menuTable.insertSubview(refreshControl, atIndex: 0)
        
        
        
        //  loadDataFromNetwork()
        menuTable.delegate = self
        menuTable.dataSource = self
        self.menuTable.reloadData()
        loadDataFromNetwork()
        
        
        self.menuTable.reloadData()
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func showMenu() {
        let query = PFQuery(className: "Post")
        query.orderByAscending("name")
        query.limit = 20
        query.findObjectsInBackgroundWithBlock { (posts: [PFObject]?, error: NSError?) -> Void in
            if let posts = posts {
                // do something with the array of object returned by the call
                self.posts = posts
                self.menuTable.reloadData()
            } else {
                print(error?.localizedDescription)
            }
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts?.count ?? 0
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("menuCell", forIndexPath: indexPath) as! MenuTableViewCell
        cell.menuPost = posts![indexPath.row]
        
        
        
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        return cell
    }
    
    
    @IBAction func onLogout(sender: AnyObject) {
        PFUser.logOut()
        NSNotificationCenter.defaultCenter().postNotificationName("userDidLogoutNotification", object: nil)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let cell=sender as! UITableViewCell
        let indexPath=menuTable.indexPathForCell(cell)
        let menuPost = posts![indexPath!.row]
        let nametext = menuPost["name"] as? String
        let svc = segue.destinationViewController as! OrderingViewController
        svc.name=nametext
        svc.price=menuPost["price"] as? String
        
        
        print("seg called")
//        if (segue.identifier == "takeOrder") {
//            var svc = segue.destinationViewController as! OrderingViewController;
        
            
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



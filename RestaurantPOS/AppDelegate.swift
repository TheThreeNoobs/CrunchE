//
//  AppDelegate.swift
//  RestaurantPOS
//
//  Created by Parth Bhardwaj on 4/5/16.
//  Copyright © 2016 TheThreeNoobs. All rights reserved.
//

import UIKit
import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        Parse.initializeWithConfiguration(
            ParseClientConfiguration(block: { (configuration:ParseMutableClientConfiguration) -> Void in
                configuration.applicationId = "crunche"
                configuration.clientKey = "aslkejfkljb342354kljblkjb"
                configuration.server = "https://crunchee.herokuapp.com/parse"
            })
        )
        
//        if PFUser.currentUser() != nil {
//            print("There is a current user")
//            
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let vc = storyboard.instantiateViewControllerWithIdentifier("ManagerFirst")
//            window?.rootViewController = vc
//            // if there is a logged in user then load the home view controller
//        }

        
        if let user = PFUser.currentUser() {
            if user.username=="manager"{
                let staffPage = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("manager")
                self.window?.rootViewController = staffPage
            }else if user.username=="staff"{
                //performSegueWithIdentifier("staff", sender: nil)
                let staffPage = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("staff")
                self.window?.rootViewController = staffPage
            }else if user.username=="chef"{
                let staffPage = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("chef")
                self.window?.rootViewController = staffPage
            }
        }
        
        
        
        NSNotificationCenter.defaultCenter().addObserverForName("userDidLogoutNotification", object: nil, queue: NSOperationQueue.mainQueue()) { (NSNotification) -> Void in
            print("User has logged out")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateInitialViewController()
            self.window?.rootViewController = vc
        }
        
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


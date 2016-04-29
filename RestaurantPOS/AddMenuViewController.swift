//
//  AddMenuViewController.swift
//  RestaurantPOS
//
//  Created by Shakeel Daswani on 4/12/16.
//  Copyright © 2016 TheThreeNoobs. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class AddMenuViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    let vc = UIImagePickerController()
    @IBOutlet weak var uploadImage: UIImageView!
    @IBOutlet weak var priceName: UITextField!
    
    @IBOutlet weak var menuDescription: UITextView!
    @IBOutlet weak var itemName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        menuDescription.layer.cornerRadius = 5
        menuDescription.layer.borderWidth = 1
        menuDescription.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).CGColor
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func postUserImage(image: UIImage?, withPrice price: String?, withCaption menuDescription: String?, withName name: String?,withCompletion completion: PFBooleanResultBlock?) {
        // Create Parse object PFObject
        let post = PFObject(className: "Post")
        
        // Add relevant fields to the object
        post["media"] = getPFFileFromImage(image) // PFFile column type
        post["author"] = PFUser.currentUser() // Pointer column type that points to PFUser
        post["price"] = price
        post["menuDescription"] = menuDescription
        post["name"] = name
//        post["likesCount"] = 0
//        post["commentsCount"] = 0
        
        // Save object (following function will save the object in Parse asynchronously)
        post.saveInBackgroundWithBlock(completion)
    }
    
    func getPFFileFromImage(image: UIImage?) -> PFFile? {
        // check if image is not nil
        if let image = image {
            // get image data and check if that is not nil
            if let imageData = UIImagePNGRepresentation(image) {
                return PFFile(name: "image.png", data: imageData)
            }
        }
        return nil
    }


    
    @IBAction func addToMenuButton(sender: AnyObject) {
       postUserImage(uploadImage.image, withPrice: self.priceName.text, withCaption: self.menuDescription.text, withName: self.itemName.text, withCompletion: nil)
      // self.performSegueWithIdentifier("successfullyPosted", sender: nil)
        
    
    }

    @IBAction func uploadImageButton(sender: AnyObject) {
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        self.presentViewController(vc, animated: true, completion: nil)

    }
    
    func imagePickerController(picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        uploadImage.image = editedImage
        
        
        
        
        
        dismissViewControllerAnimated(true, completion: nil)
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

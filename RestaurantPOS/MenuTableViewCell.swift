//
//  MenuTableViewCell.swift
//  RestaurantPOS
//
//  Created by Shakeel Daswani on 4/17/16.
//  Copyright © 2016 TheThreeNoobs. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class MenuTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var menuPic: PFImageView!
    @IBOutlet weak var menuName: UILabel!
    @IBOutlet weak var priceName: UILabel!
    @IBOutlet weak var menuDescription: UILabel!
  
    
    var menuPost: PFObject! {
        didSet {
            self.menuPic.file = menuPost["media"] as? PFFile
            self.menuName.text = menuPost["name"] as? String
            self.priceName.text = menuPost["price"] as? String
            self.menuDescription.text = menuPost["menuDescription"] as? String
            self.menuPic.loadInBackground()
        }
    }
    
//    var menuNameText = self.menuName.text
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

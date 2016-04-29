//
//  salesTableViewCell.swift
//  RestaurantPOS
//
//  Created by Parth Bhardwaj on 4/28/16.
//  Copyright © 2016 TheThreeNoobs. All rights reserved.
//

import UIKit

class salesTableViewCell: UITableViewCell {

    @IBOutlet weak var orderedTimes: UILabel!
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var dishName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

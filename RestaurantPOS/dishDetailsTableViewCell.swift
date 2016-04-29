//
//  dishDetailsTableViewCell.swift
//  
//
//  Created by Parth Bhardwaj on 4/28/16.
//
//

import UIKit

class dishDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var dishName: UILabel!
    @IBOutlet weak var dishQuant: UILabel!
    @IBOutlet weak var dishNotes: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

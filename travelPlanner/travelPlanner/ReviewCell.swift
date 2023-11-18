//
//  ReviewCell.swift
//  travelPlanner
//
//  Created by He, Wei Kang on 11/17/23.
//

import UIKit

class ReviewCell: UITableViewCell {
    
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var reviewLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

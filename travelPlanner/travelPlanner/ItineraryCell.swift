//
//  ItineraryCell.swift
//  travelPlanner
//
//  Created by He, Wei Kang on 11/12/23.
//

import UIKit

class ItineraryCell: UITableViewCell {
    
    
    
    @IBOutlet weak var locationImageView: UIImageView!
    
 
    @IBOutlet weak var placeLabel: UILabel!
    
    
    @IBOutlet weak var locationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

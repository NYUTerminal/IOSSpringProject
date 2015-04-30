//
//  AcceptedOffersCell.swift
//  RideShare
//
//  Created by Alex Mathew on 4/30/15.
//  Copyright (c) 2015 NYU. All rights reserved.
//

import UIKit

class AcceptedOffersCell: UITableViewCell {
    @IBOutlet weak var userCreatedLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var destinationLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var viaLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    
}

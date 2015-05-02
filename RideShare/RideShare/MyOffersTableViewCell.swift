//
//  MyOffersTableViewCell.swift
//  RideShare
//
//  Created by Alex Mathew on 4/29/15.
//  Copyright (c) 2015 NYU. All rights reserved.
//

import UIKit

class MyOffersTableViewCell: UITableViewCell {
    
    @IBOutlet weak var rideNameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var departureDateLabel: UILabel!
    
    
    @IBOutlet weak var priceLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    
}

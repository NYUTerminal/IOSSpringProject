//
//  SearchTableViewCell.swift
//  RideShare
//
//  Created by Alex Mathew on 4/24/15.
//  Copyright (c) 2015 NYU. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var noOfSeats: UILabel!
    @IBOutlet weak var sourceDest: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

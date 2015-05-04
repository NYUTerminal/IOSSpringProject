//
//  MessageTableViewCell.swift
//  RideShare
//
//  Created by praveen on 4/30/15.
//  Copyright (c) 2015 NYU. All rights reserved.
//

import Foundation

class MessageTableViewCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var message: UILabel!    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}

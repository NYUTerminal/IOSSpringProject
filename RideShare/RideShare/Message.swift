//
//  Message.swift
//  RideShare
//
//  Created by praveen on 4/30/15.
//  Copyright (c) 2015 NYU. All rights reserved.
//

import Foundation

class Message {
    
    var from:String
    var to:String
    var message:String
    var date:String
    var time:String
    var numberOfLikes:Int
    var offerId:String
    
    init(){
        from = ""
        to=""
        message=""
        date=""
        time=""
        numberOfLikes=0
        offerId=""
    }
    
}

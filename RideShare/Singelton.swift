//
//  Singelton.swift
//  RideShare
//
//  Created by praveen on 4/22/15.
//  Copyright (c) 2015 NYU. All rights reserved.
//

import Foundation


class Singelton {
    
    var loginUserName:String = ""
    var firstname:String = ""
    var lastname: String = ""
    var loginEmailId:String = ""
    var searchResults:[PFObject] = []
    var offerId:String = ""
    var offerUserId:String = ""
    var isFBLOgin:Bool =  false
    var fbUserObj:FBGraphUser!
    
    //Login with fixed user for now
    var loginUserId:String = "8s2KylF9oe"
    //SearchBasedParams
    var source:String = ""
    var destination:String = ""
    var date:String = ""
    var time:String = ""
    
    class var sharedInstance: Singelton {
        
        struct Static {
            static let instance: Singelton = Singelton()
        }
        return Static.instance
    }
    
}
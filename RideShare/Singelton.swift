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
    
    var loginEmailId:String = ""
    
    class var sharedInstance: Singelton {
        
        struct Static {
            static let instance: Singelton = Singelton()
        }
        return Static.instance
    }
    
}
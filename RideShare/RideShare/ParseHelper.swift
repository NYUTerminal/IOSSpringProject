//
//  ParseHelper.swift
//  RideShare
//
//  Created by praveen on 4/30/15.
//  Copyright (c) 2015 NYU. All rights reserved.
//

import Foundation

class ParseHelper{
    
    func getUserForId(user_id:String) -> User{
        var user = User()
        var query = PFQuery(className:"UserObject")
        query.whereKey("objectId", equalTo:user_id)
        query.getFirstObjectInBackgroundWithBlock {
            (object: PFObject?, error: NSError?) -> Void in
            if error != nil || object == nil {
                user.email=PFObject.valueForKey("email") as String!
                user.name=PFObject.valueForKey("name") as String!
                user.address=PFObject.valueForKey("address") as String!
            } else {
                // Log details of the failure
                println("Error: \(error!) \(error!.userInfo!)")
            }
        }
        return user
    }
    
    
    func getMessages(offer_id:String) -> [Message] {
        var query = PFQuery(className:"message")
        var messageList:[Message] = []
        query.whereKey("offerId", equalTo:offer_id)
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            if error == nil {
                if let objects = objects as? [PFObject] {
                    for object in objects {
                        var messageObject:Message = Message()
                        messageObject.date = object.valueForKey("from") as String!
                        messageObject.from = object.valueForKey("from") as String!
                        messageObject.to = object.valueForKey("from") as String!
                        messageObject.offerId = object.valueForKey("from") as String!
                        messageObject.numberOfLikes = object.valueForKey("from") as Int!
                        messageList.append(messageObject)
                    }
                }
                
            } else {
                // The find succeeded.
                println("Successfully retrieved the object.")
            }
        }
        return messageList
        
    }
    
    func saveMessage(messageObj : Message){
        
        var message = PFObject(className:"Message")
        message["from"] = messageObj.from
        message["to"] = messageObj.to
        message["date"] = messageObj.date
        message["time"] = messageObj.time
        message["offerId"] = messageObj.offerId
        message["likes"] = messageObj.numberOfLikes
        message.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                // The object has been saved.
            } else {
                // There was a problem, check error.description
            }
        }
    }
    
    
    
    
}
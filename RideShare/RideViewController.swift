//
//  RideViewController.swift
//  RideShare
//
//  Created by praveen on 4/26/15.
//  Copyright (c) 2015 NYU. All rights reserved.
//

import Foundation


class RideViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    var messageList:[Message] = []
    
    var offerId:String = "ggNVlS5tO9"
    
    var offerUserId:String = ""
    var offerCreatedUserId = "8s2KylF9oe"
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var source: UILabel!
    @IBOutlet weak var timeago: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var ampm: UILabel!
    @IBOutlet weak var money: UILabel!
    @IBOutlet weak var likes: UILabel!
    @IBOutlet weak var messages: UILabel!
    @IBOutlet weak var music: UIImageView!
    @IBOutlet weak var pizza: UIImageView!
    @IBOutlet weak var dog: UIImageView!
    @IBOutlet weak var chat: UIImageView!
    var music1 = true
    var pizza1 = true
    var dog1 = true
    var chat1:Bool = true
    var searchObj:PFObject!
    
    @IBOutlet weak var messageTable: UITableView!
    @IBOutlet weak var messageBox: UITextField!
    
    
    override func viewDidLoad() {
        fetchMessages()
        fetchSettingsOfOffer()
        //fetchOffer()
        //getNumberOfMessages()
    }
    
    func getNumberOfMessages(){
        var query = PFQuery(className:"Message")
        query.whereKey("offerId", equalTo:self.offerId)
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            if error == nil {
                if let objects = objects as? [PFObject] {
                    self.messages.text = "\(objects.count)"
                }
            }
        }
        
        var query2 = PFQuery(className:"Offer")
        query2.whereKey("objectId", equalTo:offerId)
        query2.getFirstObjectInBackgroundWithBlock {
            (object: PFObject?, error: NSError?) -> Void in
            if error == nil {
                let object = object as PFObject!
                var countLikes = object.valueForKey("likes") as Int!
                self.likes.text = "\(countLikes)"
            }
        }
    }
    
    
    func fetchOffer(){
        var query = PFQuery(className:"Offer")
        query.whereKey("objectId", equalTo:offerId)
        query.getFirstObjectInBackgroundWithBlock {
            (object: PFObject?, error: NSError?) -> Void in
            if error == nil {
                let object = object as PFObject!
                self.name.text = object.valueForKey("username") as String!
                self.source.text = object.valueForKey("source") as String!
                self.money.text = object.valueForKey("money") as String!
                println(object.valueForKey("description") as? String)
                //self.desc.text = object.valueForKey("description") as String!
                self.timeago.text = object.valueForKey("time") as String!
                self.time.text = object.valueForKey("time") as String!
            }
        }
    }
    
    func fetchSettingsOfOffer(){
        
        var query = PFQuery(className:"Settings")
        query.whereKey("userId", equalTo:offerCreatedUserId)
        query.getFirstObjectInBackgroundWithBlock {
            (object: PFObject?, error: NSError?) -> Void in
            if error == nil {
                let object = object as PFObject!
                self.chat1 = object.valueForKey("chat") as Bool!
                self.dog1 = object.valueForKey("dog") as Bool!
                self.music1 = object.valueForKey("music") as Bool!
                self.pizza1 = object.valueForKey("pizza") as Bool!
                
                if !self.music1 {
                    self.music.image = UIImage(named: "No-music.png") as UIImage?
                    self.music1 = false
                }else{
                    self.music.image = UIImage(named: "music.png") as UIImage?
                    self.music1 = true
                }
                if !self.chat1 {
                    self.chat.image = UIImage(named: "No-Chat.png") as UIImage?
                    self.chat1 = false
                }else{
                    self.chat.image = UIImage(named: "Chat.png") as UIImage?
                    self.chat1 = true
                }
                if !self.pizza1 {
                    self.pizza.image = UIImage(named: "No-Pizza.png") as UIImage?
                    self.pizza1 = false
                }else{
                    self.pizza.image = UIImage(named: "Pizza.png") as UIImage?
                    self.pizza1 = true
                }
                if !self.dog1 {
                    self.dog.image = UIImage(named: "No-Dog.png") as UIImage?
                    self.dog1 = false
                }else{
                    self.dog.image = UIImage(named: "Dog.png") as UIImage?
                    self.dog1 = true
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func getCurrentLocation(){
        
    }
    
    
    func fetchMessages(){
        var query = PFQuery(className:"Message")
        query.whereKey("offerId", equalTo:self.offerId)
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            if error == nil {
                if let objects = objects as? [PFObject] {
                    for object in objects {
                        var messageObject:Message = Message()
                        messageObject.date = object.valueForKey("date") as String!
                        messageObject.from = object.valueForKey("from") as String!
                        messageObject.to = object.valueForKey("to") as String!
                        messageObject.offerId = object.valueForKey("offerId") as String!
                        messageObject.numberOfLikes = object.valueForKey("likes") as Int!
                        messageObject.message = object.valueForKey("message") as String!
                        self.messageList.append(messageObject)
                        self.messageTable.reloadData()
                    }
                }
                
            } else {
                // The find succeeded.
                println("Successfully retrieved the object.")
            }
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageList.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("messagecell") as MessageTableViewCell
        //let cell = tableView.dequeueReusableCellWithIdentifier("PostCell" , forIndexPath: indexPath) as
        let result = self.messageList[indexPath.row]
        cell.message.text = result.message
        cell.name.text = result.from
        cell.time.text = result.date
        cell.likes.text = "\(result.numberOfLikes)"
        return cell
    }
    
    
    @IBAction func sendMessage(sender: UIButton) {
        var message = Message()
        message.from = "pLPqCLu0Ax"
        message.to = "8s2KylF9oe"
        message.message = self.messageBox.text
        message.date = "05-1-2015"
        message.numberOfLikes = 1
        message.offerId = "13arTCtsIy"
        message.time="8:15 pm"
        ParseHelper().saveMessage(message)
        self.messageBox.text = ""
        fetchMessages()
        self.messageTable.reloadData()
    }
    
    
    
}
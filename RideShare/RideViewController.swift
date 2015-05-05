//
//  RideViewController.swift
//  RideShare
//
//  Created by praveen on 4/26/15.
//  Copyright (c) 2015 NYU. All rights reserved.
//

import Foundation
import MapKit

class RideViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    var messageList:[Message] = []
    
    var offerId:String = ""
    var messageOfferId:String = "13arTCtsIy"
    var userId = ""
    var offerUserId:String = ""
    var offerCreatedUserId = ""
    
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
    var sourcetext = ""
    var destination = ""
    var via = ""
    var offerDescription = ""
    //var rideJoined = [String: Bool]()
    @IBOutlet weak var messageTable: UITableView!
    @IBOutlet weak var messageBox: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var addToFavButton: UIButton!
    @IBOutlet weak var joinRideButton: UIButton!
    var joinedRidePFObject:PFObject!
    var rideJoinedFlag = false
    
    
    
    override func viewDidLoad() {
        println("Ride View VIEW DID LOAD")
        self.userId =  Singelton.sharedInstance.loginUserId
        self.offerId = Singelton.sharedInstance.offerId
        self.offerUserId = Singelton.sharedInstance.offerUserId
        var tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)
        println(self.offerId)
        loadMapView()
        fetchMessages()
        fetchSettingsOfOffer()
        fetchOffer()
        getNumberOfMessages()
        checkRideJoinedOrNot()
    }
    
    func checkRideJoinedOrNot(){
        println("checkRideJoinedOrNot");
        var query = PFQuery(className:"AcceptedOffers")
        println(offerId)
        println(userId)
        query.whereKey("offerObjectId", equalTo:offerId)
        query.whereKey("userAccepted", equalTo:userId)
        query.getFirstObjectInBackgroundWithBlock {
            (object: PFObject?, error: NSError?) -> Void in
            if error == nil {
                println("Offer fetched to delete bro")
                self.rideJoinedFlag = true
                let object = object as PFObject!
                self.joinedRidePFObject = object
                self.joinRideButton.setBackgroundImage(UIImage(named: "DropRideBack"), forState: UIControlState.Normal)
                self.joinRideButton.setTitle("Drop Ride!" , forState: UIControlState.Normal)
            }
        }
    }
    
    func DismissKeyboard(){
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func loadMapView(){
        
        super.viewDidLoad()
        // 1
        let location = CLLocationCoordinate2D(
            latitude:  40.729698,
            longitude: -73.99719
        )
        // 2
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        
        //3
        let annotation = MKPointAnnotation()
        annotation.setCoordinate(location)
        annotation.title = "Source"
        annotation.subtitle = "RideShare"
        mapView.addAnnotation(annotation)
        
        // 1
        let location2 = CLLocationCoordinate2D(
            latitude: 40.693611,
            longitude: -73.986162
        )
        // 2
        let span2 = MKCoordinateSpanMake(0.05, 0.05)
        let region2 = MKCoordinateRegion(center: location2, span: span2)
        mapView.setRegion(region2, animated: true)
        
        //3
        let annotation2 = MKPointAnnotation()
        annotation2.setCoordinate(location2)
        annotation2.title = "Destination"
        annotation2.subtitle = "RideShare"
        mapView.addAnnotation(annotation2)
    }
    
    func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer! {
        if (overlay is MKPolyline) {
            var pr = MKPolylineRenderer(overlay: overlay);
            pr.strokeColor = UIColor.blueColor().colorWithAlphaComponent(0.5);
            pr.lineWidth = 5;
            return pr;
        }
        
        return nil
    }
    
    
    func getNumberOfMessages(){
         println("number of messages1");
        var query = PFQuery(className:"Message")
        query.whereKey("offerId", equalTo:self.offerId)
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            if error == nil {
                //println("Number of messages fetched")
                if let objects = objects as? [PFObject] {
                    self.messages.text = "\(objects.count)"
                }
            }
        }
        println("number of messages2");
        var query2 = PFQuery(className:"Offer")
        query2.whereKey("objectId", equalTo:offerId)
        query2.getFirstObjectInBackgroundWithBlock {
            (object: PFObject?, error: NSError?) -> Void in
            if error == nil {
                //println("Offer fetched")
                let object = object as PFObject!
                var countLikes = object.valueForKey("likes") as Int!
                self.likes.text = "\(countLikes)"
            }
        }
    }
    
    
    func fetchOffer(){
        println("fetching offer123");
        var query = PFQuery(className:"Offer")
        query.whereKey("objectId", equalTo:offerId)
        query.getFirstObjectInBackgroundWithBlock {
            (object: PFObject?, error: NSError?) -> Void in
            if error == nil {
                //println("Offer fetched")
                let object = object as PFObject!
                self.name.text = object.valueForKey("username") as String!
                let source:String = object.objectForKey("source") as String!
                self.destination = object.objectForKey("destination") as String!
                self.sourcetext  = object.objectForKey("source") as String!
                self.via = object.objectForKey("via") as String!
                self.offerDescription = "Happy Journey!!"
                self.source.text = source + " to " + self.destination
                self.money.text = object.valueForKey("money") as String!
                //self.desc.text = object.valueForKey("description") as String!
                self.timeago.text = object.valueForKey("time") as String!
                self.time.text = object.valueForKey("time") as String!
            }
        }
    }
    
    func fetchSettingsOfOffer(){
        println("fetching Settings123");
        var query = PFQuery(className:"Settings")
        query.whereKey("userId", equalTo:offerUserId)
        query.getFirstObjectInBackgroundWithBlock {
            (object: PFObject?, error: NSError?) -> Void in
            if error == nil {
                //println("Settings fetched")
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
        println("fetching Messages123");
        var query = PFQuery(className:"Message")
        query.whereKey("offerId", equalTo:self.offerId)
        //query.whereKey("to", equalTo:self.userId)
        query.orderByDescending("createdAt")
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            if error == nil {
                if let objects = objects as? [PFObject] {
                    for object in objects {
                        //println("messages retrieved")
                        if( object.valueForKey("from") as String! == self.userId ||  object.valueForKey("to") as String! == self.offerUserId){
                        var messageObject:Message = Message()
                        messageObject.date = object.valueForKey("date") as String!
                        messageObject.from = object.valueForKey("from") as String!
                        messageObject.to = object.valueForKey("to") as String!
                        messageObject.offerId = object.valueForKey("offerId") as String!
                        messageObject.message = object.valueForKey("message") as String!
                        self.messageList.append(messageObject)
                        self.messageTable.reloadData()
                        }
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
        return cell
    }
    
    
    @IBAction func sendMessage(sender: UIButton) {
        var message = Message()
        message.from = Singelton.sharedInstance.loginUserId
        message.to = offerUserId
        message.message = self.messageBox.text
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy:hh:mm:a"
        var tempDate = NSDate()
        let strDate = dateFormatter.stringFromDate(tempDate)
        message.date = strDate
        message.offerId = "13arTCtsIy"
        message.time="8:15 pm"
        ParseHelper().saveMessage(message)
        self.messageBox.text = ""
        messageList = []
        fetchMessages()
        self.messageTable.reloadData()
    }
    
    @IBAction func joinRide(sender: UIButton) {
        var acceptedOffers = PFObject(className:"AcceptedOffers")
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy:hh:mm:a"
        var tempDate = NSDate()
        let strDate = dateFormatter.stringFromDate(tempDate)
        acceptedOffers["time"] = strDate
        acceptedOffers["source"] = sourcetext
        acceptedOffers["destination"] = self.destination
        acceptedOffers["via"] = self.via
        acceptedOffers["description"] = self.offerDescription
        if(joinedRidePFObject == nil || !rideJoinedFlag){
            acceptedOffers["offerObjectId"] = offerId
            acceptedOffers["userAccepted"] = userId
            acceptedOffers["userCreated"] = offerUserId
            acceptedOffers.saveInBackgroundWithBlock {
                (success: Bool, error: NSError?) -> Void in
                if (success) {
                    let alertController = UIAlertController(title: "Join Ride!", message:
                        "Hurrey Successfully Joined Ride!", preferredStyle: UIAlertControllerStyle.Alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
                    self.presentViewController(alertController, animated: true, completion: nil)
                    self.joinRideButton.setBackgroundImage(UIImage(named: "DropRideBack"), forState: UIControlState.Normal)
                    self.joinRideButton.setTitle("Drop Ride!" , forState: UIControlState.Normal)
                    self.checkRideJoinedOrNot()
                    self.rideJoinedFlag = true
                } else {
                    // There was a problem, check error.description
                }
            }
        }else{
            rideJoinedFlag = false
            self.joinRideButton.setBackgroundImage(UIImage(named: "AcceptRideBack"), forState: UIControlState.Normal)
            self.joinRideButton.setTitle("Join Ride" , forState: UIControlState.Normal)
            //Ideally delete object
            acceptedOffers.deleteInBackgroundWithTarget(self.joinedRidePFObject, selector: nil)
        }
    }
    
    
    @IBAction func addToFav(sender: UIButton) {
        
        
        
    }
    
}
//
//  ProfileViewController.swift
//  RideShare
//
//  Created by praveen on 4/20/15.
//  Copyright (c) 2015 NYU. All rights reserved.
//

import Foundation


class ProfileViewController : UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var assa: UITextField!
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var pass1: UITextField!
    
    @IBOutlet weak var pass2: UITextField!
    
    @IBOutlet weak var status: UILabel!
    
    @IBOutlet weak var favRides: UIButton!
    
    @IBOutlet weak var acceptedRides: UIButton!
    
    @IBOutlet weak var myRides: UIButton!
    
    var userName:String!
    
    var userId:String!
    
    
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var aceptedLabel: UILabel!
    
    @IBOutlet weak var favLabel: UILabel!
    
    @IBOutlet weak var myRidesLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var phoneLabel: UILabel!
    
    @IBOutlet weak var countryLabel: UILabel!
    
    @IBOutlet weak var stateLabel: UILabel!
    
    @IBOutlet weak var profilePic: UIImageView!
    
    @IBOutlet weak var messageLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        userId = Singelton.sharedInstance.loginUserId
        userName = Singelton.sharedInstance.loginUserName
        var tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)
        loadStatistics()
        self.profilePic.layer.cornerRadius = self.profilePic.frame.size.width / 1.75;
        self.profilePic.clipsToBounds = true;

        self.profilePic.layer.borderWidth = 3.0;
        self.profilePic.layer.borderColor = UIColor.grayColor().CGColor
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func DismissKeyboard(){
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func createProfile(){
        
        validateFields();
        
        var user = PFUser()
        user.username = username.text
        user.password = "myPassword"
        user.email = email.text
        // other fields can be set just like with PFObject
        user["phone"] = "415-392-0202"
        
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool!, error: NSError!) -> Void in
            if error == nil {
                // Hooray! Let them use the app now.
            } else {
                //let errorString = error.userInfo["error"] as NSString
                // Show the errorString somewhere and let the user try again.
            }
        }
        
    }
    
    func login(){
        
        PFUser.logInWithUsernameInBackground("myname", password:"mypass") {
            (user: PFUser!, error: NSError!) -> Void in
            if user != nil {
                Singelton.sharedInstance.loginEmailId = user.email
                Singelton.sharedInstance.loginUserName = user.username
                // Do stuff after successful login.
            } else {
                //status.text = "Please verify your email and password"
            }
        }
    }
    
    func validateFields(){
        
        
        
    }
    
    func loadStatistics(){
        
        getFavRides()
        getAcceptedRides()
        getMyRides()
        getMessageCount()
        profilePic.image = Singelton.sharedInstance.profilePic
        
        //sharedData.loginUserName = user.name as String
        nameLabel.text = Singelton.sharedInstance.loginUserName
        
        
        emailLabel.text = Singelton.sharedInstance.loginUserId
        
        
        
                var query = PFQuery(className:"Settings")
              query.whereKey("userId", equalTo: Singelton.sharedInstance.loginUserId)
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                var object:PFObject!
                for(var i=0;i<objects.count;i++)
                {
                     object=objects[i] as PFObject;
            }
                
                
                self.addressLabel.text = object.objectForKey("address") as String!
                
                self.cityLabel.text = object.objectForKey("city") as String!
                
                self.countryLabel.text = object.objectForKey("country") as String!
                
                self.stateLabel.text = object.objectForKey("state") as String!
                
                self.phoneLabel.text = object.objectForKey("mobile") as String!
            }
            else {
                // Log details of the failure
                println("Error: \(error) \(error.userInfo!)")
            }
        }
       
        
        //stateLabel.t
        
        
    }
    
    
    func getFavRides(){
        var query = PFQuery(className:"AcceptedOffers")
        query.whereKey("userAccepted", equalTo:userId)
        query.countObjectsInBackgroundWithBlock {
            (count: Int32, error: NSError?) -> Void in
            if error == nil {
                println("\(count)")
                self.aceptedLabel.text = "\(count)"
            }
        }
    }
    
    
    func getAcceptedRides(){
        var query = PFQuery(className:"AcceptedOffers")
        query.whereKey("userAccepted", equalTo:userId)
        query.countObjectsInBackgroundWithBlock {
            (count: Int32, error: NSError?) -> Void in
            if error == nil {
                println("\(count)")
                self.aceptedLabel.text = "\(count)"
            }
        }
    }
    
    func getMessageCount(){
        var query = PFQuery(className:"Message")
        query.whereKey("to", equalTo:userId)
        query.countObjectsInBackgroundWithBlock {
            (count: Int32, error: NSError?) -> Void in
            if error == nil {
                println("\(count)")
                self.messageLabel.text = "\(count)"
            }
        }
    }
    
    
    
    func getMyRides(){
        var query = PFQuery(className:"Offer")
        query.whereKey("userId", equalTo:userId)
        query.countObjectsInBackgroundWithBlock {
            (count: Int32, error: NSError?) -> Void in
            if error == nil {
                println("\(count)")
                self.myRidesLabel.text = "\(count)"
            }
        }
    }
    
    func fbRequestCompletionHandler(connection:FBRequestConnection!, result:AnyObject!, error:NSError!){
        if let gotError = error{
            
        }else{
            let userFBID:AnyObject = result.valueForKey("id")!
            let userImageURL = "https://graph.facebook.com/\(userFBID)/picture?type=small"
            
            let url = NSURL(string:userImageURL)!
            
            let imageData = NSData(contentsOfURL: url)
            
            let image = UIImage(data: imageData!)
            
            profilePic.image = image
            
            
        }
    }
    
    
    @IBAction func getMessage(sender: UIButton) {
        getMessageCount()
    }
    
    @IBAction func getFavRides(sender: UIButton) {
        getFavRides()
    }
    
}
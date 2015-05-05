
//
//  signUpViewController.swift
//  RideShare
//
//  Created by Kushal Jogi on 4/30/15.
//  Copyright (c) 2015 NYU. All rights reserved.
//


import UIKit


class signUpViewController: UIViewController, FBLoginViewDelegate {
    
    
    @IBOutlet weak var fbLoginView: FBLoginView!
    var sharedData:Singelton = Singelton.sharedInstance
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view, typically from a nib.
        self.fbLoginView.delegate = self
        self.fbLoginView.readPermissions = ["public_profile","email","user_friends"]
        
    }
    
    func DismissKeyboard(){
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func fbRequestCompletionHandler(connection:FBRequestConnection!, result:AnyObject!, error:NSError!){
        if let gotError = error{
            
        }else{
            let userFBID:AnyObject = result.valueForKey("id")!
            let userImageURL = "https://graph.facebook.com/\(userFBID)/picture?type=small"
            
            let url = NSURL(string:userImageURL)!
            
            let imageData = NSData(contentsOfURL: url)
            
            let image = UIImage(data: imageData!)
            
            sharedData.profilePic = image
            
        }
    }

    
    func loginViewShowingLoggedInUser(loginView: FBLoginView!) {
        println("User Logged In")
        println("Perform Segue")
        self.performSegueWithIdentifier("userLoggedInSegue", sender: self)
        
    }
    
    func loginViewFetchedUserInfo(loginView: FBLoginView!, user: FBGraphUser!) {
        println("User Name: \(user.name)")
        println("User Name: \(user.first_name)")
        println("User Name: \(user.last_name)")
        sharedData.loginUserName = user.name as String
        sharedData.firstname = user.first_name as String
        sharedData.lastname = user.last_name as String
        sharedData.fbUserObj = user
        sharedData.loginUserId = user.objectForKey("email") as String
        let userFBID:AnyObject = user.objectForKey("id")!
        let userImageURL = "https://graph.facebook.com/\(userFBID)/picture?type=small"
        
        let url = NSURL(string:userImageURL)!
        
        let imageData = NSData(contentsOfURL: url)
        
        let image = UIImage(data: imageData!)
        
        sharedData.profilePic = image
        println(sharedData.loginUserId)
        sharedData.loginEmailId = user.objectForKey("email") as String
        sharedData.isFBLOgin = true
        FBRequestConnection.startForMeWithCompletionHandler { (connection, user, error) -> Void in
            if (error == nil){
                //self.performSegueWithIdentifier("userLoggedInSegue", sender: self)
                println("Email: \(self.sharedData.loginEmailId)")
            }
        }
        
    }
    

    
    func loginViewShowingLoggedOutUser(loginView: FBLoginView!) {
        println("User Logged out")
    }
    
    func loginView(loginView: FBLoginView!, handleError error: NSError!) {
        println("Error")
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
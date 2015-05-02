
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
        // Do any additional setup after loading the view, typically from a nib.
        self.fbLoginView.delegate = self
        self.fbLoginView.readPermissions = ["public_profile","email","user_friends"]
        
    }
    
    func loginViewShowingLoggedInUser(loginView: FBLoginView!) {
        println("User Logged In")
        println("Perform Segue")
        
        
    }
    
    func loginViewFetchedUserInfo(loginView: FBLoginView!, user: FBGraphUser!) {
        println("User Name: \(user.name)")
        sharedData.loginUserName = user.name
        sharedData.firstname = user.first_name
        sharedData.lastname = user.last_name
        FBRequestConnection.startForMeWithCompletionHandler { (connection, user, error) -> Void in
            if (error == nil){
                self.sharedData.loginEmailId = user.objectForKey("email") as String
                self.performSegueWithIdentifier("showView", sender: self)
            }
        }
        
    }
    

    
    func loginViewShowingLoggedOutUser(loginView: FBLoginView!) {
        println("User Logged out")
    }
    
    func loginView(loginView: FBLoginView!, handleError error: NSError!) {
        println("Error")
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "showView"){
            var vc: SecondViewController = segue.destinationViewController as SecondViewController
            vc.firstName = sharedData.firstname
            vc.lastName = sharedData.lastname
            vc.email = sharedData.loginEmailId
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
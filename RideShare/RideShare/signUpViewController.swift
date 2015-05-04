
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
        self.performSegueWithIdentifier("userLoggedInSegue", sender: self)
        
    }
    
    func loginViewFetchedUserInfo(loginView: FBLoginView!, user: FBGraphUser!) {
        println("User Name: \(user.name)")
        println("User Name: \(user.first_name)")
        println("User Name: \(user.last_name)")
        sharedData.loginUserName = user.name as String
        sharedData.firstname = user.first_name as String
        sharedData.lastname = user.last_name as String
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
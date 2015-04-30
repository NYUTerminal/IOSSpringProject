
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
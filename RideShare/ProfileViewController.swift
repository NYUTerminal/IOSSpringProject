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
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var pass1: UITextField!

    @IBOutlet weak var pass2: UITextField!
    
    @IBOutlet weak var status: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
    
    
}
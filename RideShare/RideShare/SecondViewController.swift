//
//  SecondViewController.swift
//  RideShare
//
//  Created by Kushal Jogi on 5/1/15.
//  Copyright (c) 2015 NYU. All rights reserved.
//

import Foundation
import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    var userName: String!
    var firstName: String!
    var lastName: String!
    var email: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //time.delegate=self
        if (self.userName != nil) {
            self.userNameLabel.text = self.firstName
        }
        
        if (self.firstName != nil) {
            self.firstNameLabel.text = self.firstName
        }
        
        if (self.lastName != nil) {
            self.lastNameLabel.text = self.lastName
        }
        
        if (self.email != nil) {
            self.emailLabel.text = self.email
        }
    }
    
    func DismissKeyboard(){
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
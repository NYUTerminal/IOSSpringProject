//
//  SettingsViewController.swift
//  RideShare
//
//  Created by praveen on 4/20/15.
//  Copyright (c) 2015 NYU. All rights reserved.
//

import Foundation

class SettingsViewController: ViewController {
    
    @IBOutlet weak var address: UITextField!
    
    @IBOutlet weak var city: UITextField!
    
    @IBOutlet weak var state: UITextField!
    
    @IBOutlet weak var country: UITextField!
    
    @IBOutlet weak var mobile: UITextField!
    
    @IBOutlet weak var onlyFriends: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveSettings(sender: AnyObject) {
        
        if(validateSettings()){
            
            var settingsClass = PFObject(className:"Settings")
            settingsClass["address"] = address.text
            settingsClass["city"] = city.text
            settingsClass["state"] = state.text
            settingsClass["country"] = country.text
            settingsClass["mobile"] = mobile.text
            if onlyFriends.on {
                settingsClass["onlyFriends"] = true
                }
            else{
                settingsClass["onlyFriends"] = false
                }
            settingsClass["username"] = Singelton.sharedInstance.loginUserName
            settingsClass.saveInBackgroundWithBlock {
                (success: Bool, error: NSError?) -> Void in
                if (success) {
                    // The object has been saved.
                    } else {
                    
                    // There was a problem, check error.description
                    }
                }
            }else{
              return
            }
        
    }
    
    func validateSettings() -> Bool {
        return true;
    }
    
    
}

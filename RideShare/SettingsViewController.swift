//
//  SettingsViewController.swift
//  RideShare
//
//  Created by praveen on 4/20/15.
//  Copyright (c) 2015 NYU. All rights reserved.
//

import Foundation
import UIKit

class SettingsViewController: ViewController, UIAlertViewDelegate {
    
    @IBOutlet weak var address: UITextField!
    
    @IBOutlet weak var city: UITextField!
    
    @IBOutlet weak var state: UITextField!
    
    @IBOutlet weak var country: UITextField!
    
    @IBOutlet weak var mobile: UITextField!
    
    @IBOutlet weak var onlyFriends: UISwitch!
    
    var music:Bool = true
    
    var dog:Bool = true
    
    var pizza:Bool = true
    
    var chat:Bool = true
    
    @IBOutlet weak var musicOutLet: UIButton!
    
    @IBOutlet weak var dogOutLet: UIButton!
    
    @IBOutlet weak var pizzaOutLet: UIButton!
    
    @IBOutlet weak var chatOutLet: UIButton!
    
    var isSettingsFetched = false
    
    var loginId = Singelton.sharedInstance.loginUserId
    
    var loginUser = Singelton.sharedInstance.loginUserName
    
    var settingsId:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchSettings()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func fetchSettings(){
        if !loginId.isEmpty {
            var query = PFQuery(className:"Settings")
            query.whereKey("userId", equalTo:loginId)
            query.getFirstObjectInBackgroundWithBlock {
                (object: PFObject?, error: NSError?) -> Void in
                if error == nil {
                    let object = object as PFObject!
                    self.address.text = object.valueForKey("address") as String!
                    self.city.text = object.valueForKey("city") as String!
                    self.state.text = object.valueForKey("state") as String!
                    self.country.text =  object.valueForKey("country") as String!
                    self.mobile.text = object.valueForKey("mobile") as String!
                    self.isSettingsFetched = true
                    self.settingsId = object.valueForKey("objectId") as String!
                    self.chat = object.valueForKey("chat") as Bool!
                    self.dog = object.valueForKey("dog") as Bool!
                    self.music = object.valueForKey("music") as Bool!
                    self.pizza = object.valueForKey("pizza") as Bool!
                    if(object.valueForKey("address") as String! == "1") {
                        
                    }
                    if !self.music {
                        let image = UIImage(named: "No-music.png") as UIImage?
                        self.musicOutLet.setImage(image, forState: .Normal)
                        self.music = false
                    }
                    if !self.chat {
                        let image = UIImage(named: "No-Chat.png") as UIImage?
                        self.chatOutLet.setImage(image, forState: .Normal)
                        self.chat = false
                    }
                    if !self.pizza {
                        let image = UIImage(named: "No-Pizza.png") as UIImage?
                        self.pizzaOutLet.setImage(image, forState: .Normal)
                        self.pizza = false
                    }
                    if !self.dog {
                        let image = UIImage(named: "No-Dog.png") as UIImage?
                        self.dogOutLet.setImage(image, forState: .Normal)
                        self.dog = false
                    }
                } else {
                    // Log details of the failure
                    //println("Error: \(error!) \(error!.userInfo?)")
                }
            }
        }
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveSettings(sender: AnyObject) {
        
        if(validateSettings() && !isSettingsFetched){
            
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
            settingsClass["username"] = self.loginUser
            settingsClass["userId"] = self.loginId
            settingsClass["pizza"] = self.pizza
            settingsClass["dog"] = self.dog
            settingsClass["music"] = self.music
            settingsClass["chat"] = self.chat
            settingsClass.saveInBackgroundWithBlock {
                (success: Bool, error: NSError?) -> Void in
                if (success) {
                    let alertController = UIAlertController(title: "Offer Status", message:
                        "Settings Saved Successfully!", preferredStyle: UIAlertControllerStyle.Alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
                    self.presentViewController(alertController, animated: true, completion: nil)

                } else {
                    
                    // There was a problem, check error.description
                }
            }
        }else if isSettingsFetched {
            var settingsClass = PFQuery(className:"Settings")
            settingsClass.getObjectInBackgroundWithId(self.settingsId) {
                (settingObj: PFObject?, error: NSError?) -> Void in
                if error != nil {
                    println(error)
                } else if let settingObj = settingObj {
                    settingObj["address"] = self.address.text
                    settingObj["city"] = self.city.text
                    settingObj["state"] = self.state.text
                    settingObj["country"] = self.country.text
                    settingObj["mobile"] = self.mobile.text
                    settingObj["username"] = self.loginUser
                    settingObj["userId"] = self.loginId
                    settingObj["pizza"] = self.pizza
                    settingObj["dog"] = self.dog
                    settingObj["music"] = self.music
                    settingObj["chat"] = self.chat
                    settingObj.saveInBackgroundWithTarget(nil, selector: nil)
                    let alertController = UIAlertController(title: "Setting Status", message:
                        "Settings Successfully Updated!", preferredStyle: UIAlertControllerStyle.Alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
                    self.presentViewController(alertController, animated: true, completion: nil)

                }
            }
        }
        else{
            return
        }
        
    }
    
    func validateSettings() -> Bool {
        return true;
    }
    
    @IBAction func chatAlter(sender: UIButton) {
        chatAlterUtil()
    }
    
    func chatAlterUtil(){
        if self.chat {
            let image = UIImage(named: "No-Chat.png") as UIImage?
            chatOutLet.setImage(image, forState: .Normal)
            self.chat = false
        }else{
            let image = UIImage(named: "Chat.png") as UIImage?
            chatOutLet.setImage(image, forState: .Normal)
            self.chat = true
        }
    }
    
    @IBAction func pizzaAlter(sender: UIButton) {
        pizzaAlterUtil()
    }
    
    func pizzaAlterUtil(){
        if self.pizza {
            let image = UIImage(named: "No-Pizza.png") as UIImage?
            pizzaOutLet.setImage(image, forState: .Normal)
            self.pizza = false
        }else{
            let image = UIImage(named: "Pizza.png") as UIImage?
            pizzaOutLet.setImage(image, forState: .Normal)
            self.pizza = true
        }
    }
    
    @IBAction func petAlter(sender: UIButton) {
        petAlterUtil()
    }
    
    func petAlterUtil(){
        if self.dog {
            let image = UIImage(named: "No-Dog.png") as UIImage?
            dogOutLet.setImage(image, forState: .Normal)
            self.dog = false
        }else{
            let image = UIImage(named: "Dog.png") as UIImage?
            dogOutLet.setImage(image, forState: .Normal)
            self.dog = true
        }
    }
    
    
    @IBAction func musicAlter(sender: UIButton) {
        musicAlterUtil()
    }
    
    func musicAlterUtil(){
        if self.music {
            let image = UIImage(named: "No-music.png") as UIImage?
            musicOutLet.setImage(image, forState: .Normal)
            self.music = false
        }else{
            let image = UIImage(named: "music.png") as UIImage?
            musicOutLet.setImage(image, forState: .Normal)
            self.music = true
        }
    }
    
    
    
}

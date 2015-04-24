//
//  OfferViewController.swift
//  RideShare
//
//  Created by praveen on 4/20/15.
//  Copyright (c) 2015 NYU. All rights reserved.
//

import Foundation


class OfferViewController: ViewController, GMSMapViewDelegate {
    
    @IBOutlet weak var rideName: UITextField!
    
    @IBOutlet weak var source: UITextField!
    
    @IBOutlet weak var destination: UITextField!
    
    @IBOutlet weak var via: UITextField!
    
    @IBOutlet weak var date: UITextField!
    
    @IBOutlet weak var time: UITextField!
    
    @IBOutlet weak var carNumber: UITextField!
    
    @IBOutlet weak var carType: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createOffer(sender: AnyObject) {
        if(validateOfferDetails()){
            var offerClass = PFObject(className:"Offer")
            offerClass["rideName"] = rideName.text
            offerClass["source"] = source.text
            offerClass["destination"] = destination.text
            offerClass["via"] = via.text
            offerClass["departureDate"] = date.text
            offerClass["time"] = time.text
            offerClass["carNumber"] = carNumber.text
            offerClass["carType"] = carType.text
            offerClass["username"] = Singelton.sharedInstance.loginUserName
            offerClass.saveInBackgroundWithBlock {
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
    
    func validateOfferDetails() -> Bool {
        return true;
    }
    
    
}

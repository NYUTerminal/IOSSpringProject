//
//  OfferViewController.swift
//  RideShare
//
//  Created by praveen on 4/20/15.
//  Copyright (c) 2015 NYU. All rights reserved.
//

import Foundation


class OfferViewController: UIViewController, GMSMapViewDelegate , UITextFieldDelegate {
    
    @IBOutlet weak var rideName: UITextField!
    
    @IBOutlet weak var source: UITextField!
    
    @IBOutlet weak var destination: UITextField!
    
    @IBOutlet weak var via: UITextField!
    
    @IBOutlet weak var date: UITextField!
    
    @IBOutlet weak var time: UITextField!
    
    @IBOutlet weak var carNumber: UITextField!
    
    @IBOutlet weak var carType: UITextField!
    
    @IBOutlet weak var money: UITextField!
    
    @IBOutlet weak var noOfSeats: UITextField!
    
    var userName = ""
    
    var userId = ""
    
    override func viewDidLoad() {
//        super.viewDidLoad()
//        //date.text =
//        var formatter = NSDateFormatter()
//        formatter.dateFormat = "mm-dd-yyyy"
//        
//        var currentDate =    self.datePicker.date
//        date.text = formatter.stringFromDate(currentDate)
        // Do any additional setup after loading the view, typically from a nib.
        //getCurrrentDate()
        userName = Singelton.sharedInstance.loginUserName
        userId = Singelton.sharedInstance.loginUserId
        var tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)
        time.delegate=self
    }
    
    func DismissKeyboard(){
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool // called when 'return' key pressed. return NO to ignore.
    {
        textField.resignFirstResponder()
        return true;
    }

    func getDatePicker(){
        date.resignFirstResponder()
        DatePickerDialog().show(title: "DatePicker", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", datePickerMode: .Date) {
            (tempDate) -> Void in
            var dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "MM-dd-yyyy"
            let strDate = dateFormatter.stringFromDate(tempDate)
            self.date.text = "\(strDate)"
        }
    }
    
    func getTimePicker(){
        time.resignFirstResponder()
        DatePickerDialog().show(title: "DatePicker", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", datePickerMode: .Time) {
            (time) -> Void in
            var dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            self.time.text = dateFormatter.stringFromDate(time)
        }
    }
    
    @IBAction func getDate(sender: UITextField) {
        getDatePicker()
    }


    @IBAction func getTime(sender: UITextField) {
        getTimePicker()
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
            offerClass["money"] = money.text
            offerClass["username"] = userName
            offerClass["description"] = rideName.text
            offerClass["noOfSeats"] = noOfSeats.text
            offerClass["userId"] = userId
            offerClass["likes"] = 0
            offerClass.saveInBackgroundWithBlock {
                (success: Bool, error: NSError?) -> Void in
                if (success) {
                    let alertController = UIAlertController(title: "Offer Status", message:
                        "New offer has been created!", preferredStyle: UIAlertControllerStyle.Alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
                    self.presentViewController(alertController, animated: true, completion: nil)
                    
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

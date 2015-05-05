//
//  ViewController.swift
//  RideShare
//
//  Created by praveen on 2/17/15.
//  Copyright (c) 2015 NYU. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITextFieldDelegate {
    
    
    @IBOutlet weak var source: UITextField!

    @IBOutlet weak var destination: UITextField!
    
    @IBOutlet weak var date: UITextField!
    
    @IBOutlet weak var time: UITextField!
    
    @IBOutlet weak var myPicker: UIPickerView!
    
    var dateNS:NSDate!
    
    override func viewDidLoad() {
        var tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //time.delegate=self
    }
    
    func DismissKeyboard(){
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool // called when 'return' key pressed. return NO to ignore.
    {
        textField.resignFirstResponder()
        return true;
    }
    
    
    func getDatePicker(){
        date.resignFirstResponder()
        DatePickerDialog().show(title: "Pick Date", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", datePickerMode: .Date) {
            (tempDate) -> Void in
            var dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "MM-dd-yyyy"
            let strDate = dateFormatter.stringFromDate(tempDate)
            self.date.text = "\(strDate)"
        }
        
    }
    
    func getTimePicker(){
        time.resignFirstResponder()
        DatePickerDialog().show(title: "Pick Time", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", datePickerMode: .Time) {
            (time) -> Void in
            var dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "hh:mm:a"
            self.time.text = dateFormatter.stringFromDate(time)
            //self.time.text = "\(time)"
        }
    }
    
    @IBAction func getDate(sender: UITextField) {
        getDatePicker()
    }
    
    
    @IBAction func getTime(sender: UITextField) {
        getTimePicker()
    }
    
    func getCurrentLocation(){
        
    }
    

}


//
//  MyOffersViewController.swift
//  RideShare
//
//  Created by Alex Mathew on 4/29/15.
//  Copyright (c) 2015 NYU. All rights reserved.
//

import UIKit

class MyOffersViewController: UIViewController, UITableViewDelegate , UITableViewDataSource {
    
    
    var myOffers:[PFObject] = []
    
    @IBOutlet weak var myOffersTableView: UITableView!
    
    func loadData() {
        myOffers = []
        
        var findmyOffers = PFQuery(className: "Offer")
        findmyOffers.whereKey("username", equalTo:"Tom")
        findmyOffers.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                // The find succeeded.
                println("Successfully retrieved \(objects.count) scores.")
                // Do something with the found objects
                if let objects = objects as? [PFObject] {
                    for object in objects {
                        self.myOffers.append(object as PFObject)
                    }
                    self.myOffersTableView.reloadData()
                }
            } else {
                // Log details of the failure
                println("Error: \(error) \(error.userInfo!)")
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.myOffers.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       var cell = tableView.dequeueReusableCellWithIdentifier("myOffersCell") as MyOffersTableViewCell
        
        if self.myOffers.count > 0 {
            println(indexPath.row)
            let result:PFObject = self.myOffers[indexPath.row]
            cell.timeLabel.text = result.objectForKey("time") as? String
            cell.sourceLabel.text = result.objectForKey("source") as? String
            cell.destinationLabel.text = result.objectForKey("destination") as? String
            cell.descriptionLabel.text = result.objectForKey("description") as? String
        }
        return cell
    }
    
}

//
//  AcceptedOffersViewController.swift
//  RideShare
//
//  Created by Alex Mathew on 4/30/15.
//  Copyright (c) 2015 NYU. All rights reserved.
//

import UIKit

class AcceptedOffersViewController: UIViewController, UITableViewDelegate , UITableViewDataSource {
    
    
    var acceptedOffers:[PFObject] = []
    
    @IBOutlet weak var acceptedOffersTableView: UITableView!
    
    func loadData() {
        acceptedOffers = []
        var findacceptedOffers = PFQuery(className: "AcceptedOffers")
        findacceptedOffers.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                // The find succeeded.
                println("Successfully retrieved \(objects.count) scores.")
                // Do something with the found objects
                if let objects = objects as? [PFObject] {
                    for object in objects {
                        self.acceptedOffers.append(object as PFObject)
                    }
                    self.acceptedOffersTableView.reloadData()
                }
            } else {
                
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
    }
    
    // MARK: - Table view data source
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.acceptedOffers.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("AcceptedOffersCell") as AcceptedOffersCell
        if self.acceptedOffers.count > 0 {
            println(indexPath.row)
            let result:PFObject = self.acceptedOffers[indexPath.row]
            cell.userCreatedLabel.text = result.objectForKey("userCreated") as? String
            cell.sourceLabel.text = result.objectForKey("source") as? String
            cell.destinationLabel.text = result.objectForKey("destination") as? String
            cell.viaLabel.text = result.objectForKey("via") as? String
            cell.timeLabel.text = result.objectForKey("time") as? String
            cell.descriptionLabel.text = result.objectForKey("description") as? String
            
        }
        return cell
    }
    
}

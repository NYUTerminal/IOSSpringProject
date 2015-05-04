//
//  SearchResultsTableViewController.swift
//  RideShare
//
//  Created by Alex Mathew on 4/24/15.
//  Copyright (c) 2015 NYU. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UIViewController, UITableViewDelegate , UITableViewDataSource{
    
    
    var searchResults:[PFObject] = []
    
    var source:String = ""
    
    var destination:String = ""
    
    var date:NSDate! = nil
    
    var time:NSDate! = nil
    
    var indexSelected:Int = 0
    
    @IBOutlet weak var SearchTableView: UITableView!
    
    func loadData() {
        searchResults = []
        var findSearchResults = PFQuery(className: "Offer")
        if(self.source != ""){
            findSearchResults.whereKey("source", equalTo:"Sean Plott")
        }
        if(self.destination != ""){
            findSearchResults.whereKey("destination", equalTo:"Sean Plott")
        }
        if(self.date != nil){
            findSearchResults.whereKey("date", equalTo:"Sean Plott")
        }
        if(self.time != nil){
            findSearchResults.whereKey("time", equalTo:"Sean Plott")
        }
        findSearchResults.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                // The find succeeded.
                println("Successfully retrieved \(objects.count) scores.")
                // Do something with the found objects
                if let objects = objects as? [PFObject] {
                    for object in objects {
                        self.searchResults.append(object as PFObject)
                    }
                    self.SearchTableView.reloadData()
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
        searchResults = []
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchResults.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("SearchCell") as SearchTableViewCell
        if self.searchResults.count > 0 {
            println(indexPath.row)
            let result:PFObject = self.searchResults[indexPath.row]
            cell.NameLabel.text = result.objectForKey("username") as? String
            cell.timeLabel.text = result.objectForKey("time") as? String
            cell.priceLabel.text = result.objectForKey("money") as? String
            cell.descriptionLabel.text = result.objectForKey("description") as? String
        }
        return cell
    }
    // MARK: - UITableViewDelegate Methods
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        self.indexSelected = indexPath.row
        println(self.indexSelected)
        println(self.searchResults[self.indexSelected])
        println(self.searchResults[self.indexSelected].valueForKey("objectId") as String!)
        Singelton.sharedInstance.offerId = self.searchResults[self.indexSelected].valueForKey("objectId") as String!
    }
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if (segue.identifier == "searchresult") {
//            let theDestination = (segue.destinationViewController as RideViewController)
//            println("PreparingForSegue")
//            let result:PFObject  = self.searchResults[self.indexSelected]
//            println(result.objectForKey("objectId") as? String)
//            theDestination.offerId = result.objectForKey("objectId") as String!
//        }
//    }
    
}

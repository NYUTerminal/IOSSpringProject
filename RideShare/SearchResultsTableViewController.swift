//
//  SearchResultsTableViewController.swift
//  RideShare
//
//  Created by Alex Mathew on 4/24/15.
//  Copyright (c) 2015 NYU. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UIViewController, UITableViewDelegate , UITableViewDataSource{

    
    var searchResults:NSMutableArray = NSMutableArray()
    
    @IBOutlet weak var SearchTableView: UITableView!
    func loadData() {
        searchResults.removeAllObjects()
        var findSearchResults:PFQuery = PFQuery( className: "Offer")
        
        findSearchResults.findObjectsInBackgroundWithBlock{ (objects:[AnyObject]!, error:NSError!)->Void in
            if !(error != nil){
                for object in objects{
                    self.searchResults.addObject(object as PFObject)
                }
                
                let searchArray:NSArray = self.searchResults.reverseObjectEnumerator().allObjects
                self.searchResults = searchArray as NSMutableArray
                self.SearchTableView.reloadData()
            
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        loadData()
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return searchResults.count
    }

    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:SearchTableViewCell = tableView.dequeueReusableCellWithIdentifier("searchCell", forIndexPath: indexPath) as SearchTableViewCell
        let result:PFObject = self.searchResults.objectAtIndex(indexPath.row) as PFObject
        
        cell.NameLabel.text = result.objectForKey("username") as String

        // Configure the cell...

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}

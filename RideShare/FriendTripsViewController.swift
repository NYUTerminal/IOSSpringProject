import Foundation


class FriendTripsViewController : UIViewController {
    
    override func viewDidLoad() {
        getFriendsList()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getFriendsList(){
        var fbRequestFriends: FBRequest = FBRequest.requestForMyFriends()
        
        fbRequestFriends.startWithCompletionHandler{
            (connection:FBRequestConnection!,result:AnyObject?, error:NSError!) -> Void in
            
            var resultdict = result as NSDictionary
            println("Result Dict: \(resultdict)")
            var data : NSArray = resultdict.objectForKey("data") as NSArray
            
            for i in 0 ..< data.count
            {
                let valueDict : NSDictionary = data[i] as NSDictionary
                let id = valueDict.objectForKey("id") as String
                println("the id value is \(id)")
            }
            
            var friends = resultdict.objectForKey("data") as NSArray
            println("Found \(friends.count) friends")
        }
    }
}
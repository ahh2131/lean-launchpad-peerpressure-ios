//
//  PostDetailViewController.swift
//  mrkt-beta
//
//  Created by Andy Hadjigeorgiou on 1/14/15.
//  Copyright (c) 2015 vigme. All rights reserved.
//

import UIKit

class PostDetailViewController: UIViewController, APIPostDetailProtocol {
    var post_id = Int()
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var mutualLabel: UILabel!
    @IBOutlet weak var postDescription: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var posterName: UILabel!
    @IBOutlet weak var mutual2: UIImageView!
    @IBOutlet weak var mutual1: UIImageView!
    var pre_image = UIImage()
    var mutual_friends = NSMutableArray()
    override func viewDidLoad() {
        super.viewDidLoad()
        println(post_id)
        api.delegatePostDetail = self
        api.getPostDetail(post_id)
        postImage.image = pre_image
        // Do any additional setup after loading the view.

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didReceivePostResults(results: NSDictionary) {
        
        var post = results.valueForKey("post") as NSDictionary
        var user = results.valueForKey("user") as NSDictionary
        var uid = user.valueForKey("uid") as String

        dispatch_async(dispatch_get_main_queue()) {
            var params = NSMutableDictionary()
            params.setValue("context.fields(mutual_friends)", forKey: "fields")
            FBRequestConnection.startWithGraphPath("/\(uid)", parameters: params, HTTPMethod: "GET", completionHandler: { (connection, result, error) -> Void in
                if( error == nil){
                    
                    let fbGraphObject = result as FBGraphObject
                    println(fbGraphObject)
                    let context = fbGraphObject.objectForKey("context") as NSMutableDictionary
                    let friends = context.objectForKey("mutual_friends") as NSMutableDictionary
                    println(friends)
                    let data = friends.objectForKey("data") as NSMutableArray
                    let summary = friends.objectForKey("summary") as NSDictionary
                    let total = summary.valueForKey("total_count") as Int
                    dispatch_async(dispatch_get_main_queue()) {
                        self.mutualLabel.text = "Mutual Friends (\(total))"
                    }
                    self.mutual_friends = data
                    var counter = 0
                    var mutualString = NSMutableString()
                    while counter < data.count {
                        var friend = data[counter] as NSDictionary
                        mutualString.appendString(friend.valueForKey("id") as String)
                        if counter < (data.count - 1) {
                            mutualString.appendString("X")
                        }
                        counter = counter + 1
                    }
                    api.getMutualFriendsImages(mutualString)
                    
                }else
                {
                    //TODO Allert to user that something went wrong
                    println(error)
                }
                
            })
            self.name.text = post.valueForKey("name") as? String
            self.postDescription.text = post.valueForKey("description") as? String
            self.posterName.text = user.valueForKey("name") as? String
        }
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            
            var image_url = post.valueForKey("image") as String
            var url = NSURL(string: image_url)
            var request: NSURLRequest = NSURLRequest(URL: url!, cachePolicy: NSURLRequestCachePolicy.ReturnCacheDataElseLoad, timeoutInterval: 2.0)
            
            var urlConnection: NSURLConnection = NSURLConnection(request: request, delegate: self)!
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
                
                if error == nil {
                    var image = UIImage(data: data)
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        self.postImage.image = image
                    }
                }
            })
            var poster_url = user.valueForKey("image") as String
            var url2 = NSURL(string: poster_url)
            var request2: NSURLRequest = NSURLRequest(URL: url2!, cachePolicy: NSURLRequestCachePolicy.ReturnCacheDataElseLoad, timeoutInterval: 2.0)
            
            var urlConnection2: NSURLConnection = NSURLConnection(request: request2, delegate: self)!
            NSURLConnection.sendAsynchronousRequest(request2, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
                
                if error == nil {
                    var image = UIImage(data: data)
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        self.posterImage.image = image
                    }
                }
            })
            
        })
        
        println(mutual_friends)
        
    }
    
    func didReceiveFriendsResults(results: NSDictionary) {
        var friends = results.valueForKey("friends") as NSArray
        if friends.count > 0 {
            var friend = friends[0] as NSDictionary
            var image = friend.valueForKey("image") as String
            var url = NSURL(string: image)
            var request: NSURLRequest = NSURLRequest(URL: url!, cachePolicy: NSURLRequestCachePolicy.ReturnCacheDataElseLoad, timeoutInterval: 2.0)
            
            var urlConnection: NSURLConnection = NSURLConnection(request: request, delegate: self)!
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
                
                if error == nil {
                    var image = UIImage(data: data)
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        self.mutual1.image = image
                    }
                }
            })
        }
        if friends.count > 1 {
            var friend = friends[1] as NSDictionary
            var image = friend.valueForKey("image") as String
            var url = NSURL(string: image)
            var request: NSURLRequest = NSURLRequest(URL: url!, cachePolicy: NSURLRequestCachePolicy.ReturnCacheDataElseLoad, timeoutInterval: 2.0)
            
            var urlConnection: NSURLConnection = NSURLConnection(request: request, delegate: self)!
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
                
                if error == nil {
                    var image = UIImage(data: data)
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        self.mutual2.image = image
                    }
                }
            })
        }
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  PostsViewController.swift
//  mrkt-beta
//
//  Created by Andy Hadjigeorgiou on 1/12/15.
//  Copyright (c) 2015 vigme. All rights reserved.
//

import UIKit
import CoreLocation


class PostsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate, APIShopProtocol, APILocationProtocol, UISearchBarDelegate {
    var manager:CLLocationManager!
    var products = NSMutableArray()
    var refresher = UIRefreshControl()
    
    var have_location = 0
    var categories = NSMutableArray()
    var price = Double()
    var distance = Double()
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestAlwaysAuthorization()
        manager.startUpdatingLocation()
        api.delegateShop = self
        api.delegateLocation = self
        refresher.attributedTitle = NSAttributedString()
        refresher.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refresher)
        NSUserDefaults.standardUserDefaults().setObject(0, forKey: "furniture")
        NSUserDefaults.standardUserDefaults().setObject(0, forKey: "appliances")
        NSUserDefaults.standardUserDefaults().setObject(0, forKey: "books")
        NSUserDefaults.standardUserDefaults().setObject(0, forKey: "electronics")
        NSUserDefaults.standardUserDefaults().setObject(0, forKey: "rentals")
        NSUserDefaults.standardUserDefaults().setObject(0, forKey: "tickets")
        NSUserDefaults.standardUserDefaults().setObject(0, forKey: "clothing")
        NSUserDefaults.standardUserDefaults().setObject(0, forKey: "random")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "postDetail" {
            let tableVC = segue.destinationViewController as PostDetailViewController
            var productIndex = sender!.tag as Int
            var path: NSIndexPath = NSIndexPath(forRow: productIndex, inSection: 0)
            var cell = self.tableView.cellForRowAtIndexPath(path) as PostTableViewCell
            tableVC.pre_image = cell.postImage.image!
            tableVC.post_id = cell.id
        }
    }
    func tableView(tableView: UITableView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        api.delegateShop = self
        if have_location == 1 {
            categories = NSMutableArray()
            //products = NSMutableArray()

            self.tableView.contentOffset = CGPointMake(0, 0 - self.tableView.contentInset.top)
            if NSUserDefaults.standardUserDefaults().objectForKey("furniture") as Int == 1 {
                categories.addObject("furniture")
            }
            if NSUserDefaults.standardUserDefaults().objectForKey("appliances") as Int == 1 {
                categories.addObject("appliances")
            }
            if NSUserDefaults.standardUserDefaults().objectForKey("books") as Int == 1 {
                categories.addObject("books")
            }
            if NSUserDefaults.standardUserDefaults().objectForKey("electronics") as Int == 1 {
                categories.addObject("electronics")
            }
            if NSUserDefaults.standardUserDefaults().objectForKey("rentals") as Int == 1 {
                categories.addObject("rentals")
            }
            if NSUserDefaults.standardUserDefaults().objectForKey("tickets") as Int == 1 {
                categories.addObject("tickets")
            }
            if NSUserDefaults.standardUserDefaults().objectForKey("clothing") as Int == 1 {
                categories.addObject("clothing")
            }
            if NSUserDefaults.standardUserDefaults().objectForKey("random") as Int == 1 {
                categories.addObject("random")
            }
            if NSUserDefaults.standardUserDefaults().objectForKey("price") != nil {
                price = NSUserDefaults.standardUserDefaults().objectForKey("price") as Double
            }
            if NSUserDefaults.standardUserDefaults().objectForKey("distance") != nil {
                distance = NSUserDefaults.standardUserDefaults().objectForKey("distance") as Double
            }
            dispatch_async(dispatch_get_main_queue()) {
            api.getPosts(self.categories, search: self.searchBar.text, price: self.price, distance: self.distance)
            }
        }
    }
    
    @IBAction func filtersPress(sender: AnyObject) {
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        
        api.getPosts(categories, search: searchBar.text, price: price, distance: distance)
        searchBar.resignFirstResponder()
    }
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    func refresh() {
        if have_location == 1 {
            api.getPosts(categories, search: searchBar.text, price: price, distance: distance)
        }
        self.refresher.endRefreshing()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func didReceivePostResults(toReturn: NSDictionary) {
        var newProducts = toReturn.valueForKey("posts") as NSArray
        products = NSMutableArray()
        println("test")
        products.addObjectsFromArray(newProducts)
        //dispatch_async(dispatch_get_main_queue()) {
            self.tableView.reloadData()
      //  }
    }
    func didReceiveLikeResults() {
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func fromSetLocation() {
        println("what")
        have_location = 1
        api.getPosts(categories, search: searchBar.text, price: price, distance: distance)
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("postCell") as PostTableViewCell
        var current = products[indexPath.row] as NSDictionary
        var price: AnyObject? = current.valueForKey("price")
        cell.tag = indexPath.row
        cell.id = current.valueForKey("id") as Int
        cell.name.text = current.valueForKey("name") as? String
        cell.body.text = current.valueForKey("description") as? String
        cell.price.text = "$\(price!)"
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            
            var image_url = current.valueForKey("photo") as String
            var url = NSURL(string: image_url)
            var request: NSURLRequest = NSURLRequest(URL: url!, cachePolicy: NSURLRequestCachePolicy.ReturnCacheDataElseLoad, timeoutInterval: 2.0)
            
            var urlConnection: NSURLConnection = NSURLConnection(request: request, delegate: self)!
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
                
                if error == nil {
                    var image = UIImage(data: data)
                    
                    dispatch_async(dispatch_get_main_queue()) {
                            cell.postImage.image = image
                    }
                }
            })
        })
        
        return cell as PostTableViewCell
    }
    
    func locationManager(manager:CLLocationManager, didUpdateLocations locations:[AnyObject]) {
        println("test")
        api.setLocation(locations.last?.coordinate.latitude.description, longitude: locations.last?.coordinate.longitude.description)
        manager.stopUpdatingLocation()
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

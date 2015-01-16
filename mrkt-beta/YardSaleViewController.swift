//
//  YardSaleViewController.swift
//  mrkt-beta
//
//  Created by Andy Hadjigeorgiou on 1/13/15.
//  Copyright (c) 2015 vigme. All rights reserved.
//

import UIKit

import UIKit
import CoreLocation
var categories = NSMutableArray()

class YardSaleViewController: UIViewController, CLLocationManagerDelegate, APIShopProtocol {
    
    @IBOutlet weak var image1: UIImageView!
    
    @IBOutlet weak var image2: UIImageView!
    
    @IBOutlet weak var image3: UIImageView!
    
    var images = NSMutableArray()
    
    var image_data = Array<UIImageView>()
    
    var manager:CLLocationManager!
    
    @IBOutlet weak var info: UILabel!
    
    @IBOutlet weak var info2: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var price2: UILabel!
    
    @IBOutlet weak var frame_view: UIView!
    
    @IBOutlet weak var frame_view2: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        frame_view.layer.cornerRadius = 2.0
        frame_view.layer.borderColor = UIColor.grayColor().CGColor
        frame_view.layer.borderWidth = 0.5
        frame_view2.layer.cornerRadius = 2.0
        frame_view2.layer.borderColor = UIColor.grayColor().CGColor
        frame_view2.layer.borderWidth = 0.5
        
        // Do any additional setup after loading the view, typically from a nib.
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestAlwaysAuthorization()
        manager.startUpdatingLocation()
        image_data.append(image3)
        image_data.append(image2)
        image_data.append(image1)
        api.delegateShop = self
        api.getYardPosts(categories, search: "")
        
    }
    
    override func viewWillAppear(animated: Bool) {
        api.getYardPosts(categories, search: "")
    }
    
    
    
    @IBAction func handlePan1(recognizer:UIPanGestureRecognizer) {
        var orig_center_x = recognizer.view!.center.x
        var orig_center_y = recognizer.view!.center.y
        let translation = recognizer.translationInView(self.view)
        recognizer.view!.center = CGPoint(x:recognizer.view!.center.x + translation.x,
            y:recognizer.view!.center.y + translation.y)
        if recognizer.state == UIGestureRecognizerState.Ended {
            
            println(recognizer.view!.center.x)
            if recognizer.view!.center.x >= 290 {
                swipeRightLike()
                self.image3.hidden = true
                self.frame_view.hidden = true
                
                recognizer.view!.center = CGPoint(x:160, y:255)
                
            } else if recognizer.view!.center.x <= 40 {
                swipeLeftDislike()
                self.image3.hidden = true
                self.frame_view.hidden = true
                
                recognizer.view!.center = CGPoint(x:160, y:255)
                
            } else {
                
                let velocity = recognizer.velocityInView(self.view)
                let magnitude = sqrt((velocity.x * velocity.x) + (velocity.y * velocity.y))
                let slideMultiplier = magnitude / 200
                println("magnitude: \(magnitude), slideMultiplier: \(slideMultiplier)")
                
                // 2
                let slideFactor = 0.1 * 1.45     //Increase for more of a slide
                // 3
                
                
                // 5
                UIView.animateWithDuration(Double(slideFactor * 2),
                    delay: 0,
                    // 6
                    options: UIViewAnimationOptions.CurveEaseOut,
                    animations: {recognizer.view!.center = CGPoint(x:160,
                        y:255) },
                    completion: nil)
                
            }
        }
        recognizer.setTranslation(CGPointZero, inView: self.view)
        
    }
    
    @IBAction func handlePan2(recognizer:UIPanGestureRecognizer) {
        var orig_center_x = recognizer.view!.center.x
        var orig_center_y = recognizer.view!.center.y
        let translation = recognizer.translationInView(self.view)
        recognizer.view!.center = CGPoint(x:recognizer.view!.center.x + translation.x,
            y:recognizer.view!.center.y + translation.y)
        if recognizer.state == UIGestureRecognizerState.Ended {
            
            println(recognizer.view!.center.x)
            if recognizer.view!.center.x >= 290 {
                swipeRightLike()
                self.image3.hidden = true
                recognizer.view!.center = CGPoint(x:160, y:220)
                
            } else if recognizer.view!.center.x <= 40 {
                swipeLeftDislike()
                self.image3.hidden = true
                
                recognizer.view!.center = CGPoint(x:160, y:220)
                
            } else {
                
                let velocity = recognizer.velocityInView(self.view)
                let magnitude = sqrt((velocity.x * velocity.x) + (velocity.y * velocity.y))
                let slideMultiplier = magnitude / 200
                println("magnitude: \(magnitude), slideMultiplier: \(slideMultiplier)")
                
                // 2
                let slideFactor = 0.1 * 1.45     //Increase for more of a slide
                // 3
                
                
                // 5
                UIView.animateWithDuration(Double(slideFactor * 2),
                    delay: 0,
                    // 6
                    options: UIViewAnimationOptions.CurveEaseOut,
                    animations: {recognizer.view!.center = CGPoint(x:160,
                        y:220) },
                    completion: nil)
                
            }
        }
        recognizer.setTranslation(CGPointZero, inView: self.view)
        
    }
    
    @IBAction func handlePan3(recognizer:UIPanGestureRecognizer) {
        
        var orig_center_x = recognizer.view!.center.x
        var orig_center_y = recognizer.view!.center.y
        let translation = recognizer.translationInView(self.view)
        recognizer.view!.center = CGPoint(x:recognizer.view!.center.x + translation.x,
            y:recognizer.view!.center.y + translation.y)
        if recognizer.state == UIGestureRecognizerState.Ended {
            
            println(recognizer.view!.center.x)
            if recognizer.view!.center.x >= 290 {
                swipeRightLike()
                self.frame_view.hidden = true
                self.image3.hidden = true
                
                recognizer.view!.center = CGPoint(x:160, y:150)
                
            } else if recognizer.view!.center.x <= 40 {
                swipeLeftDislike()
                self.image3.hidden = true
                recognizer.view!.center = CGPoint(x:160, y:150)
                
            } else {
                
                let velocity = recognizer.velocityInView(self.view)
                let magnitude = sqrt((velocity.x * velocity.x) + (velocity.y * velocity.y))
                let slideMultiplier = magnitude / 200
                println("magnitude: \(magnitude), slideMultiplier: \(slideMultiplier)")
                
                // 2
                let slideFactor = 0.1 * 1.45     //Increase for more of a slide
                // 3
                
                
                // 5
                UIView.animateWithDuration(Double(slideFactor * 2),
                    delay: 0,
                    // 6
                    options: UIViewAnimationOptions.CurveEaseOut,
                    animations: {recognizer.view!.center = CGPoint(x:160,
                        y:150) },
                    completion: nil)
                
            }
        }
        recognizer.setTranslation(CGPointZero, inView: self.view)
        
    }
    
    func didReceiveLikeResults() {
        api.getYardPosts(categories, search: "")
    }
    
    func didReceivePostResults(toReturn: NSDictionary) {
        var image_array = toReturn.valueForKey("posts") as NSMutableArray
        if image_array.count != 0 {
            images = image_array
            frame_view.hidden = false
            frame_view2.hidden = false
            image3.hidden = false
            image2.hidden = false
            image1.hidden = false
            downloadImages()
        }
        if image_array.count == 0 {
            println("when this")
            dispatch_async(dispatch_get_main_queue()) {
                self.frame_view.hidden = true
                self.frame_view2.hidden = true
                self.image3.hidden = true
                self.image2.hidden = true
                self.image1.hidden = true
                self.info.text = ""
                self.price.text = ""
            }
            
        }
    }
    
    func downloadImages() {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            
            for (index, element) in enumerate(self.images) {
                
                var url = NSURL(string:self.images[index].valueForKey("photo") as String)
                var request: NSURLRequest = NSURLRequest(URL: url!, cachePolicy: NSURLRequestCachePolicy.ReturnCacheDataElseLoad, timeoutInterval: 2.0)
                var urlConnection: NSURLConnection = NSURLConnection(request: request, delegate: self)!
                NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
                    
                    if error == nil {
                        var image = UIImage(data: data)
                        
                        dispatch_async(dispatch_get_main_queue()) {
                            if index < 3 {
                                self.image_data[index].image = image
                                if index == 0 {
                                    self.frame_view.hidden = false
                                    self.image3.hidden = false
                                }
                            }
                        }
                    }
                })
                
            }
            var image_count = self.images.count
            if image_count != 0 {
                dispatch_async(dispatch_get_main_queue()) {
                    self.info.text = self.images[0].valueForKey("name") as? String
                    var price: AnyObject? = self.images[0].valueForKey("price")
                    self.price.text = "$\(price!)"
                }
            }
            if image_count > 1 {
                dispatch_async(dispatch_get_main_queue()) {
                    self.info2.text = self.images[1].valueForKey("description") as? String
                    var price: AnyObject? = self.images[1].valueForKey("price")
                    self.price2.text = "$\(price!)"
                }
            }
            if image_count == 1 {
                dispatch_async(dispatch_get_main_queue()) {
                    self.frame_view2.hidden = true
                    self.image2.hidden = true
                }
            }
        })
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(manager:CLLocationManager, didUpdateLocations locations:[AnyObject]) {
        api.setLocation(locations.last?.coordinate.latitude.description, longitude: locations.last?.coordinate.longitude.description)
        manager.stopUpdatingLocation()
    }
    
    @IBAction func noButtonPressed(sender: AnyObject) {
        if image_data[0].image != nil {
            swipeLeftDislike()
        }
    }
    @IBAction func yesButtonPressed(sender: AnyObject) {
        if image_data[0].image != nil {
            swipeRightLike()
        }
    }
    
    func swipeRightLike() {
        
        var post_id = images[0].valueForKey("id") as Int
        var user_id = images[0].valueForKey("user_id") as Int
        api.likePost(post_id, user_id: user_id)
    }
    
    func swipeLeftDislike() {
        var post_id = images[0].valueForKey("id") as Int
        var user_id = images[0].valueForKey("user_id") as Int
        api.dislikePost(post_id, user_id: user_id)
    }
}


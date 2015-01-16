//
//  MrktAPIModel.swift
//  mrkt-beta
//
//  Created by Andy Hadjigeorgiou on 12/1/14.
//  Copyright (c) 2014 vigme. All rights reserved.
//

import Foundation

protocol APILoginControllerProtocol {
    
  //  func newUserLogin(email: String, token: String)
    func userSignIn()
}

protocol APIDiscoverFeedProtocol {
    func didReceiveDiscoverFeedResults(toReturn: NSDictionary)
}

protocol APIProductDetailProtocol {
    func didReceiveProductDetailResults(toReturn: NSDictionary)
}

protocol APIProfileProtocol {
    func didReceiveProfileResults(toReturn: NSDictionary)
}

protocol APIPostProductProtocol {
    
}
protocol APILocationProtocol {
    func fromSetLocation()
}

protocol APIChatsProtocol {
    func didReceiveChatResults(toReturn: NSDictionary)

}
protocol APIPostDetailProtocol {
    func didReceivePostResults(toReturn: NSDictionary)
    func didReceiveFriendsResults(toReturn: NSDictionary)
}
protocol APIShopProtocol {
    func didReceivePostResults(toReturn: NSDictionary)
    func didReceiveLikeResults()
}


class MrktAPIModel {
    
    var delegate: APILoginControllerProtocol?
    var delegateDiscover: APIDiscoverFeedProtocol?
    var delegateProductDetail: APIProductDetailProtocol?
    var delegateProfile: APIProfileProtocol?
    var delegatePostProduct: APIPostProductProtocol?
    var delegateShop: APIShopProtocol?
    var delegateChats: APIChatsProtocol?
    var delegateLocation: APILocationProtocol?
    var delegatePostDetail: APIPostDetailProtocol?
    var base_url = "http://104.131.28.62:3000/"
    let email: String?
    var name: String?
    var avatar: String?
    var gender: String?
    let password: String?
    var token: String?

    
    init(email: String) {
        
        // get auth key from email from nsuserdefaults
        self.email = email
        self.password = getPassword()
        println(self.password)
        self.avatar = getAvatar()
        self.token = getToken()
        println(self.token)
        if self.token == "0" {
            self.token = signIn()
        } else {
            self.getGender()
            self.delegate?.userSignIn()
        }
    }
    
    func getPosts(parameters: NSMutableArray, search: String, price: Double, distance: Double) {
        var parameterString: NSMutableString = "?"
        for param in parameters {
            parameterString.appendString("\(param)=1&")
        }
        if price > 0 {
            parameterString.appendString("price=\(price)&")
        }
        if distance > 0 {
            parameterString.appendString("distance=\(distance)&")
        }
        
        var full_string = base_url + "mrkt/" + self.email! + "/" + self.token! + "/getPosts\(parameterString)"
        println(full_string)
        var full_url = NSURL(string: full_string)
        var toReturn: NSDictionary = NSDictionary()
        var request: NSURLRequest = NSURLRequest(URL:full_url!)
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession.sharedSession()
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request, completionHandler: {(data, response, error) in
            
            var err: NSError?
            var jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as NSDictionary
            
            if(err != nil) {
                // If there is an error parsing JSON, print it to the console
                println("JSON Error \(err!.localizedDescription)")
            }
            toReturn = jsonResult
            
            self.delegateShop?.didReceivePostResults(toReturn)
            
        });
        
        task.resume()
    }
    
    func getMutualFriendsImages(friends: String) {

        var full_string = base_url + "mrkt/" + self.email! + "/" + self.token! + "/getMutualFriendsImages/\(friends)"
        println(full_string)
        var full_url = NSURL(string: full_string)
        var toReturn: NSDictionary = NSDictionary()
        var request: NSURLRequest = NSURLRequest(URL:full_url!)
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession.sharedSession()
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request, completionHandler: {(data, response, error) in
            
            var err: NSError?
            var jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as NSDictionary
            
            if(err != nil) {
                // If there is an error parsing JSON, print it to the console
                println("JSON Error \(err!.localizedDescription)")
            }
            toReturn = jsonResult
            
            self.delegatePostDetail?.didReceiveFriendsResults(toReturn)
            
        });
        
        task.resume()
    }
    
    func getYardPosts(parameters: NSMutableArray, search: String) {
        var parameterString: NSMutableString = "?"
        for param in parameters {
            parameterString.appendString("\(param)=1&")
        }
        /* if search != "" {
        parameterString.appendString("search=\(search)")
        }*/
        var full_string = base_url + "mrkt/" + self.email! + "/" + self.token! + "/getYardPosts\(parameterString)"
        println(full_string)
        var full_url = NSURL(string: full_string)
        var toReturn: NSDictionary = NSDictionary()
        var request: NSURLRequest = NSURLRequest(URL:full_url!)
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession.sharedSession()
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request, completionHandler: {(data, response, error) in
            
            var err: NSError?
            var jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as NSDictionary
            
            if(err != nil) {
                // If there is an error parsing JSON, print it to the console
                println("JSON Error \(err!.localizedDescription)")
            }
            toReturn = jsonResult
            
            self.delegateShop?.didReceivePostResults(toReturn)
            
        });
        
        task.resume()
    }
    
    func getChats() {
        var full_string = base_url + "mrkt/" + self.email! + "/" + self.token! + "/getChats"
        var full_url = NSURL(string: full_string)
        var toReturn: NSDictionary = NSDictionary()
        var request: NSURLRequest = NSURLRequest(URL:full_url!)
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession.sharedSession()
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request, completionHandler: {(data, response, error) in
            
            var err: NSError?
            var jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as NSDictionary
            
            if(err != nil) {
                // If there is an error parsing JSON, print it to the console
                println("JSON Error \(err!.localizedDescription)")
            }
            toReturn = jsonResult
            
            self.delegateChats?.didReceiveChatResults(toReturn)
            
        });
        
        task.resume()
    }
    
    func getPostDetail(post_id: Int) {
    
        var full_string = base_url + "mrkt/" + self.email! + "/" + self.token! + "/getPostDetail/\(post_id)"
        println(full_string)
        var full_url = NSURL(string: full_string)
        var toReturn: NSDictionary = NSDictionary()
        var request: NSURLRequest = NSURLRequest(URL:full_url!)
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession.sharedSession()
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request, completionHandler: {(data, response, error) in
            
            var err: NSError?
            var jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as NSDictionary
            
            if(err != nil) {
                // If there is an error parsing JSON, print it to the console
                println("JSON Error \(err!.localizedDescription)")
            }
            toReturn = jsonResult
            
            self.delegatePostDetail?.didReceivePostResults(toReturn)
            
        });
        
        task.resume()
    }
    
    func likePost(post_id: Int, user_id: Int) {

        var full_url = base_url + "mrkt/likePost"

        println(full_url)
        self.post(["user_token":self.token!, "user_email":self.email!, "user_1":String(user_id), "post_id":String(post_id)], url: full_url as String) { (succeeded: Bool, msg: NSDictionary) -> () in
            println("test")
            self.delegateShop?.didReceiveLikeResults()
        }
    }
    
    func dislikePost(post_id: Int, user_id: Int) {
        
        var full_url = base_url + "mrkt/dislikePost"
        
        println(full_url)
        self.post(["user_token":self.token!, "user_email":self.email!, "user_1":String(user_id), "post_id":String(post_id)], url: full_url as String) { (succeeded, msg) -> () in
            println("test")
            self.delegateShop?.didReceiveLikeResults()
        }

    }
    
    func setLocation(latitude: String?, longitude: String?) {
        var full_url = base_url + "mrkt/setLocation"
        
        //var full_url = self.base_url + "mrkt/setLocation"
        //println(full_url)
        var toPost = ["user_token":self.token!, "user_email":self.email!, "latitude": latitude!, "longitude":longitude!]
        self.post(toPost, url: full_url as String) { (succeeded: Bool, msg: NSDictionary) ->() in
            println("test")
          self.delegateLocation?.fromSetLocation()
        }

    }
    

    func getProductDetail(product_id: NSInteger, user_id: NSInteger, offset: NSInteger) {
        var full_url = getFullUrl("product/\(product_id)/\(offset)?from_user=\(user_id)")
        println(full_url.description)
        var toReturn: NSDictionary = NSDictionary()
        var request: NSURLRequest = NSURLRequest(URL:full_url)
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession.sharedSession()
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request, completionHandler: {(data, response, error) in
            
            var err: NSError?
            var jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as NSDictionary
            
            if(err != nil) {
                // If there is an error parsing JSON, print it to the console
                println("JSON Error \(err!.localizedDescription)")
            }
            toReturn = jsonResult
            
            self.delegateProductDetail?.didReceiveProductDetailResults(toReturn)
            
        });
        
        task.resume()
        
    }
    
    func saveProduct(product_id: NSInteger) {
        
        var full_url = getFullUrl("product/share?product=\(product_id)")
        println(full_url.description)
        var toReturn: NSDictionary = NSDictionary()
        var request: NSURLRequest = NSURLRequest(URL:full_url)
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession.sharedSession()
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request, completionHandler: {(data, response, error) in
            
            var err: NSError?
            var jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as NSDictionary
            
            if(err != nil) {
                // If there is an error parsing JSON, print it to the console
                println("JSON Error \(err!.localizedDescription)")
            }
            
        });
        
        task.resume()
        
    }
    
    func getProfile(user_id: NSInteger) {
        
        var full_url = getFullUrl("profile/\(user_id)")
        println(full_url.description)
        var toReturn: NSDictionary = NSDictionary()
        var request: NSURLRequest = NSURLRequest(URL:full_url)
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession.sharedSession()
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request, completionHandler: {(data, response, error) in
            
            var err: NSError?
            var jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as NSDictionary
            
            if(err != nil) {
                // If there is an error parsing JSON, print it to the console
                println("JSON Error \(err!.localizedDescription)")
            }
            toReturn = jsonResult
            
            self.delegateProfile?.didReceiveProfileResults(toReturn)
            
            
        });
        
        task.resume()
        
    }
    
    func followUser(user_id: NSInteger) {
        var full_url = getFullUrl("follow/\(user_id)")
        println(full_url.description)
        var toReturn: NSDictionary = NSDictionary()
        var request: NSURLRequest = NSURLRequest(URL:full_url)
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession.sharedSession()
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request, completionHandler: {(data, response, error) in
            
            var err: NSError?
            var jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as NSDictionary
            
            if(err != nil) {
                // If there is an error parsing JSON, print it to the console
                println("JSON Error \(err!.localizedDescription)")
            }
            
        });
        
        task.resume()
    }
    
    func unfollowUser(user_id: NSInteger) {
        var full_url = getFullUrl("unfollow/\(user_id)")
        println(full_url.description)
        var toReturn: NSDictionary = NSDictionary()
        var request: NSURLRequest = NSURLRequest(URL:full_url)
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession.sharedSession()
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request, completionHandler: {(data, response, error) in
            
            var err: NSError?
            var jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as NSDictionary
            
            if(err != nil) {
                // If there is an error parsing JSON, print it to the console
                println("JSON Error \(err!.localizedDescription)")
            }
            
        });
        
        task.resume()
    }
    
    func getDiscoverFeed(page: NSInteger) {
        var full_url = getFullUrl("discover/\(page)")
        println(full_url.description)
        var toReturn: NSDictionary = NSDictionary()
        var request: NSURLRequest = NSURLRequest(URL:full_url)
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession.sharedSession()
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request, completionHandler: {(data, response, error) in
            
            var err: NSError?
            var jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as NSDictionary
            
            if(err != nil) {
                // If there is an error parsing JSON, print it to the console
                println("JSON Error \(err!.localizedDescription)")
            }
            toReturn = jsonResult
            
            self.delegateDiscover?.didReceiveDiscoverFeedResults(toReturn)
            
            
        });
        
        task.resume()
    }
    
    func getFullUrl(url_string: String) -> NSURL {
        var full_string = base_url + self.email! + "/" + self.token! + "/" + url_string
        var full_url = NSURL(string: full_string)
        return full_url!
    }
    
    func userLoggedIn(){
        println(token)
        self.delegate?.userSignIn()
    }
    
    func getToken() -> String {
        var auth: AnyObject? = NSUserDefaults.standardUserDefaults().objectForKey("token")
        if auth != nil {
            return auth as String
        } else {
            return "0"
        }
    }
    
    func postProduct(image_url: String, price: String, info: String, name: String, params: NSMutableArray) {
        var parameterString: NSMutableString = "?"
        for param in params {
            parameterString.appendString("\(param)=1&")
        }
        var full_url = self.base_url + "mrkt/createPost\(parameterString)"
        println(full_url)
        self.post(["user_token":self.token!, "user_email":self.email!, "name":name, "price": price, "description":info, "url":image_url], url: full_url as String) { (succeeded: Bool, msg: NSDictionary) -> () in
            
            /*if msg.valueForKey("user")?.valueForKey("token") != nil {
                self.token = (msg.valueForKey("user") as NSDictionary).valueForKey("token") as? String
                NSUserDefaults.standardUserDefaults().setObject(self.token, forKey: "token")
                NSUserDefaults.standardUserDefaults().synchronize()
            }
            if self.token != nil {
                self.delegate?.userSignIn()
            }*/
        }
    }
    
    func signIn() -> String {
        
        var full_url = self.base_url + "api/signin"
        println("passw?")
        println(self.password!)
        self.post(["user_email": self.email!, "user_password":self.password!], url: full_url as String) { (succeeded: Bool, msg: NSDictionary) -> () in
            
            if msg.valueForKey("user")?.valueForKey("token") != nil {
                self.token = (msg.valueForKey("user") as NSDictionary).valueForKey("token") as? String
                NSUserDefaults.standardUserDefaults().setObject(self.token, forKey: "token")
                NSUserDefaults.standardUserDefaults().synchronize()
            }
            if self.token! != "0" {
                self.delegate?.userSignIn()
                self.gender = NSUserDefaults.standardUserDefaults().objectForKey("gender")! as? String
            } else {
                self.getName()
                self.getGender()
                self.signUp()
            }
        }
        return self.token!
    }
    
    func signUp() {
        
        var full_url = self.base_url + "api/signup"
        println(full_url)
        var uid = getUid()
        self.post(["uid": uid,"email": self.email!, "password":self.password!, "name": self.name!, "avatar": self.avatar!, "gender": self.gender!], url: full_url as String) { (succeeded: Bool, msg: NSDictionary) -> () in
            
            if msg.valueForKey("user")?.valueForKey("token") != nil {
                self.token = (msg.valueForKey("user") as NSDictionary).valueForKey("token") as? String
                NSUserDefaults.standardUserDefaults().setObject(self.token, forKey: "token")
                NSUserDefaults.standardUserDefaults().synchronize()
            }
            if self.token != nil {
                NSUserDefaults.standardUserDefaults().setObject(0, forKey: "step_number")
                self.delegate?.userSignIn()
            }
        }
    }
    
    func getUid() -> String {
        var uid = NSUserDefaults.standardUserDefaults().objectForKey("object_id") as String
        return uid
    }
    
    func getName() {
        self.name = NSUserDefaults.standardUserDefaults().objectForKey("name") as String!
    }
    
    func getPassword() -> String {
        return NSUserDefaults.standardUserDefaults().objectForKey("password") as String!
    }
    
    func getAvatar() -> String {
        var user_id: AnyObject? = NSUserDefaults.standardUserDefaults().objectForKey("password")
        var fb_url = "http://graph.facebook.com/\(user_id!)/picture?type=normal"
        return fb_url
    }
    
    func getGender() {
        self.gender = NSUserDefaults.standardUserDefaults().objectForKey("gender") as String!
    }
    
    func post(params : Dictionary<String, String>, url : String, postCompleted : (succeeded: Bool, msg: NSDictionary) -> ()) {
        var request = NSMutableURLRequest(URL: NSURL(string: url as String)!)
        var session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
        
        var err: NSError?
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &err)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            println("Response: \(response)")
            var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
            println("Body: \(strData)")
            var err: NSError?
            var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &err) as? NSDictionary
            
            var msg = json
            if json != nil {
                postCompleted(succeeded: true, msg: json!)
            }
            // Did the JSONObjectWithData constructor return an error? If so, log the error to the console
            /*if(err != nil) {
            println(err!.localizedDescription)
            let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
            println("Error could not parse JSON: '\(jsonStr)'")
            postCompleted(succeeded: false, msg: msg!)
            }*/
            
        })
        
        task.resume()
    }
    
    
    
    
}
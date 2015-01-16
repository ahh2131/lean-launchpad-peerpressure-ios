//
//  LoginViewController.swift
//  mrkt-beta
//
//  Created by Andy Hadjigeorgiou on 11/30/14.
//  Copyright (c) 2014 vigme. All rights reserved.
//

import UIKit

var api: MrktAPIModel!

class LoginViewController: UIViewController, FBLoginViewDelegate, APILoginControllerProtocol {

    @IBOutlet weak var fbLoginView: FBLoginView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fbLoginView.delegate = self
        self.fbLoginView.readPermissions = ["public_profile", "email", "user_friends"]
        println(NSUserDefaults.standardUserDefaults().objectForKey("object_id") as String)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loginViewShowingLoggedInUser(loginView: FBLoginView!) {
        println("user logged in")
        println("this is where you perform a segue")
        //self.performSegueWithIdentifier("loggedIn", sender: self)
    }
    
    func loginViewFetchedUserInfo(loginView: FBLoginView!, user: FBGraphUser!) {
        
        println("User name: \(user.objectID)")
        println(user.objectForKey("email"))
        if (NSUserDefaults.standardUserDefaults().objectForKey("email") == nil) {
            NSUserDefaults.standardUserDefaults().setObject(user.objectForKey("email"), forKey: "email")
            NSUserDefaults.standardUserDefaults().setObject(user.objectID, forKey: "password")
            NSUserDefaults.standardUserDefaults().setObject(user.objectForKey("name"), forKey: "name")
            NSUserDefaults.standardUserDefaults().setObject(user.objectID, forKey: "object_id")

            if user.objectForKey("gender") as NSString == "male" {
                NSUserDefaults.standardUserDefaults().setObject("M", forKey: "gender")
            } else {
                NSUserDefaults.standardUserDefaults().setObject("F", forKey: "gender")
            }
            
            NSUserDefaults.standardUserDefaults().synchronize()
            
            api = MrktAPIModel(email: NSUserDefaults.standardUserDefaults().objectForKey("email")! as String)
            api.delegate = self
        } else {
            api = MrktAPIModel(email: NSUserDefaults.standardUserDefaults().objectForKey("email")! as String)
            api.delegate = self
            api.userLoggedIn()
        }
        
    }
    
    func loginViewShowingLoggedOutUser(loginView: FBLoginView!) {
        println("user logged out")
    }
    
    func loginView(loginView: FBLoginView!, handleError error: NSError!) {
        println("Error: \(error.localizedDescription)")
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }
    
    func newUserLogin(email: String, token: String) {
        self.performSegueWithIdentifier("stepOne", sender: self)
    }
    
    func userSignIn() {
        // check step_number
        self.performSegueWithIdentifier("loggedIn", sender: self)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

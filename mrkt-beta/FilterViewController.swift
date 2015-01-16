//
//  FilterViewController.swift
//  mrkt-beta
//
//  Created by Andy Hadjigeorgiou on 1/13/15.
//  Copyright (c) 2015 vigme. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {
    
    @IBOutlet weak var furnitureButton: UIButton!
    
    @IBOutlet weak var distanceSlider: UISlider!
    @IBOutlet weak var priceSlider: UISlider!

    @IBOutlet weak var distanceValue: UILabel!
    @IBOutlet weak var priceValue: UILabel!
    @IBOutlet weak var applianceButton: UIButton!
    @IBOutlet weak var bookButton: UIButton!
    @IBOutlet weak var electronicsButton: UIButton!
    @IBOutlet weak var rentalsButton: UIButton!
    @IBOutlet weak var ticketsButton: UIButton!
    @IBOutlet weak var clothingButton: UIButton!
    @IBOutlet weak var randomButton: UIButton!
    var color = UIColor()
    override func viewDidLoad() {
        super.viewDidLoad()

        color = furnitureButton.backgroundColor!

        // Do any additional setup after loading the view.
    }
    
    @IBAction func distanceSlider(sender: AnyObject) {
        NSUserDefaults.standardUserDefaults().setObject(distanceSlider.value, forKey: "distance")
        NSUserDefaults.standardUserDefaults().synchronize()
        distanceValue.text = "\(distanceSlider.value) miles"

    }
    @IBAction func priceSlider(sender: AnyObject) {
        NSUserDefaults.standardUserDefaults().setObject(priceSlider.value, forKey: "price")
        NSUserDefaults.standardUserDefaults().synchronize()
        priceValue.text = "$\(priceSlider.value)"

    }
    override func viewWillAppear(animated: Bool) {
        if NSUserDefaults.standardUserDefaults().objectForKey("furniture") as Int == 1 {
            furnitureButton.tag = 1
            furnitureButton.backgroundColor = UIColor.grayColor()
        } else {
            furnitureButton.tag = 0
            furnitureButton.backgroundColor = color
        }
        if NSUserDefaults.standardUserDefaults().objectForKey("appliances") as Int == 1 {
            applianceButton.tag = 1
            applianceButton.backgroundColor = UIColor.grayColor()
        } else {
            applianceButton.tag = 0
            applianceButton.backgroundColor = color
        }
        if NSUserDefaults.standardUserDefaults().objectForKey("books") as Int == 1 {
            bookButton.tag = 1
            bookButton.backgroundColor = UIColor.grayColor()
        } else {
            bookButton.tag = 0
            bookButton.backgroundColor = color
        }
        if NSUserDefaults.standardUserDefaults().objectForKey("electronics") as Int == 1 {
            electronicsButton.tag = 1
            electronicsButton.backgroundColor = UIColor.grayColor()
        } else {
            electronicsButton.tag = 0
            electronicsButton.backgroundColor = color
        }
        if NSUserDefaults.standardUserDefaults().objectForKey("rentals") as Int == 1 {
            rentalsButton.tag = 1
            rentalsButton.backgroundColor = UIColor.grayColor()
        } else {
            rentalsButton.tag = 0
            rentalsButton.backgroundColor = color
        }
        if NSUserDefaults.standardUserDefaults().objectForKey("tickets") as Int == 1 {
            ticketsButton.tag = 1
            ticketsButton.backgroundColor = UIColor.grayColor()
        } else {
            ticketsButton.tag = 0
            ticketsButton.backgroundColor = color
        }
        if NSUserDefaults.standardUserDefaults().objectForKey("clothing") as Int == 1 {
            clothingButton.tag = 1
            clothingButton.backgroundColor = UIColor.grayColor()
        } else {
            clothingButton.tag = 0
            clothingButton.backgroundColor = color
        }
        if NSUserDefaults.standardUserDefaults().objectForKey("random") as Int == 1 {
            randomButton.tag = 1
            randomButton.backgroundColor = UIColor.grayColor()
        } else {
            randomButton.tag = 0
            randomButton.backgroundColor = color
        }
        
        if NSUserDefaults.standardUserDefaults().objectForKey("price")  != nil {
            priceSlider.value = NSUserDefaults.standardUserDefaults().objectForKey("price") as Float
            priceValue.text = "$\(priceSlider.value)"
        }
        if NSUserDefaults.standardUserDefaults().objectForKey("distance") != nil {
            distanceSlider.value = NSUserDefaults.standardUserDefaults().objectForKey("distance") as Float
            distanceValue.text = "\(distanceSlider.value) miles"
        }
    }

    @IBAction func furniturePress(sender: AnyObject) {
        if furnitureButton.tag == 1 {
            furnitureButton.backgroundColor = color
            furnitureButton.tag = 0
            NSUserDefaults.standardUserDefaults().setObject(0, forKey: "furniture")
        } else {
            furnitureButton.backgroundColor = UIColor.grayColor()
            furnitureButton.tag = 1
            NSUserDefaults.standardUserDefaults().setObject(1, forKey: "furniture")

        }
        NSUserDefaults.standardUserDefaults().synchronize()

    }
    @IBAction func appliancePress(sender: AnyObject) {
        if applianceButton.tag == 1 {
            applianceButton.backgroundColor = color
            applianceButton.tag = 0
            NSUserDefaults.standardUserDefaults().setObject(0, forKey: "appliances")

        } else {
            applianceButton.backgroundColor = UIColor.grayColor()
            applianceButton.tag = 1
            NSUserDefaults.standardUserDefaults().setObject(1, forKey: "appliances")

        }
        NSUserDefaults.standardUserDefaults().synchronize()

    }
    @IBAction func bookPress(sender: AnyObject) {
        if bookButton.tag == 1 {
            bookButton.backgroundColor = color
            bookButton.tag = 0
            NSUserDefaults.standardUserDefaults().setObject(0, forKey: "books")

        } else {
            bookButton.backgroundColor = UIColor.grayColor()
            bookButton.tag = 1
            NSUserDefaults.standardUserDefaults().setObject(1, forKey: "books")

        }
        NSUserDefaults.standardUserDefaults().synchronize()

    }
    @IBAction func electronicsPress(sender: AnyObject) {
        if electronicsButton.tag == 1 {
            electronicsButton.backgroundColor = color
            electronicsButton.tag = 0
            NSUserDefaults.standardUserDefaults().setObject(0, forKey: "electronics")

        } else {
            electronicsButton.backgroundColor = UIColor.grayColor()
            electronicsButton.tag = 1
            NSUserDefaults.standardUserDefaults().setObject(1, forKey: "electronics")

        }
        NSUserDefaults.standardUserDefaults().synchronize()

    }
    @IBAction func rentalsPress(sender: AnyObject) {
        if rentalsButton.tag == 1 {
            rentalsButton.backgroundColor = color
            rentalsButton.tag = 0
            NSUserDefaults.standardUserDefaults().setObject(0, forKey: "rentals")

        } else {
            rentalsButton.backgroundColor = UIColor.grayColor()
            rentalsButton.tag = 1
            NSUserDefaults.standardUserDefaults().setObject(1, forKey: "rentals")
        }
        NSUserDefaults.standardUserDefaults().synchronize()

    }
    @IBAction func ticketsPress(sender: AnyObject) {
        if ticketsButton.tag == 1 {
            ticketsButton.backgroundColor = color
            ticketsButton.tag = 0
            NSUserDefaults.standardUserDefaults().setObject(0, forKey: "tickets")

        } else {
            ticketsButton.backgroundColor = UIColor.grayColor()
            ticketsButton.tag = 1
            NSUserDefaults.standardUserDefaults().setObject(1, forKey: "tickets")

        }
        NSUserDefaults.standardUserDefaults().synchronize()

    }
    @IBAction func clothingPress(sender: AnyObject) {
        if clothingButton.tag == 1 {
            clothingButton.backgroundColor = color
            clothingButton.tag = 0
            NSUserDefaults.standardUserDefaults().setObject(0, forKey: "clothing")

        } else {
            clothingButton.backgroundColor = UIColor.grayColor()
            clothingButton.tag = 1
            NSUserDefaults.standardUserDefaults().setObject(1, forKey: "clothing")

        }
        NSUserDefaults.standardUserDefaults().synchronize()

    }
    @IBAction func randomPress(sender: AnyObject) {
        if randomButton.tag == 1 {
            randomButton.backgroundColor = color
            randomButton.tag = 0
            NSUserDefaults.standardUserDefaults().setObject(0, forKey: "random")

        } else {
            randomButton.backgroundColor = UIColor.grayColor()
            randomButton.tag = 1
            NSUserDefaults.standardUserDefaults().setObject(1, forKey: "random")

        }
        NSUserDefaults.standardUserDefaults().synchronize()

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

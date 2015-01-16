//
//  SecondViewController.swift
//  mrkt-beta
//
//  Created by Andy Hadjigeorgiou on 11/30/14.
//  Copyright (c) 2014 vigme. All rights reserved.
//

import UIKit
import MobileCoreServices

class SecondViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, APIPostProductProtocol {
    
    var cancel = 0
    var photoChosen = 0
    var image_url_base = "http://s3-us-west-2.amazonaws.com/vigme/"
    var final_image_url = ""
    var transferRequest = AWSS3TransferManagerUploadRequest()
    var ready = 0

    @IBOutlet weak var furnitureButton: UIButton!
    @IBOutlet weak var applianceButton: UIButton!
    @IBOutlet weak var bookButton: UIButton!
    @IBOutlet weak var electronicsButton: UIButton!
    @IBOutlet weak var rentalsButton: UIButton!
    @IBOutlet weak var takePhoto: UIButton!
    @IBOutlet weak var ticketsButton: UIButton!
    @IBOutlet weak var clothingButton: UIButton!
    @IBOutlet weak var randomButton: UIButton!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var postProduct: UIButton!
    @IBOutlet weak var price: UITextField!
    @IBOutlet weak var info: UITextField!
    @IBOutlet weak var viewTitle: UILabel!
    @IBOutlet weak var dollarSign: UILabel!
    @IBOutlet weak var successLabel: UILabel!
    var color = UIColor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        api.delegatePostProduct = self
        self.price.hidden = true
        self.info.hidden = true
        self.name.hidden = true
        self.furnitureButton.hidden = true
        self.applianceButton.hidden = true
        self.bookButton.hidden = true
        self.electronicsButton.hidden = true
        self.rentalsButton.hidden = true
        self.ticketsButton.hidden = true
        self.clothingButton.hidden = true
        self.randomButton.hidden = true
        self.dollarSign.hidden = true
        self.postProduct.hidden = true
        self.viewTitle.hidden = true
        self.takePhoto.hidden = false
        self.successLabel.hidden = true
        color = furnitureButton.backgroundColor!

    }
    @IBAction func furniturePress(sender: AnyObject) {
        if furnitureButton.tag == 1 {
            furnitureButton.backgroundColor = color
            furnitureButton.tag = 0
        } else {
            furnitureButton.backgroundColor = UIColor.grayColor()
            furnitureButton.tag = 1
        }
    }
    @IBAction func appliancePress(sender: AnyObject) {
        if applianceButton.tag == 1 {
            applianceButton.backgroundColor = color
            applianceButton.tag = 0
        } else {
            applianceButton.backgroundColor = UIColor.grayColor()
            applianceButton.tag = 1
        }
    }
    @IBAction func bookPress(sender: AnyObject) {
        if bookButton.tag == 1 {
            bookButton.backgroundColor = color
            bookButton.tag = 0
        } else {
            bookButton.backgroundColor = UIColor.grayColor()
            bookButton.tag = 1
        }
    }
    @IBAction func electronicsPress(sender: AnyObject) {
        if electronicsButton.tag == 1 {
            electronicsButton.backgroundColor = color
            electronicsButton.tag = 0
        } else {
            electronicsButton.backgroundColor = UIColor.grayColor()
            electronicsButton.tag = 1
        }
    }
    @IBAction func rentalsPress(sender: AnyObject) {
        if rentalsButton.tag == 1 {
            rentalsButton.backgroundColor = color
            rentalsButton.tag = 0
        } else {
            rentalsButton.backgroundColor = UIColor.grayColor()
            rentalsButton.tag = 1
        }
    }
    @IBAction func ticketsPress(sender: AnyObject) {
        if ticketsButton.tag == 1 {
            ticketsButton.backgroundColor = color
            ticketsButton.tag = 0
        } else {
            ticketsButton.backgroundColor = UIColor.grayColor()
            ticketsButton.tag = 1
        }
    }
    @IBAction func clothingPress(sender: AnyObject) {
        if clothingButton.tag == 1 {
            clothingButton.backgroundColor = color
            clothingButton.tag = 0
        } else {
            clothingButton.backgroundColor = UIColor.grayColor()
            clothingButton.tag = 1
        }
    }
    @IBAction func randomPress(sender: AnyObject) {
        if randomButton.tag == 1 {
            randomButton.backgroundColor = color
            randomButton.tag = 0
        } else {
            randomButton.backgroundColor = UIColor.grayColor()
            randomButton.tag = 1
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        //textField.resignFirstResponder
        return true
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    override func viewWillAppear(animated: Bool) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) && cancel == 0 && photoChosen == 0 {
            println("Button capture")
            
            var imag = UIImagePickerController()
            imag.delegate = self
            imag.sourceType = UIImagePickerControllerSourceType.Camera;
            imag.mediaTypes = NSArray(object: kUTTypeImage)
            imag.allowsEditing = false
            
            self.presentViewController(imag, animated: true, completion: {
                Void in
                self.takePhoto.hidden = true
                self.price.hidden = false
                self.info.hidden = false
                self.name.hidden = false
                self.furnitureButton.hidden = false
                self.applianceButton.hidden = false
                self.bookButton.hidden = false
                self.electronicsButton.hidden = false
                self.rentalsButton.hidden = false
                self.ticketsButton.hidden = false
                self.clothingButton.hidden = false
                self.randomButton.hidden = false
                self.viewTitle.hidden = false
                self.dollarSign.hidden = false
                self.postProduct.hidden = false
                self.successLabel.hidden = true
            })

        }
        if photoChosen == 1 {
            dispatch_async(dispatch_get_main_queue()) {

            self.takePhoto.hidden = true
            self.price.hidden = false
            self.info.hidden = false
            self.name.hidden = false
            self.furnitureButton.hidden = false
            self.furnitureButton.tag = 0
            self.furnitureButton.backgroundColor = self.color
            self.applianceButton.hidden = false
            self.applianceButton.tag = 0
            self.applianceButton.backgroundColor = self.color
            self.bookButton.hidden = false
            self.bookButton.tag = 0
            self.bookButton.backgroundColor = self.color
            self.electronicsButton.hidden = false
            self.electronicsButton.tag = 0
            self.electronicsButton.backgroundColor = self.color
            self.rentalsButton.hidden = false
            self.rentalsButton.tag = 0
            self.rentalsButton.backgroundColor = self.color
            self.ticketsButton.hidden = false
            self.ticketsButton.tag = 0
            self.ticketsButton.backgroundColor = self.color
            self.clothingButton.hidden = false
            self.clothingButton.tag = 0
            self.clothingButton.backgroundColor = self.color
            self.randomButton.hidden = false
            self.randomButton.tag = 0
            self.randomButton.backgroundColor = self.color
            self.viewTitle.hidden = false
            self.dollarSign.hidden = false
            self.postProduct.hidden = false
            self.successLabel.hidden = true
            }
        }
        photoChosen = 0
        cancel = 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func postProduct(sender: AnyObject) {
        var price_text = price.text
        var info_text = info.text
        var name_text = name.text
        self.price.text = ""
        self.info.text = ""
        self.name.text = ""
        self.price.hidden = true
        self.info.hidden = true
        self.name.hidden = true
        self.furnitureButton.hidden = true
        self.applianceButton.hidden = true
        self.bookButton.hidden = true
        self.electronicsButton.hidden = true
        self.rentalsButton.hidden = true
        self.ticketsButton.hidden = true
        self.clothingButton.hidden = true
        self.randomButton.hidden = true
        self.dollarSign.hidden = true
        self.postProduct.hidden = true
        self.viewTitle.hidden = true
        self.takePhoto.hidden = false
        self.successLabel.hidden = false
        var params_str = NSMutableArray()
        if furnitureButton.tag == 1 {
            params_str.addObject("furniture")
        }
        if applianceButton.tag == 1 {
            params_str.addObject("appliances")
        }
        if electronicsButton.tag == 1 {
            params_str.addObject("electronics")
        }
        if bookButton.tag == 1 {
            params_str.addObject("books")
        }
        if rentalsButton.tag == 1 {
            params_str.addObject("rentals")
        }
        if ticketsButton.tag == 1 {
            params_str.addObject("tickets")
        }
        if clothingButton.tag == 1 {
            params_str.addObject("clothing")
        }
        if randomButton.tag == 1 {
            params_str.addObject("random")
        }
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {

        while self.ready != 1 {
            var timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("update"), userInfo: nil, repeats: false)
        }
        if self.ready == 1 {
            println("finally")
        
            api.postProduct(self.final_image_url, price: price_text, info: info_text, name: name_text, params: params_str as NSMutableArray)

        }
        self.ready = 0
        })
    }
    
    func update() {
        
    }
    
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
       // profile.image=image

        UIGraphicsBeginImageContextWithOptions(image.size, false, image.scale)
        image.drawInRect(CGRectMake(0, 0, image.size.width, image.size.height))
        var normalizedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        var newSize:CGSize = CGSize(width: 300,height: 300)
        normalizedImage = RBSquareImageTo(normalizedImage, size: newSize)!
        getPathAndUploadToS3(normalizedImage)
        photoChosen = 1
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func takePhoto(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) && cancel == 0 {
            println("Button capture")
            
            var imag = UIImagePickerController()
            imag.delegate = self
            imag.sourceType = UIImagePickerControllerSourceType.Camera;
            imag.mediaTypes = NSArray(object: kUTTypeImage)
            imag.allowsEditing = false
            
            self.presentViewController(imag, animated: true, completion: {
                 Void in
                self.takePhoto.hidden = true
                self.price.hidden = false
                self.info.hidden = false
                self.name.hidden = false
                self.viewTitle.hidden = false
                self.dollarSign.hidden = false
                self.postProduct.hidden = false
                self.successLabel.hidden = true
            })

        }
        
    }
    
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        cancel = 1
        price.hidden = true
        info.hidden = true
        self.name.hidden = true
        viewTitle.hidden = true
        dollarSign.hidden = true
        postProduct.hidden = true
        takePhoto.hidden = false
        successLabel.hidden = true
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func getPathAndUploadToS3(image: UIImage) {
        
        transferRequest = AWSS3TransferManagerUploadRequest()
        var manager = AWSS3TransferManager.defaultS3TransferManager()
        var path: NSArray = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        var directory_string: String = path.objectAtIndex(0) as String
        var path_string: String = directory_string.stringByAppendingPathComponent((NSUserDefaults.standardUserDefaults().objectForKey("object_id")! as String) + ".jpg")
        var data = UIImagePNGRepresentation(image)
        data.writeToFile(path_string, atomically: true)
        let selectedImage: UIImage = image
        var image_url: NSURL = NSURL.fileURLWithPath(path_string)!
        transferRequest.body = image_url
        transferRequest.contentType = "image/jpg"
        transferRequest.contentLength = 20000000
        transferRequest.bucket = "vigme"
        transferRequest.key = "mrkt/" + (NSUserDefaults.standardUserDefaults().objectForKey("object_id")! as String) + ".jpg"
        manager.upload(transferRequest).continueWithBlock({ (task) -> AnyObject! in
            if (task.error != nil) {
                if( task.error.code != AWSS3TransferManagerErrorType.Paused.hashValue
                    &&
                    task.error.code != AWSS3TransferManagerErrorType.Cancelled.hashValue
                    )
                {
                    //failed
                    println("failed")
                }
            } else {
                //completed
                println("completed")
                self.ready = 1
            }
            return nil
        })
        final_image_url = image_url_base + transferRequest.key as String
        
        println(final_image_url)
    }

    func RBSquareImageTo(image: UIImage, size: CGSize) -> UIImage? {
        return RBResizeImage(RBSquareImage(image), targetSize: size)
    }
    
    func RBSquareImage(image: UIImage) -> UIImage? {
        var originalWidth  = image.size.width
        var originalHeight = image.size.height
        
        var edge: CGFloat
        if originalWidth > originalHeight {
            edge = originalHeight
        } else {
            edge = originalWidth
        }
        
        var posX = (originalWidth  - edge) / 2.0
        var posY = (originalHeight - edge) / 2.0
        
        var cropSquare = CGRectMake(posX, posY, edge, edge)
        
        var imageRef = CGImageCreateWithImageInRect(image.CGImage, cropSquare);
        return UIImage(CGImage: imageRef, scale: UIScreen.mainScreen().scale, orientation: image.imageOrientation)
    }
    
    func RBResizeImage(image: UIImage?, targetSize: CGSize) -> UIImage? {
        if let image = image {
            let size = image.size
            
            let widthRatio  = targetSize.width  / image.size.width
            let heightRatio = targetSize.height / image.size.height
            
            // Figure out what our orientation is, and use that to form the rectangle
            var newSize: CGSize
            if(widthRatio > heightRatio) {
                newSize = CGSizeMake(size.width * heightRatio, size.height * heightRatio)
            } else {
                newSize = CGSizeMake(size.width * widthRatio,  size.height * widthRatio)
            }
            
            // This is the rect that we've calculated out and this is what is actually used below
            let rect = CGRectMake(0, 0, newSize.width, newSize.height)
            
            // Actually do the resizing to the rect using the ImageContext stuff
            UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
            image.drawInRect(rect)
            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            return newImage
        } else {
            return nil
        }
    }

}


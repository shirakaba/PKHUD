//
//  DemoViewController.swift
//  PKHUD Demo
//
//  Created by Philip Kluz on 6/18/14.
//  Copyright (c) 2016 NSExceptional. All rights reserved.
//

import UIKit
import PKHUD

class DemoViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        HUD.allowsInteraction = false
    }

    //pure without title and subtitle
    
    @IBAction func showSuccessHUD(sender: AnyObject) {
        HUD.flash(.Success, delay: 2.0)
    }
    
    @IBAction func showErrorHUD(sender: AnyObject) {
        HUD.flash(.Error, delay: 2.0)
    }
    
    @IBAction func showProgressHUD(sender: AnyObject) {
        HUD.flash(.Progress, delay: 2.0)
    }
    
    @IBAction func showImageHUD(sender: AnyObject) {
        HUD.flash(.Image(PKHUDAssets.checkmarkImage), delay: 2.0)
    }
    
    @IBAction func showRotatingImageHUD(sender: AnyObject) {
        HUD.flash(.RotatingImage(PKHUDAssets.checkmarkImage), delay: 2.0)
    }
    
    
    //with title and subtitle
    
    @IBAction func showLabeledSuccessHUD(sender: AnyObject) {
        HUD.flash(.LabeledSuccess(title: "Title", subtitle: "Subtitle"), delay: 2.0)
    }
    
    @IBAction func showLabeledErrorHUD(sender: AnyObject) {
        HUD.flash(.LabeledError(title: "Title", subtitle: "Subtitle"), delay: 2.0)
    }
    
    @IBAction func showLabeledProgressHUD(sender: AnyObject) {
        HUD.flash(.LabeledProgress(title: "Title", subtitle: "Subtitle"), delay: 2.0)
    }
    
    @IBAction func showLabeledImageHUD(sender: AnyObject) {
        HUD.flash(.LabeledImage(image: PKHUDAssets.checkmarkImage, title: "Title", subtitle: "Subtitle"), delay: 2.0)
    }
    
    @IBAction func showLabeledRotatingImageHUD(sender: AnyObject) {
        HUD.flash(.LabeledRotatingImage(image: PKHUDAssets.checkmarkImage, title: "Title", subtitle: "Subtitle"), delay: 2.0)
    }
    
    
    //other
    
    @IBAction func showLabelHUD(sender: AnyObject) {
        HUD.flash(.Label("Label"), delay: 2.0)
    }
    
    @IBAction func showSystemActivityHUD(sender: AnyObject) {
        HUD.flash(.SystemActivity, delay: 2.0)
    }
    
    
    //mixed
    
    @IBAction func showProgressThenSuccessHUD(sender: AnyObject) {
        HUD.show(.Progress)
        
        // Now some long running task starts...
        delay(2.0) {
            // ...and once it finishes we flash the HUD for a second.
            HUD.flash(.Success, delay: 1.0)
        }
    }
    
    @IBAction func showTextWithCompletionHUD(sender: AnyObject) {
        HUD.flash(.Label("Requesting Licence…"), delay: 2.0) { _ in
            print("License Obtained.")
        }
    }
    
    /*
    
    Please note that the above demonstrates the "porcelain" interface - a more concise and clean way to work with the HUD.
    If you need more options and flexbility, feel free to use the underlying "plumbing". E.g.:
    
    PKHUD.sharedHUD.show()
    PKHUD.sharedHUD.contentView = PKHUDSuccessView(title: "Success!", subtitle: nil)
    PKHUD.sharedHUD.hide(afterDelay: 2.0)
    */
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.AllButUpsideDown
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
}

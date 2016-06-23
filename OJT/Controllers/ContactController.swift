//
//  ContactController.swift
//  OJT
//
//  Created by Robin van Brakel on 02/06/16.
//  Copyright © 2016 Rob Hendriks. All rights reserved.
//

import UIKit

class ContactController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Contact"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnGeneral(sender: AnyObject) {
        callToAction()
    }
    
    @IBAction func btnEmergency(sender: AnyObject) {
        callToAction()
    }
    
    @IBAction func btnBus(sender: AnyObject) {
        callToAction()
    }
    
    @IBAction func btnDocter(sender: AnyObject) {
        callToAction()
    }
    
    @IBAction func btnLeaders(sender: AnyObject) {
        callToAction()
    }
    
    func callToAction(){
        UIApplication.sharedApplication().openURL(NSURL(string:"tel:0123456789")!)
    }
}

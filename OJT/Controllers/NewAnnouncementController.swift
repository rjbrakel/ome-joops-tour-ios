//
//  messageController.swift
//  OJT
//
//  Created by Kevin Hoogendam on 19/06/16.
//  Copyright © 2016 Rob Hendriks. All rights reserved.
//

import UIKit
import SwiftyJSON

class NewAnnouncementController : UIViewController {
    
    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var bodyText: UITextView!
    
    override func viewDidLoad() {
        
        titleText.layer.borderWidth = 1
        titleText.layer.borderColor = UIColor.lightGrayColor().CGColor
        bodyText.layer.borderWidth = 1
        bodyText.layer.borderColor = UIColor.lightGrayColor().CGColor
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(NewAnnouncementController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func sendAnnouncement(sender: AnyObject) {
        let title = titleText.text!
        let body = bodyText.text!
        if(title == "" || body == "")
        {
            self.showAlert("ongeldige input", "Voer aub alle velden in")
        }
        else
        {
            postAnnouncement(title, body: body)
            
            let AnnouncementsListView = self.storyboard?.instantiateViewControllerWithIdentifier("AnnouncementsList")
            self.navigationController?.pushViewController(AnnouncementsListView!, animated: true)
        }
    }
    
    private func postAnnouncement(title: String, body: String) {
        print("test")
        AnnouncementListService.post(title, body: body){ error in
            dispatch_async(dispatch_get_main_queue()) {
                if error == nil {
                    print("Succesfully posted")
                }
                else{
                    print(error)
                }
            }
        }
        
    }
}
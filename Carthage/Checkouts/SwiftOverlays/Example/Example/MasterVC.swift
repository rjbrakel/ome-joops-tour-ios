//
//  MasterViewController.swift
//  Example
//
//  Created by Peter Prokop on 17/10/14.
//
//

import UIKit

class MasterVC: UITableViewController {

    var exampleDescriptions = ["Wait overlay",
        "Wait overlay with text",
        "Overlay with text only",
        "Image and text overlay",
        "Progress",
        "Annoying notification on top",
        "Blocking wait overlay",
        "Blocking wait overlay with text",
    ]
    
    var types: Array<OverlayExampleVC.ExampleType> = [
        .Wait,
        .WaitWithText,
        .TextOnly,
        .ImageAndText,
        .Progress,
        .AnnoyingNotification,
        .BlockingWait,
        .BlockingWaitWithText
    ]

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showOverlayExample" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let type = types[indexPath.row]
                (segue.destinationViewController as! OverlayExampleVC).type = type
                (segue.destinationViewController ).title = exampleDescriptions[indexPath.row]
            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exampleDescriptions.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        let exampleDescription = exampleDescriptions[indexPath.row]
        
        cell.textLabel?.text = exampleDescription
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        self.performSegueWithIdentifier("showOverlayExample", sender: nil)
    }

}


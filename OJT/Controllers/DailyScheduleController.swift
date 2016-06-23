//
//  DailyScheduleController
//  OJT
//
//  Created by Robin van Brakel on 18/05/16.
//  Copyright © 2016 Robin van Brakel. All rights reserved.
//

import UIKit
import SwiftOverlays

class DailyScheduleController : UITableViewController {
    
    var barButtonItem: UIBarButtonItem?
    
    var itemList : DailySchedule?
    var selectedScheduleId: String?
    var selectedTarget: Contact?
    
    var working: Bool = false {
        didSet {
            updateUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        fetchEvents()
    }
    
    private func configure() {
        navigationItem.title = "Dag onderdelen"
        
        refreshControl = UIRefreshControl()
        refreshControl!.addTarget(self, action: #selector(SchedulesController.fetchEvents), forControlEvents: .ValueChanged)
    }
    
    func fetchEvents() {
        if !working {
            working = true
            DailyScheduleService.get(selectedScheduleId!, callback: { dailySchedule, error in
                dispatch_async(dispatch_get_main_queue()) {
                    self.working = false;
                    self.itemList = dailySchedule
                    self.tableView.reloadData()
                    self.refreshControl?.endRefreshing()
                }});
        }
    }
    
    private func updateUI() {
        if working {
            barButtonItem = navigationItem.rightBarButtonItem
            
            let indicator = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
            indicator.startAnimating()
            
            navigationItem.rightBarButtonItem = UIBarButtonItem(customView: indicator)
        } else {
            navigationItem.rightBarButtonItem = barButtonItem
            barButtonItem = nil
        }
    }
    
    @IBAction func tapRefresh(sender: AnyObject) {
        fetchEvents()
    }
    
    // MARK: - Table View
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList?.items.count ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        let item = itemList?.items[indexPath.row]
        cell.textLabel?.text = item?.name
        cell.detailTextLabel?.text = "\(String(item!.points)) punten"
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if let item = itemList?.items[indexPath.row] {
            working = true
            self.selectedTarget!.updateScore(.Add, Float(item.points)) { value, error in
                dispatch_async(dispatch_get_main_queue()) {
                    self.working = false
                    self.performSegueWithIdentifier("ShowNewRanking", sender: self)
                }
            }
        }
    }
    
    // MARK: - Segues
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

    }
    
    private func updateScore(indexPath: NSIndexPath, _ operation: Operation, _ amount: Float) {
        working = true
       
    }
    
}

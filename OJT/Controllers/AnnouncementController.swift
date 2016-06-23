//
//  AnnouncementController.swift
//  OJT
//
//  Created by Robin van Brakel on 05/06/16.
//  Copyright © 2016 Rob Hendriks. All rights reserved.
//

import UIKit

class AnnouncementController: UITableViewController {
    
    var barButtonItem: UIBarButtonItem?
    var announcements = [Announcement]()
    
    var working: Bool = false {
        didSet {
            updateUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Mededelingen"
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableViewAutomaticDimension
        configure()
        fetchAnnouncements()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func configure() {
        refreshControl = UIRefreshControl()
        refreshControl!.addTarget(self, action: #selector(AnnouncementController.fetchAnnouncements), forControlEvents: .ValueChanged)
    }
    
    func fetchAnnouncements() {
        if !working {
            working = true
            AnnouncementListService.current { announcements, error in
                dispatch_async(dispatch_get_main_queue()) {
                    self.working = false
                    if(announcements != nil)
                    {
                        self.announcements = announcements!
                    }
                    self.tableView.reloadData()
                    self.refreshControl?.endRefreshing()
                }
            }
        }
    }
    
    private func updateUI() {
        if working {
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        } else {
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return announcements.count ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("announcementCell", forIndexPath: indexPath) as! AnnouncementCell
        
        let item = announcements[indexPath.row] as Announcement
        cell.lblAuthor.text = "\(item.author)"
        cell.lblDate.text = item.date?.shortDateString
        cell.lblTitle.text = "\(item.title)"
        cell.lblMessage.text = item.message
        return cell
    }
    
}

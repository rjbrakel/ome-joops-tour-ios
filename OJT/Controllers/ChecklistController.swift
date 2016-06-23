//
//  ChecklistController.swift
//  OJT
//
//  Created by Robin van Brakel on 31/05/16.
//  Copyright © 2016 Rob Hendriks. All rights reserved.
//

import UIKit

class ChecklistController: UITableViewController {
    
    var tasks = [Task]()
    let defaults = NSUserDefaults.standardUserDefaults()
    let key = "ChecklistKey"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Checklist";
        populate()
        self.tableView.reloadData()
    }
    
    func populate(){
        let taskData = defaults.objectForKey(key) as? NSData
        if let taskData = taskData {
            let taskArray = NSKeyedUnarchiver.unarchiveObjectWithData(taskData)
            
            if let taskArray = taskArray {
                tasks = taskArray as! [Task]
            }
        }
        
        if tasks.count == 0 {
            tasks.append(Task(name: "Inschrijven voor Ome Joops Tour", state: true))
            tasks.append(Task(name: "Fiets laten keuren", state: false))
            tasks.append(Task(name: "Banden laten oppompen", state: false))
            tasks.append(Task(name: "Snoepjes meenemen", state: false))
            tasks.append(Task(name: "Fiets repareerset meenemen", state: false))
            
            saveData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ChecklistCell", forIndexPath: indexPath) as! ChecklistCell
        let task = tasks[indexPath.row]
        
        cell.lblName.text = task.name
        cell.imageState.hidden = !task.state ? true : false

        return cell
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let task = tasks[indexPath.row]
        task.state = !task.state ? true : false
        saveData()
        self.tableView.reloadData()
    }
    
    func saveData(){
        let data = NSKeyedArchiver.archivedDataWithRootObject(tasks)
        defaults.setObject(data, forKey: key)
    }
}

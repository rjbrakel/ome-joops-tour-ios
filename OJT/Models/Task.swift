//
//  Task.swift
//  OJT
//
//  Created by Robin van Brakel on 31/05/16.
//  Copyright © 2016 Rob Hendriks. All rights reserved.
//

import Foundation

class Task : NSObject {
    var state : Bool
    var name : String
    
    init(name: String, state: Bool) {
        self.state = state
        self.name = name
    }
    
    required init(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObjectForKey("name") as! String
        self.state = aDecoder.decodeObjectForKey("state") as! Bool
    }
    
    func encodeWithCoder(aCoder: NSCoder!) {
        aCoder.encodeObject(name, forKey: "name")
        aCoder.encodeObject(state, forKey: "state")
    }
}
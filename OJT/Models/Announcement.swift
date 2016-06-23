//
//  Announcement.swift
//  OJT
//
//  Created by Robin van Brakel on 31/05/16.
//  Copyright © 2016 Rob Hendriks. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Announcement : NSObject {
    
    var title : String
    var message : String
    var author : String
    var date : NSDate?
    
    init(_ json: JSON) {
        
        self.title = json["title"].stringValue
        self.message = json["body"].stringValue
        self.author = json["author"]["contact"]["name"].stringValue
        self.date = NSDate.fromISOString(json["created"].stringValue)
    }
}

class AnnouncementListService {
    static func current(callback: ([Announcement]?, NSError?) -> Void) {
        Requests.manager.request(Router.AnnouncementsByPage(0))
            .validate()
            .responseData { response in
                switch response.result {
                case .Failure(let error):
                    callback(nil, error)
                case .Success(let value):
                    
                    let json = JSON(data: value)
                    var announcements = [Announcement]()
                    
                    for item in json["items"].arrayValue {
                        announcements.append(Announcement(item))
                    }
                    
                    callback(announcements, nil)
                }
        }
    }
 
    static func post(title: String, body: String, callback: (NSError?) -> Void) {
        let request = Router.NewAnnouncement().URLRequest
        var data: NSData?
        do {
            try data = NSJSONSerialization.dataWithJSONObject(["title" : title, "body": body], options: .PrettyPrinted)
        } catch let err as NSError {
            return callback(err)
        }
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = data
        
        Requests.manager.request(request)
            .validate()
            .responseData { response in
                switch response.result {
                case .Failure(let error):
                    callback(error)
                case .Success:
                    callback(nil)
                }
        }
    }
    
}
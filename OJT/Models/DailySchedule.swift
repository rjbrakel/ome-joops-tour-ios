//
//  DailySchedule
//  OJT
//
//  Created by Rob Hendriks on 13/05/16.
//  Copyright © 2016 Rob Hendriks. All rights reserved.
//

import Alamofire
import SwiftyJSON

struct DailySchedule {
    let items: [DailyItem]
    
    init(_ json: JSON) {
        var items = [DailyItem]()
        for item in json["items"].arrayValue {
            items.append(DailyItem(item))
        }
        self.items = items;
    }
}

struct DailyItem {
    let name: String
    let points: Int
    
    init(_ json: JSON) {
        name = json["name"].stringValue
        points = json["points"].intValue
    }
}

class DailyScheduleService {
    
    static func get(scheduleId: String , callback: (DailySchedule?, NSError?) -> Void) {
        Requests.manager.request(Router.DailySchedule(scheduleId))
            .validate()
            .responseData { response in
                switch response.result {
                case .Failure(let error):
                    callback(nil, error)
                case .Success(let value):
                    let json = JSON(data: value)
                    let dailySchedule = DailySchedule(json)
                    callback(dailySchedule, nil)
                }
        }
    }
}
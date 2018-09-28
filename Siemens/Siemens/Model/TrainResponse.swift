//
//  TrainResponse.swift
//  Siemens
//
//  Created by Ahmet Erpulat on 27.09.2018.
//  Copyright © 2018 enqura. All rights reserved.
//

import UIKit
import SwiftyJSON

class TrainResponse {
    var areaCode: String?
    var name: String?
    var appr: Int?
    var started: Int?
    var wmatl: Int?
    var wsch: Int?
    var inprg: Int?
    init(fromDictionary: JSON) {
        self.areaCode = fromDictionary["areaCode"].string
        self.name = fromDictionary["name"].string
    }
    init(){
        
    }
}

extension TrainResponse {
    class func parseData(_ fromJSON: SwiftyJSON.JSON) -> TrainResponse? {
        return TrainResponse(fromDictionary: fromJSON)
    }
}

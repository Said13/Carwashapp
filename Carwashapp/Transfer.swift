//
//  Transfer.swift
//  Carwashapp
//
//  Created by Abdullah on 26.01.17.
//  Copyright © 2017 Abdullah. All rights reserved.
//

import Foundation
import ObjectMapper


class Transfer: Mappable {
    
    var distance: String?
    var duration: String?
    
    required init?(map: Map) {
        
    }
    
    init(distance: String, duration: String) {
        self.distance = distance
        self.duration = duration
    }
    
    func mapping(map: Map) {
        distance <- map["rows.elements.distance"]
        duration <- map["rows.elements.duration"]
    }
    
}

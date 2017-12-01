//
//  Carwash.swift
//  Carwashapp
//
//  Created by Abdullah on 25.01.17.
//  Copyright © 2017 Abdullah. All rights reserved.
//

import Foundation
import ObjectMapper


class Carwash : Mappable{
    
    var id: Int?
    var name: String?
    var coordinate_latitude: String?
    var coordinate_longitude: String?
    var address: String?
    var distance: String?
    var imagePath: String?
    var mainImage: UIImage?
    var phone: String?
    var website: String?
    var dayandnight: String?
    var till:String?
    
    required init?(map: Map) {
        
    }
    
    init(id: Int, name: String, coordinate_latitude: String, coordinate_longitude: String, address: String, imagePath: String, phone: String, website: String,dayandnight: String, till: String ) {
        self.id = id
        self.name = name
        self.coordinate_latitude = coordinate_latitude
        self.coordinate_longitude = coordinate_longitude
        self.address = address
        self.imagePath = imagePath
        self.phone = phone
        self.website = website
        self.dayandnight = dayandnight
        self.till = till
    }
    // Mark : Mappable
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        coordinate_latitude <- map["coordinate_latitude"]
        coordinate_longitude <- map["coordinate_longitude"]
        address <- map["address"]
        imagePath <- map["imagepath"]
        phone <- map["phone"]
        website <- map["website"]
        dayandnight <- map["dayandnight"]
        till <- map["till"]
    }
    
    //let carwash : Carwash? = Mapper<Carwash>().map(JSONString: carwashJson)
    //let carwashes : [Carwash]? = Mapper<Carwash>().mapArray(JSONString: carwashJson)
    
    
}

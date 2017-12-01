//
//  NearestPlaceViewController.swift
//  Carwashapp
//
//  Created by Abdullah on 13.02.17.
//  Copyright © 2017 Abdullah. All rights reserved.
//

import UIKit
import CoreLocation

class NearestPlaceViewController: UIViewController, UITableViewDelegate,  CLLocationManagerDelegate{

    let locationManager = CLLocationManager()

    let currentTime = Date()
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var dayandnightLabel: UILabel!
    
    var allCarwashes: [Carwash] = []
    var first_place_got = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ServerManager.getCarwashes { (carwashes, error) in
            if error != nil {
                return
            }
            guard let myCarwashes = carwashes else {
                return
            }
            self.allCarwashes = myCarwashes
            SingleTone.shareInstance.carwash = self.allCarwashes
        }
        if let myCarwashesFromList = SingleTone.shareInstance.carwash {
            self.allCarwashes = myCarwashesFromList
        }
        
        //запрос на разрешение геолокации
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
                    }
    
    func sort_distance() {
        if CLLocationManager.locationServicesEnabled() {
            var empty = true
            var index = 0
            let currentHour = Calendar.current.component(.hour, from: currentTime)
            let currentMinute = Calendar.current.component(.minute, from: currentTime)

            for carwash in allCarwashes{
                if ((carwash.distance != nil) && (carwash.till != nil)) {
                    empty = false
                }
//                let dateString = "Thu, 22 Oct 2015 07:45:17 +0000"
//                let dateFormatter = DateFormatter()
//                dateFormatter.dateFormat = "EEE, dd MMM yyyy hh:mm:ss +zzzz"
//                dateFormatter.locale = Locale.init(identifier: "en_GB")
//                
//                let dateObj = dateFormatter.date(from: dateString)
//                
//                dateFormatter.dateFormat = "MM-dd-yyyy"
//                print("Dateobj: \(dateFormatter.string(from: dateObj!))")
                
                guard let dateString = carwash.till else { return }
//                print ("string " + dateString)
                
                let dateFormatter = DateFormatter()

                dateFormatter.dateFormat = "HH:mm:ss"

                guard let dateObj = dateFormatter.date(from: dateString) else { return }
                

//                print(dateFormatter.string(from: dateObj))
                let hour = Calendar.current.component(.hour, from: dateObj)
                let minute = Calendar.current.component(.minute, from: dateObj)
                var inTime = true
                
//                print("hour " , hour)
                if (currentHour < hour) {
                    inTime = true
                } else if (currentHour == hour && currentMinute < minute) {
                    inTime = true
                } else { inTime = false }
//                print(inTime)
//                print(carwash.dayandnight)
                
                if ((carwash.dayandnight != "true" && !inTime )){
                    allCarwashes.remove(at: index)
//                    print("index = " , index)
                }
                index += 1
            }
            //сортировка по расстаянию
            if !empty {
                allCarwashes.sort { $0.distance! < $1.distance! }
            }
            
            
            guard let distance = allCarwashes.first?.distance,
                let name = allCarwashes.first?.name,
                let address = allCarwashes.first?.address,
                let dayandnight = allCarwashes.first?.dayandnight
            else {
                print("failed")
                return
            }
            
            nameLabel.text = name
            addressLabel.text = address
            distanceLabel.text = distance + " km"
            if (dayandnight == "true") {
                dayandnightLabel.text = ""
            }
        }

    }
    // Mark : CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let myLocation = locations.last
        if !first_place_got {

            for carwash in allCarwashes {
                let dest_lat = carwash.coordinate_latitude
                let dest_lon = carwash.coordinate_longitude
                guard   let destination_lat = dest_lat,
                        let destination_lon = dest_lon
                    else {
                        return
                }
                let latitute = Double((destination_lat as NSString) as String)
                let longitute = Double((destination_lon as NSString) as String)
                
                let placeLocation = CLLocation(latitude: latitute!, longitude: longitute!)
                let d = (myLocation!.distance(from: placeLocation)) / 1000//ПОМЕНЯТЬ НА 1000
                
                carwash.distance = Double(round(10*d)/10).description
                }
            if (allCarwashes.count != 0)  {
                self.sort_distance()
                first_place_got = true
                locationManager.stopUpdatingLocation()
            }
        }
    }
}

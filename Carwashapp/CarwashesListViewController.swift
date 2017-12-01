//
//  CarwashesListViewController.swift
//  Carwashapp
//
//  Created by Abdullah on 25.01.17.
//  Copyright © 2017 Abdullah. All rights reserved.
//

import UIKit
import CoreLocation
import ChameleonFramework

class CarwashesListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,  CLLocationManagerDelegate{

    let locationManager = CLLocationManager()
    
    let redColor = UIColor(red: 255/255, green: 0, blue:   102/255, alpha: 1)
    let purpleColor = UIColor(red: 33/255, green: 0, blue:   33/255, alpha: 1)

    
    @IBOutlet weak var carwashesTableView: UITableView!
    var allCarwashes: [Carwash] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationController?.navigationBar.barTintColor = purpleColor
        navigationController?.navigationBar.tintColor = UIColor.flatWhite
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.flatWhite]

        carwashesTableView.dataSource = self
//        ServerManager.getCarwashes { (carwashes, error) in
//            if error != nil {
//             return
//            }
//            guard let myCarwashes = carwashes else {
//                return
//            }
//            self.allCarwashes = myCarwashes
//            SingleTone.shareInstance.carwash = self.allCarwashes
//            self.carwashesTableView.reloadData()
//        }
        if let myCarwashesFromList = SingleTone.shareInstance.carwash {
            self.allCarwashes = myCarwashesFromList
            carwashesTableView.reloadData()
            print(allCarwashes.count)

            
        } else {

            
            ServerManager.getCarwashes { (carwashes, error) in
                if error != nil {
                    return
                }
                guard let myCarwashes = carwashes else {
                    return
                }
                self.allCarwashes = myCarwashes
                self.carwashesTableView.reloadData()
            }
        }
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            
            allCarwashes.sort { $0.distance! < $1.distance! }

        }
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? CarwashCell{
        if let PlaceMenu = segue.destination as? CarwashScreenViewController {
            PlaceMenu.currentCarwash = cell.carwash
            }
        }
    }
    
    
    // Mark : CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let myLocation = locations.last
        
        for carwash in allCarwashes {
            let dest_lat = carwash.coordinate_latitude
            let dest_lon = carwash.coordinate_longitude
            
            let latitude_opt = myLocation?.coordinate.latitude.description

            let longitude_opt = myLocation?.coordinate.longitude.description

            guard let latitude = latitude_opt,
                let longitude = longitude_opt,
                let destination_lat = dest_lat,
                let destination_lon = dest_lon
            else {
                    return 
            }
            //let lat1 : NSString = latitude as NSString
            //let lng1 : NSString = longitude as NSString
            
            let latitute = Double((destination_lat as NSString) as String)
            let longitute = Double((destination_lon as NSString) as String)
            //let placeLocation = CLLocation(latitude: latitute!, longitude: longitute!)
            let placeLocation = CLLocation(latitude: latitute!, longitude: longitute!)
            let d = (myLocation!.distance(from: placeLocation)) / 1000//ПОМЕНЯТЬ НА 1000
            
            carwash.distance = Double(round(10*d)/10).description //+ myAttrString.description
            //print(carwash.distance)
            carwashesTableView.reloadData()
            }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.allCarwashes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "carwashCell",for: indexPath) as? CarwashCell {
            let carwash = allCarwashes[indexPath.row]
            cell.nameLabel.text = carwash.name
            cell.distanceLabel.text = carwash.distance
            cell.addressLabel.text = carwash.address
            cell.carwash = carwash
            //cell.downloadImage(carwash.imagePath!)
            //print("cell ready for return")
            
            return cell
        }
        return UITableViewCell()
    }
    

}

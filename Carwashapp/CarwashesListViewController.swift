//
//  CarwashesListViewController.swift
//  Carwashapp
//
//  Created by Abdullah on 25.01.17.
//  Copyright © 2017 Abdullah. All rights reserved.
//

import UIKit
import CoreLocation

class CarwashesListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,  CLLocationManagerDelegate{

    let locationManager = CLLocationManager()
    
    @IBOutlet weak var carwashesTableView: UITableView!
    var allCarwashes: [Carwash] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationController?.navigationBar.barTintColor = UIColor.flatSkyBlue
        navigationController?.navigationBar.tintColor = UIColor.flatWhite
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.flatWhite]

        carwashesTableView.dataSource = self
        ServerManager.getCarwashes { (carwashes, error) in
            if error != nil {
             return
            }
            guard let myCarwashes = carwashes else {
                return
            }
            self.allCarwashes = myCarwashes
            SingleTone.shareInstance.carwash = self.allCarwashes
            self.carwashesTableView.reloadData()
        }
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
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
        /*
        // update only if user moved more than on 100
        if firstLocation || lastLocation.distance(from: myLocation!) > 100 {
            for place in self.places{
                guard let placeLatitude = place.latitude,
                    let placeLongitute = place.longitude else {
                        return
                }
                let lat1 : NSString = placeLatitude as NSString
                let lng1 : NSString = placeLongitute as NSString
                
                let latitute: CLLocationDegrees = lat1.doubleValue
                let longitute: CLLocationDegrees = lng1.doubleValue
                let placeLocation = CLLocation(latitude: latitute, longitude: longitute)
                let d = myLocation!.distance(from: placeLocation) / 1000
                place.distance = Double(round(10*d)/10)
                
                firstLocation = false
                
            }
            guard let myLoc = myLocation else { return }
            lastLocation = myLoc
            tableView.reloadData()
        }*/
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
            //let km = " km."
            //let myAttribute = [ NSFontAttributeName: UIFont(name: "System", size: 12.0)! ]
            //let myAttrString = NSAttributedString(string: km, attributes: myAttribute)
            
            carwash.distance = Double(round(10*d)/10).description //+ myAttrString.description
            
            carwashesTableView.reloadData()
            

            /*ServerManager.getTransferInfo(latitude: latitude, longitude: longitude, dest: destination, completion: { (transfer, error) in
                if error != nil {
                    return
                } else {
                    carwash.destination = transfer?.distance
                    carwash.duration = transfer?.duration
                    self.carwashesTableView.reloadData()
                }
            })*/
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

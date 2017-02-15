//
//  MapViewController.swift
//  Carwashapp
//
//  Created by Abdullah on 30.01.17.
//  Copyright © 2017 Abdullah. All rights reserved.
//

import UIKit
import GoogleMaps
import ChameleonFramework

class MapViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate {
    
    let locationManager = CLLocationManager()
    
    var allCarwashes: [Carwash] = []
    
    var firstLocation = false
    
//    var mapView:GMSMapView!
    @IBOutlet weak var mapView: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        mapView.isMyLocationEnabled = true

    
        
        print("1")
        navigationController?.navigationBar.barTintColor = UIColor.flatSkyBlue
        navigationController?.navigationBar.tintColor = UIColor.flatWhite
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.flatWhite]
        //print("2")
        
        if let myCarwashesFromList = SingleTone.shareInstance.carwash {
            self.allCarwashes = myCarwashesFromList
            drawPlaces()
            print(allCarwashes.count)
            print("3")

        } else {
            print("4")

            ServerManager.getCarwashes { (carwashes, error) in
                if error != nil {
                    return
                }
                guard let myCarwashes = carwashes else {
                    return
                }
                self.allCarwashes = myCarwashes
                self.drawPlaces()
            }
        }
        
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        //self.view = mapView
    }
    
    func drawPlaces() {
        
        for carwash in allCarwashes {
                let position = CLLocationCoordinate2DMake(Double(carwash.coordinate_latitude!)!, Double(carwash.coordinate_longitude!)!)
                //let position = CLLocationCoordinate2DMake((Double(carwash.coordinate_latitude!)!), (Double(carwash.coordinate_longitude!)!))
                let placeMarker = GMSMarker(position: position)
                
                placeMarker.title = carwash.name
                placeMarker.snippet = carwash.address
                placeMarker.map = mapView
            
            }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        
        if !firstLocation {
            if let myLocation = mapView.myLocation {
                let cameraPosition = GMSCameraPosition.camera(withLatitude: (myLocation.coordinate.latitude), longitude: (myLocation.coordinate.longitude), zoom: 15)
                mapView.animate(to: cameraPosition)
                firstLocation = true
            }
        }
        

        
        if let myLocation = locations.last{
//            let cameraPosition = GMSCameraPosition.camera(withLatitude: (myLocation.coordinate.latitude), longitude: (myLocation.coordinate.longitude), zoom: 15)
//            mapView = GMSMapView.map(withFrame: CGRect.zero, camera:cameraPosition)
            let myposition = CLLocationCoordinate2DMake(Double(myLocation.coordinate.latitude), Double(myLocation.coordinate.longitude))
            let placeMarker = GMSMarker(position: myposition)
            
            placeMarker.title = "You are here"
            placeMarker.map = mapView
        }
    }
}

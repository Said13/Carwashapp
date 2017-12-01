//
//  CarwashScreen.swift
//  Carwashapp
//
//  Created by Abdullah on 28.01.17.
//  Copyright © 2017 Abdullah. All rights reserved.
//

import Foundation
import UIKit

class CarwashScreenViewController: UIViewController {
    @IBOutlet weak var carwashImage: UIImageView!
    @IBOutlet weak var carwashName: UILabel!
    @IBOutlet weak var carwashAddress: UILabel!
    @IBOutlet weak var carwashDistance: UILabel!
    @IBOutlet weak var carwashPhone: UILabel!
    @IBOutlet weak var carwashWebsite: UILabel!
    @IBOutlet weak var openClosed: UILabel!
    
    let currentTime = Date()

    


    var currentCarwash: Carwash?
    override func viewDidLoad() {
        super.viewDidLoad()
//        if let path = currentCarwash?.imagePath {
//        ServerManager.downloadImage(url: path) { (image, error) in
//            if error != nil {
//                return
//            }
//            self.carwashImage.image = image
//            }
//        }
        
        carwashName.text = currentCarwash?.name
        carwashDistance.text = currentCarwash?.distance
        carwashAddress.text = currentCarwash?.address
        carwashPhone.text = currentCarwash?.phone
        carwashWebsite.text = currentCarwash?.website
        let currentHour = Calendar.current.component(.hour, from: currentTime)
        let currentMinute = Calendar.current.component(.minute, from: currentTime)
        
        guard let dateString = currentCarwash?.till else { return }
        //                print ("string " + dateString)
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "HH:mm:ss"
        
        guard let dateObj = dateFormatter.date(from: dateString) else { return }
        
        
        //                print(dateFormatter.string(from: dateObj))
        let hour = Calendar.current.component(.hour, from: dateObj)
        let minute = Calendar.current.component(.minute, from: dateObj)
        
        //                print("hour " , hour)
        guard let dayandnight = currentCarwash?.dayandnight else {
            return
        }
        if (dayandnight == "true")  {
            openClosed.text = "The carwash is currently open."
        } else if (currentHour < hour) {
                openClosed.text = "The carwash is currently open."
        } else if (currentHour == hour && currentMinute < minute) {
openClosed.text = "The carwash is currently open."
        } else { openClosed.text = "The carwash is currently closed." }
        

        
        
    }
    
    

}

//
//  CarwashCell.swift
//  Carwashapp
//
//  Created by Abdullah on 25.01.17.
//  Copyright © 2017 Abdullah. All rights reserved.
//

import Foundation
import UIKit
import ChameleonFramework


class CarwashCell: UITableViewCell{
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var carwashImage: UIImageView!
    
    
    
    
    var carwash: Carwash?
    // async photo downloading
    func downloadImage(_ url : String) {
        ServerManager.downloadImage(url: url) { (imageOpt, error) in
            if error != nil {
                print(error) 
                return
            }
            guard let image = imageOpt else {
                return
            }
            /*self.placePhoto = imageOpt
            self.place.image = imageOpt
            DispatchQueue.main.async {
                self.placeImage.image = image*/
            //}
            self.carwashImage.image = image
            
        }
    }
    
}

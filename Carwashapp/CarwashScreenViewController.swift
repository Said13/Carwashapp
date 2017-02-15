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
    
    var currentCarwash: Carwash?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let path = currentCarwash?.imagePath {
        ServerManager.downloadImage(url: path) { (image, error) in
            if error != nil {
                return
            }
            self.carwashImage.image = image
            }
        }
        
        carwashName.text = currentCarwash?.name
        carwashAddress.text = currentCarwash?.address
        
    }
    
    

}

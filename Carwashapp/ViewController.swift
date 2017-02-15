//
//  ViewController.swift
//  Carwashapp
//
//  Created by Abdullah on 25.01.17.
//  Copyright © 2017 Abdullah. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        myLabel.text = "Welcome to CarwashApp!"
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func pressedButton(_ sender: Any) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }

}


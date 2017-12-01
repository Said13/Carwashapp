//
//  PhoneNumberCheckViewController.swift
//  Carwashapp
//
//  Created by Abdullah on 04.04.17.
//  Copyright © 2017 Abdullah. All rights reserved.
//

import UIKit

class PhoneNumberCheckViewController: UIViewController {

    @IBOutlet weak var PopUpView: UIView!
    @IBOutlet weak var nextButtonView: UIView!
    @IBOutlet weak var phoneNumberField: UITextField!
    //var phoneNumber: String?
    
    
    @IBAction func PopUpClose(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextButtonAction(_ sender: Any) {
        
        //phoneNumber = phoneNumberField.text
        print()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PopUpView.layer.cornerRadius = 10
        PopUpView.layer.masksToBounds = true
        PopUpView.layer.borderWidth = 1
        PopUpView.layer.borderColor = UIColor(red:222/255.0, green:225/255.0, blue:227/255.0, alpha: 1.0).cgColor
        nextButtonView.layer.cornerRadius = 5
        nextButtonView.layer.masksToBounds = true
        // Do any additional setup after loading the view.
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  ServerManager.swift
//  Carwashapp
//
//  Created by Abdullah on 25.01.17.
//  Copyright © 2017 Abdullah. All rights reserved.
//
import Foundation
import Alamofire
import ObjectMapper
import AlamofireImage

//let base_url: String = "https://psadsd-heroku-96979.herokuapp.com"
let base_url: String = "http://localhost:8080"
let dest_url: String = "https://maps.googleapis.com/maps/api/distancematrix/json?origins="


class ServerManager {
    
    static let dateFormatter = DateFormatter() // for converting Dates to string
    
    // general request to the API, each function here will use this one
    static func send(api: String, method: HTTPMethod, parameters: Parameters?, completion: @escaping (_ result: String?, _ error: NSError?)->()) -> Void {
        
        let headers = [
            "Content-Type": "application/json; charset=utf-8",
            "Accept": "application/json",
            ]

        let url = (base_url + api) as URLConvertible

        Alamofire.request(url, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .validate()
            .responseString { response in
        switch response.result {
        case .success:
            completion(response.result.value, nil)
        case .failure(let error):
            completion(nil, error as NSError?)
                }
        }
    }




    // getting the list of Places from API
    static func getCarwashes(completion: @escaping (_ places: Array<Carwash>?, _ error : NSError?) -> () ) {
    
    
        func response_completion( _ response_result: String? , response_error: NSError? ) -> Void {
            if response_error != nil {
                completion(nil, response_error)
                return
            }
            
            guard let carwashJson = response_result else {
                return
            }
            //print(carwashJson)
            
            let carwashes : [Carwash]? = Mapper<Carwash>().mapArray(JSONString: carwashJson)
            
            //print(carwashes)
            //for c in carwashes!{ print(c.id) }
            
            completion(carwashes, nil)
        }
    
        send(api: "/carwashes", method: .get, parameters: nil, completion: response_completion )
        print("boom")
    }
    
    //Transfer information
    
    
    static func sendTransfer(latitude: String, longitude: String, dest: String , completion: @escaping (_ result: String?, _ error: NSError?)->()) -> Void {
        
        let headers = [
            "Content-Type": "application/json; charset=utf-8",
            "Accept": "application/json",
            ]
        
        let url = ("https://maps.googleapis.com/maps/api/distancematrix/json?origins=\(latitude),%\(longitude)&destinations=\(dest)&mode=driving&language=ru-RU&key=AIzaSyBFpI5an_BZmnUKeoBGox5oC8U4fp5c4Bw") as URLConvertible
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers)
            .validate()
            .responseString { response in
                switch response.result {
                case .success:
                    completion(response.result.value, nil)
                case .failure(let error):
                    completion(nil, error as NSError?)
                }
                print(url)
        }
    }
    
    static func getTransferInfo(latitude: String, longitude: String, dest: String, completion: @escaping (_ places: Transfer?, _ error : NSError?) -> () ) {
        
        
        func response_completion( _ response_result: String? , response_error: NSError? ) -> Void {
            if response_error != nil {
                completion(nil, response_error)
                return
            }
            
            guard let transferJson = response_result else {
                return
            }
            print(transferJson)
            
            let transfers : Transfer? = Mapper<Transfer>().map(JSONString: transferJson)
            
            print()
            //for c in carwashes!{ print(c.id) }
            
            completion(transfers, nil)
        }
        
        sendTransfer(latitude: latitude, longitude: longitude, dest: dest, completion: response_completion)
        //print("boom")
    }
    
    static func downloadImage(url : String, completion: @escaping (_ image: UIImage? , _ error: NSError?) -> () ) {
        Alamofire.request(url).responseImage { (response) -> Void in
            guard let image = response.result.value else {
                completion(nil, response.result.error as NSError?)
                return
            }
            completion(image, nil)
        }
    }

}

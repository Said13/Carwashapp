//
//  SingleTone.swift
//  Carwashapp
//
//  Created by Abdullah on 31.01.17.
//  Copyright © 2017 Abdullah. All rights reserved.
//

import Foundation

class SingleTone : NSObject {
    
    fileprivate override init(){}
    
    static let shareInstance = SingleTone()

    var carwash: [Carwash]?
}

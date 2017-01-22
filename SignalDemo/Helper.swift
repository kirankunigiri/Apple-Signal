//
//  Helper.swift
//  SignalDemo
//
//  Created by Kiran Kunigiri on 1/22/17.
//  Copyright © 2017 Kiran. All rights reserved.
//

import Foundation

enum DataType: UInt {
    case string = 100
    case image = 101
}

class DataContainer {
    
    var type: Int!
    var object: Any!
    
    init(type: Int, object: Any) {
        self.type = type
        self.object = object
    }
    
}

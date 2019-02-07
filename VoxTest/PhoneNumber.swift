//
//  PhoneNumber.swift
//  VoxTest
//
//  Created by Josh Motley on 9/16/18.
//  Copyright © 2018 Motley. All rights reserved.
//

import UIKit
import Vox

class PhoneNumber: Resource {
    
    @objc dynamic
    var state: String?
    
    @objc dynamic
    var number: String?
    
    @objc dynamic
    var nationalNumber: String?
    
    @objc dynamic
    var city: String?
    
    override class var resourceType: String {
        return "number"
    }
}

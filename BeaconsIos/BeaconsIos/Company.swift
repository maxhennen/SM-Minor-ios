//
//  Company.swift
//  BeaconsIos
//
//  Created by Max Hennen on 10/12/2019.
//  Copyright © 2019 Max Hennen. All rights reserved.
//

import Foundation
import CoreLocation

class Company {
    
    var id: Int
    var name: String
    var website: NSURL
    var subject: Subject
    var description: String
    
    init(id: Int, name: String, website: NSURL, subject: Subject, description: String){
        self.id = id
        self.name = name
        self.website = website
        self.subject = subject
        self.description = description
    }
}

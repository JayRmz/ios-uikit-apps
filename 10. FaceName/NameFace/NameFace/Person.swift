//
//  Person.swift
//  NameFace
//
//  Created by Juan Ramírez Blancas on 27/04/24.
//

import UIKit

class Person: NSObject {
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}

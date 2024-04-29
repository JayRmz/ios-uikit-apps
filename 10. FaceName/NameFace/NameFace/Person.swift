//
//  Person.swift
//  NameFace
//
//  Created by Juan Ramírez Blancas on 27/04/24.
//

import UIKit

class Person: NSObject, Codable {
    
    var name: String
    var image: String
    
    
    required init(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: "name") as? String ?? ""
        image = aDecoder.decodeObject(forKey: "image") as? String ?? ""
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(image, forKey: "image")
    }
    

    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}

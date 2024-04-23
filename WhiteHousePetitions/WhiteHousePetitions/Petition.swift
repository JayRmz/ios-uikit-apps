//
//  Petition.swift
//  WhiteHousePetitions
//
//  Created by Juan Ramírez Blancas on 22/04/24.
//

import Foundation
struct Petition: Codable {
    var title: String
    var body: String
    var signatureCount: Int
}

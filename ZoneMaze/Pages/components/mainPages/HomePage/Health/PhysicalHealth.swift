//
//  PhysicalHealth.swift
//  ZoneMaze
//
//  Created by Ali AI on 2/24/24.
//

import Foundation

struct PhysicalHealth: Hashable, Encodable, Decodable {
    var id = UUID().uuidString
    var question: String
    var checked: Bool
}

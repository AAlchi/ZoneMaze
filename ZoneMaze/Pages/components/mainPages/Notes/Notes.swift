//
//  Item.swift
//  ZoneMaze
//
//  Created by Ali Alchikh Ibrahim on 9/14/23.
//

import SwiftUI

struct Item: Hashable, Encodable, Decodable {
    var id = UUID().uuidString
    var title: String
    var description: String  
}
 

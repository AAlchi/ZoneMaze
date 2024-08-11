//
//  Item.swift
//  ZoneMaze
//
//  Created by Ali Alchikh Ibrahim on 9/14/23.
//

import SwiftUI

struct ScheduleItem: Hashable, Encodable, Decodable {
    var id = UUID().uuidString
    var scheduleTitle: String
    var scheduleDate: String
} 

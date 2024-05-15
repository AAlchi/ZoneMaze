//
//  DailySchedule.swift
//  ZoneMaze
//
//  Created by Ali AI on 2/16/24.
//

import Foundation

struct ScheduleScheduleItem: Hashable, Encodable, Decodable {
    var id = UUID().uuidString
    var scheduleTitle: String
    var scheduleDate: Date
    var theActualDay: String
    var isScheduled: Bool
}

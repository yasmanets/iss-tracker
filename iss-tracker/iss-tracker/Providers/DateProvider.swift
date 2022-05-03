//
//  DateProvider.swift
//  iss-tracker
//
//  Created by Yaser El Dabete Arribas on 1/5/22.
//

import Foundation

class DateProvider {
    
    static func timestampToDate(timestamp: Double) -> Date {
        let date = Date(timeIntervalSince1970: timestamp)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "EEEE d MMMM yyyy HH:mm"
        let stringifyDate = dateFormatter.string(from: date)
        return dateFormatter.date(from: stringifyDate)!
    }
    
    static func timestampToSplitedDate(timestamp: Double) -> [String] {
        let date = Date(timeIntervalSince1970: timestamp)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "EEEE d MMMM yyyy HH:mm"
        return dateFormatter.string(from: date).components(separatedBy: " ")
    }
    
    static func secondsToMinutesSeconds(seconds: Int) -> (Int, Int) {
        return ((seconds % 3600) / 60, (seconds % 3600) % 60)
    }
}

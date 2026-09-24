//
//  Date+Extensions.swift
//  wooryMeal
//
//  Created by Hyun on 9/24/26.
//

import Foundation

extension Date {
    /// Gives week days include today
    static var currentWeek: [Date] {
        let calender = Calendar.current
        guard let firstWeekDay = calender.dateInterval(of: .weekOfMonth, for: .now)?.start else {
            return []
        }
        
        var week: [Date] = []
        for index in 0..<7{
            if let day = calender.date(byAdding: .day, value: index, to: firstWeekDay) {
                week.append(day)
            }
        }
        
        return week
    }
    
    /// Convert date to string in the given format
    func string(_ format:String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        
        return formatter.string(from: self)
    }
    
    /// Check if both dates are same
    func isSame(_ date:Date?) -> Bool {
        guard let date else { return false }
        return Calendar.current.isDate(self, inSameDayAs: date)
    }
}

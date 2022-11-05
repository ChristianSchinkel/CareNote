//
//  Date+Extension.swift
//  CareNote
//
//  Created by Christian Schinkel on 2022-11-04.
//

import Foundation

extension Date {
    /// Adding time-interval (two weeks) to a given date
    /// - Parameter referenceDate: The date references to and adding to a time-interval.
    /// - Returns: The date two weeks from the referring-date e.g. Date.now -> two weeks later.
    static func TwoWeeksLater(from referenceDate: Date) -> Date {
        let twoWeeksInSeconds = 60 * 60 * 24 * 14
        return referenceDate.addingTimeInterval(TimeInterval(twoWeeksInSeconds))
    }
}

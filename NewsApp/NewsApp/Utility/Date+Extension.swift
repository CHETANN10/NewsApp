//
//  Date+Extension.swift
//  NewsApp
//
//  Created by Chetan N on 23/07/24.
//

import Foundation

extension Date {
    func toMonthYearString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        return dateFormatter.string(from: self)
    }
}

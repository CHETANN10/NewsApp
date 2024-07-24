//
//  String+Extension.swift
//  NewsApp
//
//  Created by Chetan N on 23/07/24.
//

import Foundation


extension String {
    
    func getDateFromString() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter.date(from: self)
    }
}


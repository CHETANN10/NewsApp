//
//  NewsModel.swift
//  NewsApp
//
//  Created by Chetan N on 23/07/24.
//

import Foundation

// Model required for our app
struct NewsModel: Equatable {
    let headLine: String?
    let description: String?
    let imageUrl: String?
    let date: Date?
}

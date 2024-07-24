//
//  NewsResponseModel.swift
//  NewsApp
//
//  Created by Chetan N on 23/07/24.
//

import Foundation

//API response model
struct NewsResponseModel: Codable {
    let status: String
    let response: ResponseData?
}


struct ResponseData: Codable {
    let docs: [Docs]?
}

struct Docs: Codable {
    let abstract: String?
    let headline: Headline?
    let multimedia: [Multimedia]?
    let pub_date: String?
}

struct Headline: Codable {
    let main: String?
}


struct Multimedia: Codable {
    let url: String?
}

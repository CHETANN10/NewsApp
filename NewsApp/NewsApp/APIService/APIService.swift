//
//  APIService.swift
//  NewsApp
//
//  Created by Chetan N on 23/07/24.
//

import Foundation

enum NewsFetchError: Error {
    case networkError
    case decodingError
    case httpError(Int)
}

class APIService {

    func fetchNews<T: Codable>(fromUrl: URL) async throws -> (T?)  {
        let urlRequest = URLRequest(url: fromUrl)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NewsFetchError.networkError
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NewsFetchError.httpError(httpResponse.statusCode)
        }
                
        let decodedData = try JSONDecoder().decode(T.self, from: data)
        return decodedData
    }
}

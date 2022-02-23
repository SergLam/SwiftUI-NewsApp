//
//  RestApiConstants.swift
//  NewsApp
//
//  Created by Serhii Liamtsev on 2/23/22.
//  Copyright © 2022 Serhii Liamtsev. All rights reserved.
//

import Foundation

struct RestApiConstants {
    // News  API key url: https://newsapi.org
    static let apiKey: String = "dad56f872c6e425f8992c93c87060824"//"API_KEY"
    
    static let jsonDecoder: JSONDecoder = {
     let jsonDecoder = JSONDecoder()
     jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
     let dateFormatter = DateFormatter()
     dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
     jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
      return jsonDecoder
    }()
    
     static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
}

//
//  NewsResponseJSON.swift
//  NewsApp
//
//  Created by Serhii Liamtsev on 2/22/22.
//  Copyright © 2022 Serhii Liamtsev. All rights reserved.
//

import Foundation

struct NewsResponseJSON: Codable {
    
    let status: String?
    let totalResults: Int?
    let articles: [ArticleJSON]
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case totalResults = "totalResults"
        case articles = "articles"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        status = try container.decodeIfPresentForce(String.self, forKey: .status)
        totalResults = try container.decodeIfPresentForce(Int.self, forKey: .totalResults)
        articles = try container.decode([ArticleJSON].self, forKey: .articles)
    }
}

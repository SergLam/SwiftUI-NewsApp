//
//  ArticleJSON.swift
//  NewsApp
//
//  Created by Tatiana Kornilova on 17/12/2019.
//  Copyright © 2019 Tatiana Kornilova. All rights reserved.
//

import Foundation

struct ArticleJSON: Codable, Identifiable {
    
    let id = UUID()
    let title: String
    let description: String?
    let author: String?
    let urlToImage: String?
    let publishedAt: Date?
    let source: SourceJSON
    let url: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case description = "description"
        case author = "author"
        case urlToImage = "urlToImage"
        case publishedAt = "publishedAt"
        case source = "source"
        case url = "url"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decodeForce(String.self, forKey: .title)
        description = try container.decodeIfPresentForce(String.self, forKey: .description)
        author = try container.decodeIfPresentForce(String.self, forKey: .author)
        urlToImage = try container.decodeIfPresentForce(String.self, forKey: .urlToImage)
        publishedAt = try container.decodeIfPresent(Date.self, forKey: .publishedAt)
        source = try container.decode(SourceJSON.self, forKey: .source)
        url = try container.decodeIfPresentForce(String.self, forKey: .url)
    }
    
    init(title: String,
         description: String?,
         author: String?,
         urlToImage: String?,
         publishedAt: Date?,
         source: SourceJSON,
         url: String?) {
        self.title = title
        self.description = description
        self.author = author
        self.urlToImage = urlToImage
        self.publishedAt = publishedAt
        self.source = source
        self.url = url
    }
}

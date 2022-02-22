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
}

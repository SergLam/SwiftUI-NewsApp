//
//  SourceJSON.swift
//  NewsApp
//
//  Created by Serhii Liamtsev on 2/22/22.
//  Copyright © 2022 Serhii Liamtsev. All rights reserved.
//

import Foundation

struct SourceJSON: Codable, Identifiable {
    
    let id: String?
    let name: String?
    let description: String?
    let country: String?
    let category: String?
    let url: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case description = "description"
        case country = "country"
        case category = "category"
        case url = "url"
    }
    
    
}

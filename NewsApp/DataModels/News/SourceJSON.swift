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
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresentForce(String.self, forKey: .id)
        name = try container.decodeIfPresentForce(String.self, forKey: .name)
        description = try container.decodeIfPresentForce(String.self, forKey: .description)
        country = try container.decodeIfPresentForce(String.self, forKey: .country)
        category = try container.decodeIfPresentForce(String.self, forKey: .category)
        url = try container.decodeIfPresentForce(String.self, forKey: .url)
    }
    
    init(id: String?,
         name: String?,
         description: String?,
         country: String?,
         category: String?,
         url: String?) {
        self.id = id
        self.name = name
        self.description = description
        self.country = country
        self.category = category
        self.url = url
    }
}

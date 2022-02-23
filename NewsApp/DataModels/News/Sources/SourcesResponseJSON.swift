//
//  SourcesResponseJSON.swift
//  NewsApp
//
//  Created by Serhii Liamtsev on 2/22/22.
//  Copyright © 2022 Serhii Liamtsev. All rights reserved.
//

import Foundation

struct SourcesResponseJSON: Codable {
    let status: String
    let sources: [SourceJSON]
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case sources = "sources"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        status = try container.decodeForce(String.self, forKey: .status)
        sources = try container.decode([SourceJSON].self, forKey: .sources)
    }
}

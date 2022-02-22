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
}

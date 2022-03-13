//
//  URLQueryItem+Ext.swift
//  NewsApp
//
//  Created by Serhii Liamtsev on 3/13/22.
//  Copyright © 2022 Serhii Liamtsev. All rights reserved.
//

import Foundation

extension URLQueryItem {
    
    var dictionary: [String: String?] {
        return [name: value]
    }
}

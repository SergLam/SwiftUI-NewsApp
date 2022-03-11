//
//  LocalizedStrings.swift
//  NewsApp
//
//  Created by Serhii Liamtsev on 3/11/22.
//  Copyright © 2022 Serhii Liamtsev. All rights reserved.
//

import Foundation

struct LocalizedStrings {
    
    // NOTE: - Change bundle, if you would like to have language change in runtime
    static var stringsBundle: Bundle {
        return Bundle.main
    }
    
    static var articleSearchDefaultText: String {
        return NSLocalizedString("articles.search.default-text", tableName: nil, bundle: stringsBundle, value: "", comment: "Articles search screen - default text for search field")
    }
    
}

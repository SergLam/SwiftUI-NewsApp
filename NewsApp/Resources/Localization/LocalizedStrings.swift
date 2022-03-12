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
    
    // MARK: - General
    static var okButtonTitle: String {
        return NSLocalizedString("ok.button-title", tableName: nil, bundle: stringsBundle, value: "", comment: "OK button title")
    }
    
    static var searchFieldPlaceholder: String {
        return NSLocalizedString("search.field-placeholder", tableName: nil, bundle: stringsBundle, value: "", comment: "Search text field placeholder")
    }
    
    // MARK: - Articles
    
    static var articleSearchDefaultText: String {
        return NSLocalizedString("articles.search.default-text", tableName: nil, bundle: stringsBundle, value: "", comment: "Articles search screen - default text for search field")
    }
    
    static var articlesCategoriesFromCategory: String {
        return NSLocalizedString("articles.categories.from-category", tableName: nil, bundle: stringsBundle, value: "", comment: "Articles search screen - from category tab.")
    }
    
    static var articlesCategoriesTopHeadlines: String {
        return NSLocalizedString("articles.categories.top-headlines", tableName: nil, bundle: stringsBundle, value: "", comment: "Articles search screen - top headlines category tab")
    }
    
    static var articlesCategoriesDefaultSearchText: String {
        return NSLocalizedString("articles.categories.default-search-text", tableName: nil, bundle: stringsBundle, value: "", comment: "Articles search screen - default search text.")
    }
    
    // MARK: - Articles categories
    
    static var articlesCategorySports: String {
        return NSLocalizedString("articles.category-sports", tableName: nil, bundle: stringsBundle, value: "", comment: "Articles search screen - from category tab - \"sports\" sub-tab.")
    }
    
    static var articlesCategoryHealth: String {
        return NSLocalizedString("articles.category-health", tableName: nil, bundle: stringsBundle, value: "", comment: "Articles search screen - from category tab - \"health\" sub-tab.")
    }
    
    static var articlesCategoryScience: String {
        return NSLocalizedString("articles.category-science", tableName: nil, bundle: stringsBundle, value: "", comment: "Articles search screen - from category tab - \"science\" sub-tab.")
    }
    
    static var articlesCategoryBusiness: String {
        return NSLocalizedString("articles.category-business", tableName: nil, bundle: stringsBundle, value: "", comment: "Articles search screen - from category tab - \"business\" sub-tab.")
    }
    
    static var articlesCategoryTechnology: String {
        return NSLocalizedString("articles.category-technology", tableName: nil, bundle: stringsBundle, value: "", comment: "Articles search screen - from category tab - \"technology\" sub-tab.")
    }
    
    // MARK: - Errors
    
    static var errorNetworkErrorAlertTitle: String {
        return NSLocalizedString("error.network-error.alert-title", tableName: nil, bundle: stringsBundle, value: "", comment: "Alert title for network error.")
    }
}

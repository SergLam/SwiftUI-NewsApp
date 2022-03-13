//
//  Endpoint.swift
//  NewsApp
//
//  Created by Serhii Liamtsev on 2/23/22.
//  Copyright © 2022 Serhii Liamtsev. All rights reserved.
//

import Foundation

enum Endpoint: EndpointProtocol {
    
    case topHeadLines
    case articlesFromCategory(_ category: String)
    case articlesFromSource(_ source: String)
    case search(searchFilter: String)
    case sources(country: String)
    
    var baseURL: URL {
        return Environment.restBaseURL
    }
    
    var path: String {
        switch self {
        case .topHeadLines, .articlesFromCategory:
            return "top-headlines"
        case .search,.articlesFromSource:
            return "everything"
        case .sources:
            return "sources"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .topHeadLines:
            return .get
        case .articlesFromCategory:
            return .get
        case .articlesFromSource:
            return .get
        case .search:
            return .get
        case .sources:
            return .get
        }
    }
    
    var absoluteURL: URL? {
        let queryURL = baseURL.appendingPathComponent(self.path)
        let components = URLComponents(url: queryURL, resolvingAgainstBaseURL: true)
        guard var urlComponents = components else {
            return baseURL
        }
        urlComponents.queryItems = self.queryItems
        return urlComponents.url
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .topHeadLines:
            return [
                URLQueryItem(name: "country", value: region),
                URLQueryItem(name: "apikey", value: RestApiConstants.apiKey)
            ]
        case .articlesFromCategory(let category):
            return [
                URLQueryItem(name: "country", value: region),
                URLQueryItem(name: "category", value: category),
                URLQueryItem(name: "apikey", value: RestApiConstants.apiKey)
            ]
        case .sources(let country):
            return [
                URLQueryItem(name: "country", value: country),
                URLQueryItem(name: "language", value: countryLang[country]),
                URLQueryItem(name: "apikey", value: RestApiConstants.apiKey)
            ]
        case .articlesFromSource(let source):
            return [
                URLQueryItem(name: "sources", value: source),
             /* URLQueryItem(name: "language", value: locale), */
                URLQueryItem(name: "apikey", value: RestApiConstants.apiKey)
            ]
        case .search(let searchFilter):
            return [
                URLQueryItem(name: "q", value: searchFilter.lowercased()),
             /* URLQueryItem(name: "language", value: locale), */
             /* URLQueryItem(name: "country", value: region), */
                URLQueryItem(name: "apikey", value: RestApiConstants.apiKey)
            ]
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        default:
            return nil
        }
    }
    
    var locale: String {
        return Locale.current.languageCode ?? "en"
    }
    
    var region: String {
        return Locale.current.regionCode?.lowercased() ?? "us"
    }
    
    init? (index: Int, text: String = "sports") {
        switch index {
        case 0: self = .topHeadLines
        case 1: self = .search(searchFilter: text)
        case 2: self = .articlesFromCategory(text)
        case 3: self = .articlesFromSource(text)
        case 4: self = .sources (country: text)
        default: return nil
        }
    }
    
    var countryLang : [String: String]  {return [
      "ar": "es",  // argentina
      "au": "en",  // australia
      "br": "es",  // brazil
      "ca": "en",  // canada
      "cn": "cn",  // china
      "de": "de",  // germany
      "es": "es",  // spain
      "fr": "fr",  // france
      "gb": "en",  // unitedKingdom
      "hk": "cn",  // hongKong
      "ie": "en",  // ireland
      "in": "en",  // india
      "is": "en",  // iceland
      "il": "he",  // israil for sources - language
      "it": "it",  // italy
      "nl": "nl",  // netherlands
      "no": "no",  // norway
      "ru": "ru",  // russia
      "sa": "ar",  // saudiArabia
      "us": "en",  // unitedStates
      "za": "en"   // southAfrica
      ]
    }
}

//
//  EndpointProtocol.swift
//  NewsApp
//
//  Created by Serhii Liamtsev on 3/13/22.
//  Copyright © 2022 Serhii Liamtsev. All rights reserved.
//

import Foundation

typealias HTTPHeaders = [String: String]

protocol EndpointProtocol {
    
    var baseURL: URL { get }
    
    var path: String { get }
    
    var httpMethod: HTTPMethod { get }
    
    // Absolute URL - with encoded body, headers and query parameters.
    // Required due to URLSession Combine API - URLSession.shared.dataTaskPublisher(for: url)
    var absoluteURL: URL? { get }
    
    var queryItems: [URLQueryItem]? { get }
    
    // Body parameters
    var parameters: [String: Any]? { get }
    
    var locale: String { get }
    
    var region: String { get }
}

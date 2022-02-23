//
//  Environment.swift
//  NewsApp
//
//  Created by Serhii Liamtsev on 5/3/21.
//  Copyright © 2021 Serg Liamtsev. All rights reserved.
//

import Foundation

private enum UserDefinedKeys: String, CaseIterable {
    
    // MARK: - Base URL keys
    case unknown = "unknown"
    case restBaseURL = "REST_BASE_URL"
    case newsApiKey = "NEWS_API_KEY"
}

enum Environment {
    
    private static let dictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            preconditionFailure("Plist file not found")
        }
        return dict
    }()
    
    static let bundleId: String = {
        guard let bundleId = Bundle.main.bundleIdentifier else {
            preconditionFailure("Unable to get bundle id")
        }
        return bundleId
    }()
    
    static let appVersion: String = {
        guard let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String else {
            preconditionFailure("Unable to get app version number")
        }
        return appVersion
    }()
    
    static let appBuildNumber: String = {
        guard let buildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as? String else {
            preconditionFailure("Unable to get app build number")
        }
        return buildNumber
    }()
    
    // MARK: - Networking Constants
    static let restBaseURL: URL = {
        guard let restBaseURLString = Bundle.main.infoDictionary?[UserDefinedKeys.restBaseURL.rawValue] as? String else {
            preconditionFailure("Unable to get app FB App ID")
        }
        guard let url = URL(string: restBaseURLString) else {
            preconditionFailure("Unable to get create URL")
        }
        return url
    }()
    
    static let newsApiKey: String = {
        guard let string = Bundle.main.infoDictionary?[UserDefinedKeys.newsApiKey.rawValue] as? String else {
            preconditionFailure("Unable to get app FB App ID")
        }
        return string
    }()
    
    // MARK: - Mock API flag
    static var isMockApi: Bool {
        guard let arg = ProcessInfo.processInfo.environment["MOCK_API"] else {
            return false
        }
        return arg == "true"
    }
    
    static var isMockApiStubSuccess: Bool {
        guard let arg = ProcessInfo.processInfo.environment["MOCK_API_SUCCESS"] else {
            return true
        }
        return arg == "true"
    }
    
}

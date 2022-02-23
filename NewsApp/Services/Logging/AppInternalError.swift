//
//  AppInternalError.swift
//  NewsApp
//
//  Created by Serhii Liamtsev on 5/3/21.
//  Copyright © 2021 Serg Liamtsev. All rights reserved.
//

import Foundation

enum AppInternalError: Error, LocalizedError {
    
    case fontNotFound(fontName: String)
    case error(errorMessage: String)
    
    var description: String {
        switch self {
        case .fontNotFound(let fontName):
            return "Invalid font name \(fontName) / font file is missing / not registered in plist"
        case .error(let errorMessage):
            return errorMessage
        }
    }
    
    var errorDescription: String? {
        return self.description
    }
    
    var nsError: NSError {
        switch self {
            
        case .fontNotFound:
            let userInfo: [String: Any] = [NSLocalizedDescriptionKey: self.description,
                                           NSLocalizedFailureReasonErrorKey: self.description,
                                           "user_id": "undefined"]
            return NSError(domain: Environment.bundleId, code: -1001, userInfo: userInfo)
            
        case .error(let errorMessage):
            
            let userInfo: [String: Any] = [NSLocalizedDescriptionKey: errorMessage,
                                           NSLocalizedFailureReasonErrorKey: errorMessage,
                                           "user_id": "undefined"]
            return NSError(domain: Environment.bundleId, code: -1001, userInfo: userInfo)
        }
    }
    
}

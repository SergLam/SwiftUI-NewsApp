//
//  AppConstants.swift
//  NewsApp
//
//  Created by Serhii Liamtsev on 2/23/22.
//  Copyright © 2022 Serhii Liamtsev. All rights reserved.
//

import UIKit

struct AppConstants {
    
    // MARK: - Networking constants
    static let requestTimeOutTimeInterval: TimeInterval = 30.0
    
    static let dateDecodingFormat: JSONDecoder.DateDecodingStrategy = .secondsSince1970
    static let dateEncodingFormat: JSONEncoder.DateEncodingStrategy = .secondsSince1970
    
    static let dateDecodingFormatSeconds: JSONDecoder.DateDecodingStrategy = .secondsSince1970
    static let dateEncodingFormatSeconds: JSONEncoder.DateEncodingStrategy = .secondsSince1970
    
    static let dateFormat: DateFormatter = DateFormatter.iso8601Miliseconds
    static let birthDayDateFormat: DateFormatter = DateFormatter.dateOfBirth
    
    static let imageCompression: CGFloat = 1.0
    
    static let previewDevices: [String] = ["iPhone SE (1st generation)"]// ["iPhone SE (1st generation)", "iPhone 8 (14.3)", "iPhone 12", "iPhone 12 Pro Max"]
    
    static let previewBigDevice: [String] = ["iPhone 12 Pro Max"]
    
    static var prettyJsonOptions: JSONSerialization.WritingOptions {
        let options: JSONSerialization.WritingOptions
        if #available(iOS 13.0, *) {
            options = [.prettyPrinted, .sortedKeys, .withoutEscapingSlashes]
        } else {
            options = [.prettyPrinted, .sortedKeys]
        }
        return options
    }
}

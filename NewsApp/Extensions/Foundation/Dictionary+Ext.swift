//
//  Dictionary+Ext.swift
//  NewsApp
//
//  Created by Serhii Liamtsev on 3/13/22.
//  Copyright © 2022 Serhii Liamtsev. All rights reserved.
//

import Foundation

extension Dictionary {
        
    func toJsonString() -> String {
        let invalidJson = "Not a valid JSON"
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: [])
            return String(bytes: jsonData, encoding: String.Encoding.utf8) ?? invalidJson
        } catch {
            return invalidJson
        }
    }
    
    func toJsonStringPretty() -> String {
        let invalidJson = "Not a valid JSON"
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            return String(bytes: jsonData, encoding: String.Encoding.utf8) ?? invalidJson
        } catch {
            return invalidJson
        }
    }
    
    var jsonString: String? {
        
        let options: JSONSerialization.WritingOptions
        if #available(iOS 13.0, *) {
            options = [.prettyPrinted, .sortedKeys, .withoutEscapingSlashes]
        } else if #available(iOS 11.0, *) {
            options = [.prettyPrinted, .sortedKeys]
        } else {
            options = [.prettyPrinted]
        }
        guard let data = try? JSONSerialization.data(withJSONObject: self, options: options) else {
            return nil
        }
        guard let jsonString = String(data: data, encoding: .utf8) else {
            return nil
        }
        // NOTE: - empty dictionary (json object) check
        let check = jsonString.replacingOccurrences(of: "\n", with: "").replacingOccurrences(of: "{", with: "").replacingOccurrences(of: "}", with: "")
        return check.isEmpty ? nil : jsonString
    }
    
}

extension Dictionary where Key == String {
    
    /// Sort inputted dictionary with keys alphabetically.
    /// - Parameter dict: dictionary to sort
    /// - Returns: sorted dictionary
    func sortWithKeys<T: Equatable>(_ class: T.Type) -> [String: T] {
        
        let sorted = self.sorted(by: { $0.key < $1.key })
        var newDict: [String: T] = [:]
        for sortedDict in sorted {
            newDict[sortedDict.key] = sortedDict.value as? T
        }
        return newDict
    }
    
}

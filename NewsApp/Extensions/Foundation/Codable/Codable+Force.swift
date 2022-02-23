//
//  Codable+Force.swift
//  NewsApp
//
//  Created by Serhii Liamtsev on 2/21/22.
//  Copyright © 2022 Serg Liamtsev. All rights reserved.
//

import Foundation

extension KeyedDecodingContainer {

    /**
       Use to decode Int values using JS logic ["0", "1", 0, 1]
    */
    func decodeForce(_ type: Int.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> Int {
        
        let error = CodingError.unableToDecode(key: key.stringValue, type: String(describing: Int.self))
        // First try to decode it as a regular Int
        if let intValue = try? self.decode(Int.self, forKey: key) {
            return intValue
        }
        // Then try to decode it as string value
        let stringValue = try? self.decode(String.self, forKey: key)
        
        // Check all the above values
        if let string = stringValue, let intFromStr = Int(string) {
            return intFromStr
        // In case of empty string return zero value
        } else if let string = stringValue, string.isEmpty {
            return 0
        } else {
            throw error
        }
    }
    
    func decodeForce(_ type: Double.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> Double {
        
        let error = CodingError.unableToDecode(key: key.stringValue, type: String(describing: Double.self))
        // First try to decode it as a regular Int
        let doubleValue = try? self.decode(Double.self, forKey: key)
        if let double = doubleValue {
            return double
        }
        
        // Then try to decode it as string value
        let stringValue = try? self.decode(String.self, forKey: key)
        // Check all the above values
        if let string = stringValue, let intFromStr = Double(string) {
            return intFromStr
            
        // In case of empty string return zero value
        } else if let string = stringValue, string.isEmpty {
            return 0
        } else {
            throw error
        }
    }
    
    /**
        Use to decode Bool values using JS logic ["true", "false", "0", "1", 0, 1, true, false]
     */
    func decodeForce(_ type: Bool.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> Bool {
        
        let error = CodingError.unableToDecode(key: key.stringValue, type: String(describing: Bool.self))
        
        // First try to decode it as a regular Bool -  true, false
        let boolValue = try? self.decode(Bool.self, forKey: key)
        if let bool = boolValue {
            return bool
        }
        
        // Then try to decode it as int value - 0, 1
        let intValue = try? self.decode(Int.self, forKey: key)
        // Then try to decode it as string value - "true", "false", "0", "1",
        let stringValue = try? self.decode(String.self, forKey: key)
        
        // Check all the above values
        if let int = intValue, int == 0 || int == 1 {
            return int == 1
        } else if let string = stringValue {
            
            // "true", "false", "0", "1",
            if string.count == 1 {
                
                // "0", "1"
                guard let intFromStr = Int(string) else {
                    throw error
                }
                return intFromStr == 1
                
            } else {
                
                switch string {
                case "true":
                    return true
                case "false":
                    return false
                default:
                    throw error
                }
                
            }
            
        } else {
            throw error
        }
    }
    
    func decodeForce(_ type: String.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> String {
        
        let error = CodingError.unableToDecode(key: key.stringValue, type: String(describing: String.self))
        
        if let stringValue = try? self.decode(String.self, forKey: key) {
            return stringValue
            
        } else if let intValue = try? self.decode(Int.self, forKey: key) {
            return String(intValue)
            
        } else if let doubleValue = try? self.decode(Double.self, forKey: key) {
            return String(doubleValue)
            
        } else {
            throw error
        }
    }
    
    func decodeIfPresentForce(_ type: Bool.Type, forKey key: K) throws -> Bool? {
        guard contains(key) else {
            return nil
        }
        guard try decodeNil(forKey: key) == false else {
            return nil
        }
        return try decodeForce(type, forKey: key)
    }
    
    func decodeIfPresentForce(_ type: Int.Type, forKey key: K) throws -> Int? {
        guard contains(key) else {
            return nil
        }
        guard try decodeNil(forKey: key) == false else {
            return nil
        }
        return try decodeForce(type, forKey: key)
    }
    
    func decodeIfPresentForce(_ type: Double.Type, forKey key: K) throws -> Double? {
        guard contains(key) else {
            return nil
        }
        guard try decodeNil(forKey: key) == false else {
            return nil
        }
        return try decodeForce(type, forKey: key)
    }
    
    func decodeIfPresentForce(_ type: String.Type, forKey key: K) throws -> String? {
        guard contains(key) else {
            return nil
        }
        guard try decodeNil(forKey: key) == false else {
            return nil
        }
        return try decodeForce(type, forKey: key)
    }
    
}

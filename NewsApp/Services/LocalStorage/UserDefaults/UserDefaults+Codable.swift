//
//  UserDefaults+Codable.swift
//  NewsApp
//
//  Created by Serhii Liamtsev on 5/3/21.
//  Copyright © 2021 Serg Liamtsev. All rights reserved.
//

import Foundation

private let jsonDecoder: JSONDecoder = {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = AppConstants.dateDecodingFormat
    return decoder
}()

private let jsonEncoder: JSONEncoder = {
    let encoder = JSONEncoder()
    encoder.dateEncodingStrategy = AppConstants.dateEncodingFormat
    return encoder
}()

private
struct Container<ObjectType: Codable>: Codable {
    let object: ObjectType
}

extension UserDefaults {
    
    func set<ObjectType: Codable>( object: ObjectType?, forKey defaultName: String) {
        
        guard let object = object else {
            self.removeObject(forKey: defaultName)
            return
        }
        
        let container = Container(object: object)
        do {
            let data = try jsonEncoder.encode(container)
            self.set(data, forKey: defaultName)
            
        } catch {
            LoggerService.logErrorWithTrace(error: error)
        }
    }
    
    func get<ObjectType: Codable>(forKey defaultName: String, type: ObjectType.Type) -> ObjectType? {
        guard let data = self.data(forKey: defaultName) else {
            return nil
        }
        
        do {
            let container = try jsonDecoder.decode(Container<ObjectType>.self, from: data)
            return container.object
        } catch {
            LoggerService.logErrorWithTrace(error: error)
        }
        
        return nil
    }
    
}

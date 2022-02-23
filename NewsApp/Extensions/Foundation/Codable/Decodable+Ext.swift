//
//  Decodable+Ext.swift
//  NewsApp
//
//  Created by Serhii Liamtsev on 2/21/22.
//  Copyright © 2022 Serg Liamtsev. All rights reserved.
//

import Foundation

extension KeyedDecodingContainer {
    
     func nestedContainerIfPresent<NestedKey>(keyedBy type: NestedKey.Type, forKey key: KeyedDecodingContainer<K>.Key) -> KeyedDecodingContainer<NestedKey>? where NestedKey: CodingKey {
        
        do {
            return try nestedContainer(keyedBy: type, forKey: key)
        } catch {
            return nil
        }
    }
}

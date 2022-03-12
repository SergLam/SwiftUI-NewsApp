//
//  Mockable.swift
//  NewsApp
//
//  Created by Serhii Liamtsev on 3/12/22.
//  Copyright © 2022 Serhii Liamtsev. All rights reserved.
//

import Foundation

protocol Mockable {
    
    associatedtype MockType
    
    static func mock(isSuccess: Bool) -> MockType
    
    static func mockArray(_ count: Int) -> [MockType]
}

extension Mockable {
    
    static func mockArray(_ count: Int) -> [MockType] {
        
        return Array(repeating: 0, count: count).map{ _ in
            return Self.mock(isSuccess: true)
        }
    }
    
}

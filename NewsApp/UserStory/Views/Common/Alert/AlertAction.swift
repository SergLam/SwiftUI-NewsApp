//
//  AlertAction.swift
//  NewsApp
//
//  Created by Serhii Liamtsev on 3/13/22.
//  Copyright © 2022 Serhii Liamtsev. All rights reserved.
//

import Foundation

enum AlertAction: Int, CaseIterable {
    
    case ok = 0
    case cancel = 1
    
    var title: String {
        switch self {
        case .ok:
            return LocalizedStrings.okButtonTitle
        case .cancel:
            return LocalizedStrings.cancelButtonTitle
        }
    }
}

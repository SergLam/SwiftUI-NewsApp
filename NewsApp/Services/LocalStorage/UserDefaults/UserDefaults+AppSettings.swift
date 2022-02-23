//
//  UserDefaults+AppSettings.swift
//  NewsApp
//
//  Created by Serhii Liamtsev on 5/3/21.
//  Copyright © 2021 Serg Liamtsev. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    /**
    Flag to determine selected locale for app in user profile settings
     
    Because of using R.swift - need to save language code
     
     https://developer.apple.com/documentation/foundation/nslocale/1643026-languagecode
    */
    var selectedLocaleCode: String {
        get {
            // Locale.current.languageCode
            return UserDefaults.shared.value(forKey: LocalStorageKeys.selectedLocaleCode.rawValue) as? String ?? "en"
        }
        set {
            UserDefaults.shared.set(newValue, forKey: LocalStorageKeys.selectedLocaleCode.rawValue)
        }
    }
    
}

//
//  Data+JSON.swift
//  NewsApp
//
//  Created by Serhii Liamtsev on 2/20/22.
//  Copyright © 2022 Serg Liamtsev. All rights reserved.
//

import Foundation

extension Data {
    
    var prettyJson: String? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: AppConstants.prettyJsonOptions),
              let prettyPrintedString = String(data: data, encoding: .utf8) else {
                  
                  return String(data: self, encoding: .utf8)
              }
        let resultString = prettyPrintedString.trimmingCharacters(in: .whitespacesAndNewlines)
        let resultString1 = resultString.replacingOccurrences(of: "\n", with: "")
        let resultString2 = resultString1.replacingOccurrences(of: "\\", with: "")
        return resultString2
    }
}

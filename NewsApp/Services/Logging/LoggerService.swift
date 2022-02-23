//
//  LoggerService.swift
//  NewsApp
//
//  Created by Serhii Liamtsev on 5/3/21.
//  Copyright © 2021 Serg Liamtsev. All rights reserved.
//

import CoreTelephony
import Foundation
import os

final class LoggerService: NSObject {
    
    static func testCrashCrashlytics() {
        #if DEBUG
        fatalError("Test crash")
        #endif
    }
    
    // MARK: - Error logging
    static func logErrorWithTrace(error: Error,
                                  _ file: String = #file,
                                  _ function: String = #function,
                                  _ line: Int = #line) {
        LoggerService.logErrorWithTrace(error.localizedDescription, file, function, line)
    }
    
    static func logErrorWithTrace(_ errorMessage: String,
                                  _ file: String = #file,
                                  _ function: String = #function,
                                  _ line: Int = #line) {
        #if DEBUG
        // NOTE: AdHoc config also will fails without if statement
        // assertionFailure(errorMessage)
        #endif
        // NOTE: - Log error to external services, if required
//        let error = AppInternalError.error(errorMessage: errorMessage)
//        let logInfoString: String = "\(error.localizedDescription)\nfile: \(file)\nfunction: \(function)\nline: \(line)"
        
        os_log("%@", log: .error, type: .error, errorMessage)
    }
    
}

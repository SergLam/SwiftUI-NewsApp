//
//  OSLog+Ext.swift
//  NewsApp
//
//  Created by Serhii Liamtsev on 5/3/21.
//  Copyright © 2021 Serg Liamtsev. All rights reserved.
//

import Foundation
import os

extension OSLog {
    
    private static var subsystem = Bundle.main.bundleIdentifier ?? ""

    static let error = OSLog(subsystem: subsystem, category: "Internal_Error")
    
    static let networkStatus = OSLog(subsystem: subsystem, category: "Network_status")
    
    static let socketStatus = OSLog(subsystem: subsystem, category: "Socket_status")
    
    static let socketDataSending = OSLog(subsystem: subsystem, category: "Socket_data_send")
}

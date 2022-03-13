//
//  MovieStoreAPIError.swift
//  CombineFetchAPI
//
//

import Foundation

enum NewsError: Error, LocalizedError, Identifiable {
    
    var id: String {
        return localizedDescription
    }
    
    case urlError(URLError)
    case responseError((Int, String))
    case decodingError(DecodingError)
    case genericError
    
    var localizedDescription: String {
        switch self {
        case .urlError(let error):
            return error.localizedDescription
            
        case .responseError((let status, let message)):
            let range = (message.range(of: "message\":")?.upperBound
                     ?? message.startIndex)..<message.endIndex
            return "Bad response code: \(status) message : \(message[range])"
            
        case .decodingError(let error):
            var errorToReport = error.localizedDescription
            switch error {
            case .dataCorrupted(let context):
                let details = context.underlyingError?.localizedDescription
                           ?? context.codingPath.map { $0.stringValue }.joined(separator: ".")
                errorToReport = "\(context.debugDescription) - (\(details))"
            case .keyNotFound(let key, let context):
                let details = context.underlyingError?.localizedDescription
                           ?? context.codingPath.map { $0.stringValue }.joined(separator: ".")
                errorToReport = "\(context.debugDescription) (key: \(key), \(details))"
            case .typeMismatch(let type, let context), .valueNotFound(let type, let context):
                let details = context.underlyingError?.localizedDescription
                           ?? context.codingPath.map { $0.stringValue }.joined(separator: ".")
                errorToReport = "\(context.debugDescription) (type: \(type), \(details))"
            @unknown default:
                break
            }
            return  errorToReport
       
        case .genericError:
            return "An unknown error has been occured"
        }
    }
    
    var errorDescription: String? {
        return self.localizedDescription
    }
    
    var failureReason: String? {
        return self.localizedDescription
    }
}


// MARK: - Hashable
extension NewsError: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(localizedDescription)
    }
    
}

// MARK: - Equatable
extension NewsError: Equatable {
    
    static func == (lhs: NewsError, rhs: NewsError) -> Bool {
        return lhs.localizedDescription == rhs.localizedDescription
    }
    
    static func == (lhs: NewsError, rhs: Error) -> Bool {
        return lhs.localizedDescription == rhs.localizedDescription
    }
    
    static func == (lhs: Error, rhs: NewsError) -> Bool {
        return lhs.localizedDescription == rhs.localizedDescription
    }
    
}

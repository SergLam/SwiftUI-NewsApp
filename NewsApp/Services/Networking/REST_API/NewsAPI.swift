//
//  MovieRepository.swift
//  MovieKit
//
//  Created by Alfian Losari on 11/24/18.
//  Copyright © 2018 Alfian Losari. All rights reserved.
//

import Foundation
import Combine

final class NewsAPI {
    
    static let shared = NewsAPI()
    
    private var subscriptions = Set<AnyCancellable>()
    
    // Асинхронная выборка на основе URL
    func fetch<T: Decodable>(_ url: URL) -> AnyPublisher<T, Error> {
        URLSession.shared.dataTaskPublisher(for: url)             // 1
            .map {
                self.logResponse(url: url, data: $0.data, response: $0.response, error: nil)
                return $0.data
            }                                          // 2
            .decode(type: T.self, decoder: RestApiConstants.jsonDecoder) // 3
            .receive(on: RunLoop.main)                               // 4
            .eraseToAnyPublisher()                                   // 5
    }
    
    // Асинхронная выборка на основе URL с сообщениями об ошибках
    func fetchErr<T: Decodable>(_ url: URL) -> AnyPublisher<T, Error> {
        URLSession.shared.dataTaskPublisher(for: url)             // 1
            .tryMap { (data, response) -> Data in                     // 2
                guard let httpResponse = response as? HTTPURLResponse,
                      200...299 ~= httpResponse.statusCode else {
                          throw NewsError.responseError(
                            ((response as? HTTPURLResponse)?.statusCode ?? 500,
                             String(data: data, encoding: .utf8) ?? ""))
                      }
                self.logResponse(url: url, data: data, response: response, error: nil)
                return data
            }
            .decode(type: T.self, decoder: RestApiConstants.jsonDecoder)  // 3
            .receive(on: RunLoop.main)                                // 4
            .eraseToAnyPublisher()                                    // 5
    }
    
    // Асинхронная выборка статей
    func fetchArticles(from endpoint: Endpoint) -> AnyPublisher<[ArticleJSON], Never> {
        guard let url = endpoint.absoluteURL else {
            return Just([ArticleJSON]()).eraseToAnyPublisher() // 0
        }
        self.logRequest(endpoint: endpoint)
        return fetch(url)                                          // 1
            .map { (response: NewsResponseJSON) -> [ArticleJSON] in        // 2
                return response.articles
            }
            .replaceError(with: [ArticleJSON]())                    // 3
            .eraseToAnyPublisher()                              // 4
    }
    
    // Асинхронная выборка источников информации
    func fetchSources(for country: String)
    -> AnyPublisher<[SourceJSON], Never> {
        guard let url = Endpoint.sources(country: country).absoluteURL
        else {
            return Just([SourceJSON]()).eraseToAnyPublisher() // 0
        }
        return fetch(url)                                     // 1
            .map { (response: SourcesResponseJSON) -> [SourceJSON] in // 2
                response.sources }
            .replaceError(with: [SourceJSON]())                    // 3
            .eraseToAnyPublisher()                             // 4
    }
    
    
    // Асинхронная  выборка статей  с сообщением об ошибке
    func fetchArticlesErr(from endpoint: Endpoint) ->
    AnyPublisher<[ArticleJSON], NewsError>{
        Future<[ArticleJSON], NewsError> { [unowned self] promise in
            
            guard let url = endpoint.absoluteURL  else {
                return promise(
                    .failure(.urlError(URLError(.unsupportedURL)))) // 0
            }
            self.logRequest(endpoint: endpoint)
            self.fetchErr(url)                                          // 1
                .tryMap { (result: NewsResponseJSON) -> [ArticleJSON] in  // 2
                    result.articles
                }
                .sink(
                    receiveCompletion: { (completion) in                  // 3
                        if case let .failure(error) = completion {
                            switch error {
                            case let urlError as URLError:
                                promise(.failure(.urlError(urlError)))
                            case let decodingError as DecodingError:
                                promise(.failure(.decodingError(decodingError)))
                            case let apiError as NewsError:
                                promise(.failure(apiError))
                            default:
                                promise(.failure(.genericError))
                            }
                        }
                    },
                    receiveValue: {
                        promise(.success($0))
                    })  // 4
                .store(in: &self.subscriptions)  // 5
        }
        .eraseToAnyPublisher() // 6
    }
    
    // Асинхронная выборка источников  с сообщением об ошибке
    func fetchSourcesErr(for country: String) ->
    AnyPublisher<[SourceJSON], NewsError>{
        Future<[SourceJSON], NewsError> { [unowned self] promise in
            let endpoint = Endpoint.sources(country: country)
            guard let url = endpoint.absoluteURL  else {
                return promise(
                    .failure(.urlError(URLError(.unsupportedURL)))) // 0
            }
            self.logRequest(endpoint: endpoint)
            self.fetchErr(url)                                      // 1
                .tryMap { (result: SourcesResponseJSON) -> [SourceJSON] in // 2
                    result.sources
                }
                .sink(
                    receiveCompletion: { (completion) in                    // 3
                        if case let .failure(error) = completion {
                            switch error {
                            case let urlError as URLError:
                                promise(.failure(.urlError(urlError)))
                            case let decodingError as DecodingError:
                                promise(.failure(.decodingError(decodingError)))
                            case let apiError as NewsError:
                                promise(.failure(apiError))
                            default:
                                promise(.failure(.genericError))
                            }
                        }
                    },
                    receiveValue: {
                        promise(.success($0))
                    }) // 4
                .store(in: &self.subscriptions) // 5
        }
        .eraseToAnyPublisher()        // 6
    }
    
    private func logRequest(endpoint: EndpointProtocol) {
        
        print("", separator: "\n", terminator: "\n")
        print("NETWORK LOGGER:", separator: "\n", terminator: "\n")
        print("REQUEST METHOD: \(endpoint.httpMethod.rawValue)", separator: "\n", terminator: "\n")
        // print("REQUEST HEADERS: \(endpoint.HTTPHeaderFields?.jsonString ?? "")", separator: "\n", terminator: "\n")
        print("REQUEST URL: \(endpoint.baseURL.absoluteString + endpoint.path)", separator: "\n", terminator: "\n")
        
        if let body = endpoint.parameters {
            
            print("REQUEST BODY PARAMETERS: \(body.jsonString ?? "")", separator: "\n", terminator: "\n")
            
        } else if let queryParams = endpoint.queryItems {
            var resultDict: [String: String?] = [:]
            let dictionaries: [[String: String?]] = queryParams.map{ $0.dictionary }
            for dictionary in dictionaries {
                for item in dictionary {
                    resultDict[item.key] = item.value
                }
            }
            
            print("REQUEST QUERY PARAMETERS: \(resultDict.jsonString ?? "")", separator: "\n", terminator: "\n")
        }
    }
    
    private func logResponse(endpoint: EndpointProtocol, data: Data?, response: URLResponse?, error: Error?) {
        
        print("", separator: "\n", terminator: "\n")
        print("NETWORK LOGGER:", separator: "\n", terminator: "\n")
        if let url = response?.url {
            print(url, separator: "\n", terminator: "\n")
        }
        if let response = response as? HTTPURLResponse {
            print("Status code: \(response.statusCode)", separator: "\n", terminator: "\n")
        }
        if let data = data {
            if let jsonString = data.prettyJson {
                print(jsonString, separator: "\n", terminator: "\n")
            } else {
                print("Response Data bytes: \(data.count)", separator: "\n", terminator: "\n")
            }
        }
        if let error = error {
            print(error, separator: "\n", terminator: "\n")
        }
        print("", separator: "\n", terminator: "\n")
    }
    
    private func logResponse(url: URL, data: Data?, response: URLResponse?, error: Error?) {
        
        print("", separator: "\n", terminator: "\n")
        print("NETWORK LOGGER:", separator: "\n", terminator: "\n")
        print(url.absoluteString, separator: "\n", terminator: "\n")
        if let response = response as? HTTPURLResponse {
            print("Status code: \(response.statusCode)", separator: "\n", terminator: "\n")
        }
        if let data = data {
            if let jsonString = data.prettyJson {
                print(jsonString, separator: "\n", terminator: "\n")
            } else {
                print("Response Data bytes: \(data.count)", separator: "\n", terminator: "\n")
            }
        }
        if let error = error {
            print(error, separator: "\n", terminator: "\n")
        }
        print("", separator: "\n", terminator: "\n")
    }
    
    /*
     // Выборка статей без Generic "издателя"
     func fetchArticles(from endpoint: Endpoint) -> AnyPublisher<[ArticleJSON], Never> {
     guard let url = endpoint.absoluteURL else {                       // 0
     return Just([ArticleJSON]()).eraseToAnyPublisher()
     }
     return
     URLSession.shared.dataTaskPublisher(for:url)                  // 1
     .map{$0.data}                                                 // 2
     .decode(type: NewsResponseJSON.self,                              // 3
     decoder: RestApiConstants .jsonDecoder)
     .map{$0.articles}                                             // 4
     .replaceError(with: [])                                       // 5
     .receive(on: RunLoop.main)                                    // 6
     .eraseToAnyPublisher()                                        // 7
     }
     
     // Выборка источников информации  без Generic "издателя"
     func fetchSources() -> AnyPublisher<[SourceJSON], Never> {
     guard let url = Endpoint.sources.absoluteURL else {                // 0
     return Just([SourceJSON]()).eraseToAnyPublisher()
     }
     return
     URLSession.shared.dataTaskPublisher(for:url)               // 1
     .map{$0.data}                                              // 2
     .decode(type: SourcesResponseJSON.self,                        // 3
     decoder: RestApiConstants .jsonDecoder)
     .map{$0.sources}                                           // 4
     .replaceError(with: [])                                    // 5
     .receive(on: RunLoop.main)                                 // 6
     .eraseToAnyPublisher()                                     // 7
     }
     */
    /*
     // Выборка статей с ошибкой без Generic "издателя"
     func fetchArticlesErr(from endpoint: Endpoint) ->
     AnyPublisher<[ArticleJSON], NewsError>{
     return Future<[ArticleJSON], NewsError> { [unowned self] promise in
     guard let url = endpoint.absoluteURL  else {
     return promise(.failure(.urlError(                          // 0
     URLError(.unsupportedURL))))
     }
     
     URLSession.shared.dataTaskPublisher(for: url)                  // 1
     .tryMap { (data, response) -> Data in                       // 2
     guard let httpResponse = response as? HTTPURLResponse,
     200...299 ~= httpResponse.statusCode else {
     throw NewsError.responseError(
     ((response as? HTTPURLResponse)?.statusCode ?? 500,
     String(data: data, encoding: .utf8) ?? ""))
     }
     return data
     }
     .decode(type: NewsResponseJSON.self,
     decoder: RestApiConstants.jsonDecoder) // 3
     .receive(on: RunLoop.main)                                       // 4
     .sink(
     receiveCompletion: { (completion) in                          // 5
     if case let .failure(error) = completion {
     switch error {
     case let urlError as URLError:
     promise(.failure(.urlError(urlError)))
     case let decodingError as DecodingError:
     promise(.failure(.decodingError(decodingError)))
     case let apiError as NewsError:
     promise(.failure(apiError))
     default:
     promise(.failure(.genericError))
     }
     }
     },
     receiveValue: { promise(.success($0.articles)) })             // 6
     .store(in: &self.subscriptions)                                 // 7
     }
     .eraseToAnyPublisher()                                               // 8
     }
     */
    
    //"17dee2eb8eee461584226aceece35139"
    // "b054d201bf7c4ba8976e3b2ec44686ce"
    //"a7d312d111564be8af66634a50ba3e24"
    //"8e58842e74f2453bb5e6e3845b386a81"
    //"db358b36376b40528bac16f119610dd9"
    //"78373fa588974c0382c031230e906169"
    //"1a1c707884f343f6a5d1b2653eecb8d9"
    //"654f479b4cb34f4ea18db7eda6437ec2"
}

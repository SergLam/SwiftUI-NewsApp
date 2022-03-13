//
//  SourcesViewModelErr.swift
//  NewsApp
//
//  Created by Tatiana Kornilova on 09/02/2020.
//  Copyright © 2020 Tatiana Kornilova. All rights reserved.
//

import Combine
import Foundation

final class SourcesViewModelErr: ObservableObject {
    
     var newsAPI = NewsAPI.shared
    // input
    @Published var searchString: String = "" {
        didSet {
            validString.sink(receiveValue: { [weak self] value in
                self?.searchForSource(value)
            }).store(in: &self.cancellableSet)
        }
    }
    
    @Published var country: String = SupportedCountries.unitedStates.rawValue
    // output
    @Published var sources = [SourceJSON]()
    
    @Published var sourcesError: NewsError?
    
    private var validString: AnyPublisher<String, Never> {
        return $searchString
            .debounce(for: 0.1, scheduler: RunLoop.main)
            .removeDuplicates()
            .eraseToAnyPublisher()
    }
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    init() {
        searchForSource(searchString)
    }
    
    func searchForSource(_ query: String) {
        let publisher = [query].publisher.eraseToAnyPublisher()
        Publishers.CombineLatest($country, publisher)
        .setFailureType(to: NewsError.self)
        .flatMap { (country, search) ->
                               AnyPublisher<[SourceJSON], NewsError> in
            return self.newsAPI.fetchSourcesErr(for: country)
           .map{search == "" ? $0 : $0.filter {
                  ($0.name?.lowercased().contains(search.lowercased()))!}}
          .eraseToAnyPublisher()
        }
        .sink(
            receiveCompletion:  {[unowned self] (completion) in
            if case let .failure(error) = completion {
                self.sourcesError = error
            }},
              receiveValue: { [unowned self] in
                self.sources = $0
        })
        .store(in: &self.cancellableSet)
    }
     
 /*
    init() {
        Publishers.CombineLatest( $country,  validString)
        .flatMap { (country,search) -> AnyPublisher<[SourceJSON], Never> in
            NewsAPI.shared.fetchSources(for: country)
            .map{search == "" ? $0 : $0.filter {
                    ($0.name?.lowercased().contains(search.lowercased()))!}}
            .eraseToAnyPublisher()
         }
        .assign(to: \.sources, on: self)
        .store(in: &self.cancellableSet)
    }
*/
}


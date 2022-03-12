//
//  ArticlesViewModel.swift
//  NewsApp
//
//  Created by Tatiana Kornilova on 28/10/2019.
//

import Combine
import Foundation

final class ArticlesViewModel: ObservableObject {
    
    // input
    @Published var indexEndpoint: Int = 0
    @Published var searchString: String = LocalizedStrings.articleSearchDefaultText
    // output
    @Published var articles = [ArticleJSON]()
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    private var validString:  AnyPublisher<String, Never> {
        $searchString
            .debounce(for: 0.1, scheduler: RunLoop.main)
            .removeDuplicates()
            .eraseToAnyPublisher()
    }
    
    init(index:Int = 0, text: String = LocalizedStrings.articleSearchDefaultText) {
        self.indexEndpoint = index
        self.searchString = text
        Publishers.CombineLatest( $indexEndpoint,  validString)
        .flatMap { (indexEndpoint, search) -> AnyPublisher<[ArticleJSON], Never> in
                self.articles = [ArticleJSON]()
                return NewsAPI.shared.fetchArticles(from:
                               Endpoint( index: indexEndpoint, text: search )!)
        }
        .assign(to: \.articles, on: self)
        .store(in: &self.cancellableSet)
    }
}

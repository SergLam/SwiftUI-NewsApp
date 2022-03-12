//
//  ContentView.swift
//  NewsApp
//
//  Created by Tatiana Kornilova on 02/02/2020.
//  Copyright © 2020 Tatiana Kornilova. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var articlesViewModel = ArticlesViewModel ()
    
    var body: some View {
        VStack {
            Picker("", selection: $articlesViewModel.indexEndpoint){
                Text(LocalizedStrings.articlesCategoriesTopHeadlines).tag(0)
                Text(LocalizedStrings.articlesSearchTabTitle).tag(1)
                Text(LocalizedStrings.articlesCategoriesFromCategory).tag(2)
            }
            .pickerStyle(SegmentedPickerStyle())
            
            if articlesViewModel.indexEndpoint == 1 {
                SearchView(searchTerm: self.$articlesViewModel.searchString)
            }
            if articlesViewModel.indexEndpoint == 2 {
                                  Picker("", selection: $articlesViewModel.searchString){
                                      Text(LocalizedStrings.articlesCategorySports).tag("sports")
                                      Text(LocalizedStrings.articlesCategoryHealth).tag("health")
                                      Text(LocalizedStrings.articlesCategoryScience).tag("science")
                                      Text(LocalizedStrings.articlesCategoryBusiness).tag("business")
                                      Text(LocalizedStrings.articlesCategoryTechnology).tag("technology")
                                  }
                                  .onAppear(perform: {
                                      self.articlesViewModel.searchString = LocalizedStrings.articlesCategoriesDefaultSearchText
                                  })
                                  .pickerStyle(SegmentedPickerStyle())
                       }
            ArticlesList(articles: articlesViewModel.articles)
        } // VStack
    } // body
}

#if DEBUG
#if targetEnvironment(simulator)

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    
    static var devices = AppConstants.previewDevices
    
    static var platform: PreviewPlatform? {
        return SwiftUI.PreviewPlatform.iOS
    }
    
    static var previews: some View {
        ContentView()
    }
}

#endif
#endif

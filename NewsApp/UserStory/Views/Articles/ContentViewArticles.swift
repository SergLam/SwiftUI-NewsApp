//
//  ContentView1.swift
//  MoviesJSON
//
//  Created by Tatiana Kornilova on 11/12/2019.
//  Copyright © 2019 Tatiana Kornilova. All rights reserved.
//

import SwiftUI

struct ContentViewArticles: View {
    
    @ObservedObject var articlesViewModel = ArticlesViewModelErr ()
    
    var body: some View {
        VStack {
            Picker("", selection: $articlesViewModel.indexEndpoint){
                Text(LocalizedStrings.articlesCategoriesTopHeadlines).tag(0)
                Text(LocalizedStrings.searchFieldPlaceholder).tag(1)
                Text(LocalizedStrings.articlesCategoriesFromCategory).tag(2)
            }
            .pickerStyle(SegmentedPickerStyle())
            if articlesViewModel.indexEndpoint == 1 {
               SearchView(searchTerm: $articlesViewModel.searchString)
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
            .alert(item: self.$articlesViewModel.articlesError) { error in
                    Alert(
                        title: Text(LocalizedStrings.errorNetworkErrorAlertTitle),
                       message: Text(error.localizedDescription).font(.subheadline),
                       dismissButton: .default(Text(LocalizedStrings.okButtonTitle))
                     )
        } // alert
    } // body
}

#if DEBUG
#if targetEnvironment(simulator)

// MARK: - Preview
struct ContentViewArticles_Previews: PreviewProvider {
    
    static var devices = AppConstants.previewDevices
    
    static var platform: PreviewPlatform? {
        return SwiftUI.PreviewPlatform.iOS
    }
    
    static var previews: some View {
        ContentViewArticles()
    }
}

#endif
#endif

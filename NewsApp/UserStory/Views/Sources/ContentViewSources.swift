//
//  ContentViewSources.swift
//  NewsApp
//
//  Created by Tatiana Kornilova on 23/01/2020.
//  Copyright © 2020 Tatiana Kornilova. All rights reserved.
//

import SwiftUI

struct ContentViewSources: View {
    @ObservedObject var sourcesViewModel = SourcesViewModelErr ()
  
    var body: some View {
        NavigationView {
            VStack {
                SearchView(searchTerm: self.$sourcesViewModel.searchString)
                Picker("", selection: self.$sourcesViewModel.country){
                    Text("us").tag("us")
                    Text("gb").tag("gb")
                    Text("ca").tag("ca")
                    Text("ru").tag("ru")
                    Text("fr").tag("fr")
                    Text("de").tag("de")
                    Text("it").tag("it")
                    Text("in").tag("in")
                    Text("sa").tag("sa")
                }
                .pickerStyle(SegmentedPickerStyle())
               
                SourcesList(sources: sourcesViewModel.sources)
            }// VStack
        } // Navigation
        .alert(item: self.$sourcesViewModel.sourcesError) { error in
            Alert( title: Text(LocalizedStrings.errorNetworkErrorAlertTitle),
                              message: Text(error.localizedDescription)
                                       .font(.subheadline),
                   dismissButton: .default(Text(LocalizedStrings.okButtonTitle))
                       )
               } // alert
    } // body
}

#if DEBUG
#if targetEnvironment(simulator)

// MARK: - Preview
struct ContentViewSources_Previews: PreviewProvider {
    
    static var devices = AppConstants.previewDevices
    
    static var platform: PreviewPlatform? {
        return SwiftUI.PreviewPlatform.iOS
    }
    
    static var previews: some View {
        ContentViewSources()
    }
}

#endif
#endif

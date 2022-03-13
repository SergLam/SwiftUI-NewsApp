//
//  ContentViewSources.swift
//  NewsApp
//
//  Created by Tatiana Kornilova on 23/01/2020.
//  Copyright © 2020 Tatiana Kornilova. All rights reserved.
//

import SwiftUI

struct ContentViewSources: View {
    
    @ObservedObject var sourcesViewModel = SourcesViewModelErr()
    
    @State var action: AlertAction?
    @State var isAlertShown: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                
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
                    
                }.blur(radius: isAlertShown ? 30 : 0) // VStack
                
                .onReceive(sourcesViewModel.$sourcesError, perform: { value in
                    self.isAlertShown = value != nil
                })
                
                if self.isAlertShown {
                    
                    AlertView(shown: $isAlertShown, action: action, actions: [AlertAction.ok], isSuccess: false, message: self.$sourcesViewModel.sourcesError.wrappedValue?.localizedDescription ?? "")
                        .onChange(of: action, perform: { newValue in
                            
                            self.isAlertShown = false
                            
                            switch newValue {
                            case .none:
                                break
                            case .some:
                                self.action = nil
                                self.sourcesViewModel.sourcesError = nil
                            }
                        })
                } // alert
                
            } // ZStack
        } // Navigation
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

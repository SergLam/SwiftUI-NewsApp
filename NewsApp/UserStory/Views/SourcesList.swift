//
//  ArticlesListView.swift
//  NewsApp
//
//  Created by Tatiana Kornilova on 23/01/2020.
//  Copyright © 2020 Tatiana Kornilova. All rights reserved.
//

import SwiftUI

struct SourcesList: View {
    var sources: [SourceJSON]
    
    var body: some View {
        List {
           ForEach(sources) {source in
            NavigationLink ( destination:
            DetailSourceView(source: source,
                             articlesViewModel:
                                 ArticlesViewModel (index: 3, text: source.id!))
                ){
                    VStack (alignment: .leading){
                        HStack(alignment: .bottom) {
                            if UIImage(named: "\( source.id != nil ? source.id! : "")") != nil {
                            Image(uiImage:
                                UIImage(named: "\( source.id != nil ? source.id! : "")")!)
                            .resizable()
                            .frame(width:60 , height: 60)
                            }
                        Text("\( source.name != nil ? source.name! : "")")
                        .font(.title)
                        Text("\( source.country != nil ? source.country! : "")")
                        }
                        Text("\( source.description != nil ? source.description! : "")")
                        .lineLimit(3)
                    } //VStack
               } // navigationLink
           } // foreach
        } // list
        .navigationBarTitle("Sources")
      } // body
}

#if DEBUG
#if targetEnvironment(simulator)

// MARK: - Preview
struct SourcesList_Previews: PreviewProvider {
    
    static var devices = AppConstants.previewDevices
    
    static var platform: PreviewPlatform? {
        return SwiftUI.PreviewPlatform.iOS
    }
    
    static var previews: some View {
        NavigationView {
            SourcesList(sources: SourceJSON.mockArray(6))
        }
    }
}

#endif
#endif

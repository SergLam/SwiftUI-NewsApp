//
//  SearchView.swift
//  stocks
//
//  Created by Mohammad Azam on 12/22/19.
//  Copyright © 2019 Mohammad Azam. All rights reserved.
//

import SwiftUI

struct SearchView: View {
    
    @Binding var searchTerm: String
    
    var body: some View {
        HStack {
            Spacer()
            Image(systemName: "magnifyingglass")
            
            TextField("Search", text: self.$searchTerm)
                .font(.largeTitle)
                .foregroundColor(Color.primary)
                .padding(10)
            
            Spacer()
        }.foregroundColor(.secondary)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(10)
            .padding(10)
    }
}

#if DEBUG
#if targetEnvironment(simulator)

// MARK: - Preview
struct SearchView_Previews: PreviewProvider {
    
    static var devices = AppConstants.previewDevices
    
    static var platform: PreviewPlatform? {
        return SwiftUI.PreviewPlatform.iOS
    }
    
    static var previews: some View {
        SearchView(searchTerm: .constant(""))
    }
}

#endif
#endif

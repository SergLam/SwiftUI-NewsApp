//
//  AlertButtonView.swift
//  NewsApp
//
//  Created by Serhii Liamtsev on 3/13/22.
//  Copyright © 2022 Serhii Liamtsev. All rights reserved.
//

import SwiftUI

struct AlertButtonView: View {
    
    // Show-hide alert flag
    @Binding var shown: Bool
    // Selected / pressed alert action
    @State var action: AlertAction? = nil
    // Action to be shown by button
    var buttonTitle: AlertAction
    
    var body: some View {
        Button(buttonTitle.title) {
            action = buttonTitle
            shown.toggle()
        }.frame(width: UIScreen.main.bounds.width / 2 - 30, height: 40)
        .foregroundColor(.white)
    }
}

#if DEBUG
#if targetEnvironment(simulator)

// MARK: - Preview
struct AlertButtonView_Previews: PreviewProvider {
    
    static var devices = AppConstants.previewDevices
    
    static var platform: PreviewPlatform? {
        return SwiftUI.PreviewPlatform.iOS
    }
    
    static var previews: some View {
        AlertButtonView(shown: .constant(true), action: nil, buttonTitle: AlertAction.ok)
    }
}

#endif
#endif

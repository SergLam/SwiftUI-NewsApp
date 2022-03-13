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
        GeometryReader { geometry in
            Button(action: {
                action = buttonTitle
                shown.toggle()
            }) {
                Text(buttonTitle.title)
                    .frame(
                        minWidth: (geometry.size.width / 2) - 25,
                        maxWidth: .infinity, minHeight: 44
                    )
                    .font(Font.subheadline.weight(.bold))
                    .background(Color.white).opacity(0.8)
                    .foregroundColor(Color.black)
                    .cornerRadius(12)
                
            }
            .lineLimit(2)
            .multilineTextAlignment(.center)
            .padding([.leading,.trailing], 5)
        }
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

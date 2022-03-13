//
//  AlertView.swift
//  NewsApp
//
//  Created by Serhii Liamtsev on 3/12/22.
//  Copyright © 2022 Serhii Liamtsev. All rights reserved.
//

import SwiftUI

// https://letcreateanapp.com/2021/02/01/custom-alert-view-in-swiftui-xcode-12-1/
struct AlertView: View {
    
    @Binding var shown: Bool
    @State var action: AlertAction? = nil
    var actions: [AlertAction]
    var isSuccess: Bool
    var message: String
    
    var body: some View {
        VStack {
            
            Image(isSuccess ? "alert-success" : "alert-error")
                .resizable()
                .frame(width: 50, height: 50)
                .padding(.top, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            
            Spacer()
            Text(message).foregroundColor(Color.white)
            Spacer()
            Divider()
            Spacer()
            HStack {
                ForEach(actions, id: \.self) {
                    AlertButtonView(shown: $shown, action: action, buttonTitle: $0)
                }
            }
            Spacer()
        }
        .frame(minWidth: .zero, idealWidth: UIScreen.main.bounds.width - 50, maxWidth: UIScreen.main.bounds.width - 50, minHeight: .zero, idealHeight: 180, maxHeight: 180, alignment: Alignment.center)
        .background(Color.black.opacity(0.5))
        .cornerRadius(12)
        .clipped()
    }
}

#if DEBUG
#if targetEnvironment(simulator)

// MARK: - Preview
struct CustomAlert_Previews: PreviewProvider {
    
    static var previews: some View {
        AlertView(shown: .constant(false), action: AlertAction.ok, actions: [.ok, .cancel], isSuccess: false, message: "")
    }
}

#endif
#endif

//
//  AlertView.swift
//  NewsApp
//
//  Created by Serhii Liamtsev on 3/12/22.
//  Copyright © 2022 Serhii Liamtsev. All rights reserved.
//

import SwiftUI

enum AlertAction: Int, CaseIterable {
    
    case ok = 0
    case cancel = 1
}

// https://letcreateanapp.com/2021/02/01/custom-alert-view-in-swiftui-xcode-12-1/
struct AlertView: View {
    
    @Binding var shown: Bool
    @Binding var action: AlertAction?
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
            HStack {
                Button("Close") {
                    action = .cancel
                    shown.toggle()
                }.frame(width: UIScreen.main.bounds.width / 2 - 30, height: 40)
                .foregroundColor(.white)
                
                Button("Ok") {
                    action = .ok
                    shown.toggle()
                }.frame(width: UIScreen.main.bounds.width / 2 - 30, height: 40)
                .foregroundColor(.white)
                
            }
            
        }
        .frame(width: UIScreen.main.bounds.width - 50, height: 200)
        .background(Color.black.opacity(0.5))
        .cornerRadius(12)
        .clipped()
    }
}

struct CustomAlert_Previews: PreviewProvider {
    
    static var previews: some View {
        AlertView(shown: .constant(false), action: .constant(.others), isSuccess: false, message: "")
    }
}

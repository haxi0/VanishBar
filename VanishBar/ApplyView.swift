//
//  ApplyView.swift
//  VanishBar
//
//  Created by Анохин Юрий on 30.01.2023.
//

import SwiftUI

struct ApplyView: View {
    @State private var isModApplied = false
    let statusBarVisibilityController = StatusBarVisibilityController.shared
    
    var body: some View {
        
        Spacer()
        
        VStack {
            Image("VanishBar")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .cornerRadius(25)
            
            Text("VanishBar")
                .font(.system(size: 36, weight: .bold))
        }
        
        Spacer()
        
        VStack {
            Button {
                let versionOS = UIDevice.current.systemVersion.prefix(2)
                statusBarVisibilityController.changeStatusBarVisibility(hidden: !isModApplied, versionOS: String(versionOS))
                respring()
            } label: {
                Text(isModApplied ? "Show Status Bar" : "Hide Status Bar")
            }
            .padding()
            .buttonStyle(CustomButtonStyle())
        }
        .onAppear {
            isModApplied = statusBarVisibilityController.isApplied()
        }
        
        HStack {
            Image("iTechExpert")
                .resizable()
                .scaledToFit()
                .frame(width: 25, height: 25)
                .clipShape(Circle())
            Text("Collaboration with @iTechExpert21")
        }
        .padding(10)
        .opacity(0.3)
    }
}

struct ApplyView_Previews: PreviewProvider {
    static var previews: some View {
        ApplyView()
    }
}

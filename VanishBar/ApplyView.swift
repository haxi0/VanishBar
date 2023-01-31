//
//  ApplyView.swift
//  VanishBar
//
//  Created by Анохин Юрий on 30.01.2023.
//

import SwiftUI

struct ApplyView: View {
    @State private var checkOutput = Bool()
    
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
                DispatchQueue.global(qos: .userInteractive).async {
                    let versionOS = UIDevice.current.systemVersion.prefix(2)
                    hideStatusBar(status: checkFile(), versionOS: String(versionOS))
                }
                DispatchQueue.main.async {
                    respring()
                }
            } label: {
                Text(checkOutput ? "Status Bar will be shown" : "Status Bar will be hidden")
            }
            .padding()
            .buttonStyle(CustomButtonStyle())
        }
        .onAppear {
            DispatchQueue.global(qos: .userInteractive).async {
                grantAccess()
            }
            DispatchQueue.main.async {
                checkOutput = checkFile()
            }
        }
        
        HStack {
            Image("iTechExpert")
                .resizable()
                .scaledToFit()
                .frame(width: 25, height: 25)
                .clipShape(Circle())
                .opacity(0.3)
            Text("Collaboration with @iTechExpert21")
                .opacity(0.3)
        }
    }
}

struct ApplyView_Previews: PreviewProvider {
    static var previews: some View {
        ApplyView()
    }
}

//
//  VanishBarApp.swift
//  VanishBar
//
//  Created by Анохин Юрий on 30.01.2023.
//

import SwiftUI

@main
struct VanishBarApp: App {
    var body: some Scene {
        WindowGroup {
            ApplyView()
                .onAppear {
                    checkNewVersions()
                    checkAndEscape()
                }
        }
    }
    
    func checkAndEscape() {
#if targetEnvironment(simulator)
#else
        var supported = false
        if #available(iOS 16.2, *) {
            supported = false
        } else if #available(iOS 16.0, *) {
            supported = true
        } else if #available(iOS 15.7.2, *) {
            supported = false
        } else if #available(iOS 15.0, *) {
            supported = true
        }
        
        if !supported {
            UIApplication.shared.alert(title: "Not Supported", body: "This version of iOS is not supported.")
            return
        }
        
        do {
            // Check if application is entitled
            try FileManager.default.contentsOfDirectory(at: URL(fileURLWithPath: "/var/mobile"), includingPropertiesForKeys: nil)
        } catch {
            // Use MacDirtyCOW to gain r/w
            grant_full_disk_access() { error in
                if (error != nil) {
                    UIApplication.shared.alert(body: "\(String(describing: error?.localizedDescription))\nPlease close the app and retry.", withButton: false)
                    return
                }
            }
        }
#endif
    }
    
    func checkNewVersions() {
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String, let url = URL(string: "https://api.github.com/repos/haxi0/VanishBar/releases/latest") {
            let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
                guard let data = data else { return }
                
                if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    if (json["tag_name"] as? String)?.compare(version, options: .numeric) == .orderedDescending {
                        UIApplication.shared.confirmAlert(title: "Update Available", body: "A new version of VanishBar is available. It is recommended you update to avoid encountering bugs. Would you like to view the releases page?", onOK: {
                            UIApplication.shared.open(URL(string: "https://github.com/haxi0/VanishBar/releases/latest")!)
                        }, noCancel: false)
                    }
                }
            }
            task.resume()
        }
    }
}

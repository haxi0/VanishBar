//
//  HiderFuncs.swift
//  VanishBar
//
//  Created by Анохин Юрий on 30.01.2023.
//

import Foundation

func hideStatusBar(status: Bool, versionOS: String) {
    let fm = FileManager.default
    let overrideFile = Bundle.main.url(forResource: "statusBarOverrides\(versionOS)", withExtension: nil)
    
    do {
        if status == false {
            try fm.createFile(atPath: "/var/mobile/Library/SpringBoard/statusBarOverrides", contents: Data(contentsOf: overrideFile!))
        } else {
            try fm.removeItem(atPath: "/var/mobile/Library/SpringBoard/statusBarOverrides")
        }
    } catch {
        print("failed!")
    }
}

func checkFile() -> Bool {
    let fm = FileManager.default
    
    if fm.fileExists(atPath: "/var/mobile/Library/SpringBoard/statusBarOverrides") {
        return true
    } else {
        return false
    }
}

func grantAccess() {
    grant_full_disk_access() { error in
        print(error?.localizedDescription as Any)
    }
}

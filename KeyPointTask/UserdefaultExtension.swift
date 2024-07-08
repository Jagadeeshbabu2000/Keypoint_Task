//
//  UserdefaultExtension.swift
//  KeyPointTask
//
//  Created by Jagadeesh on 05/07/24.
//

import Foundation

extension UserDefaults {
    var isFirstLaunch: Bool {
        get {
            if let _ = UserDefaults.standard.string(forKey: "isFirstLaunch") {
                return false
            } else {
                UserDefaults.standard.set("isFirstLaunch", forKey: "isFirstLaunch")
                return true
            }
        }
    }
}

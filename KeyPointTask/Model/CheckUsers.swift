//
//  NetworkingManager.swift
//  KeyPointTask
//
//  Created by Jagadeesh on 05/07/24.
//

import Foundation
import UIKit

class Core{
    
    static let shared = Core()
    
    func isNewUser() -> Bool{
        return !UserDefaults.standard.bool(forKey: "isNewUser")
    }
    
    func notNewUser(){
        UserDefaults.standard.set(true, forKey: "isNewUser")
    }
}

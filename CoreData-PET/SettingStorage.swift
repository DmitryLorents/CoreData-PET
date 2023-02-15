//
//  SettingStorage.swift
//  CoreData-PET
//
//  Created by Mac on 15.02.2023.
//

import Foundation
import UIKit

enum UserDefaultsValue: String {
    case  imageIsVisible
    case backgroungdColor
    case tableSeparatorsIsActive
}

class SettingStorage {
    
    static let instance = SettingStorage()
    let defaults = UserDefaults.standard
    
    var imageIsVisible: Bool!
    var backgroungdColor: String!
    var tableSeparatorsIsActive: Bool!
    
    required init() {
        if let imageIsvisible = defaults.object(forKey: UserDefaultsValue.imageIsVisible.rawValue) as? Bool {
            self.imageIsVisible = imageIsvisible
        } else { self.imageIsVisible = true }
            
        if let backgroungdColor = defaults.object(forKey: UserDefaultsValue.backgroungdColor.rawValue) as? String {
            self.backgroungdColor = backgroungdColor
        } else { backgroungdColor = "white" }
        
        if let tableSeparatorsIsActive = defaults.object(forKey: UserDefaultsValue.tableSeparatorsIsActive.rawValue) as? Bool {
            self.tableSeparatorsIsActive = tableSeparatorsIsActive
        } else { tableSeparatorsIsActive = true}
        
    }
    
}

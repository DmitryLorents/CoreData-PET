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
enum Colors: String {
    case white, cyan, yellow
}

class SettingStorage {
    
    static let instance = SettingStorage()
    let defaults = UserDefaults.standard
    
    var imageIsVisible: Bool!
    var backgroungdColor: String!
    var tableSeparatorsIsActive: Bool!
    
    required init() {
        
        //initialisation during start
        
        if let imageIsVisible = defaults.object(forKey: UserDefaultsValue.imageIsVisible.rawValue) as? Bool {
            self.imageIsVisible = imageIsVisible
        } else { self.imageIsVisible = true }
            
        if let backgroungdColor = defaults.object(forKey: UserDefaultsValue.backgroungdColor.rawValue) as? String {
            self.backgroungdColor = backgroungdColor
        } else { backgroungdColor = Colors.white.rawValue }
        
        if let tableSeparatorsIsActive = defaults.object(forKey: UserDefaultsValue.tableSeparatorsIsActive.rawValue) as? Bool {
            self.tableSeparatorsIsActive = tableSeparatorsIsActive
        } else { tableSeparatorsIsActive = true}
        
    }
    
}

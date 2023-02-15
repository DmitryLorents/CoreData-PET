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
        
        
    }
    
}

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
    var backgroungdColor: Colors!
    var tableSeparatorsIsActive: Bool!
    
    public func setView(view: UIView, tableView: UITableView?, imageIsVisible: inout Bool?) {
        //set background color
        switch backgroungdColor {
        case .white:
            view.backgroundColor = .white
            tableView?.backgroundColor = .white
        case .cyan:
            view.backgroundColor = .cyan
            tableView?.backgroundColor = .cyan
        case .yellow :
            view.backgroundColor = .yellow
            tableView?.backgroundColor = .yellow
        default:
            view.backgroundColor = .white
            tableView?.backgroundColor = .white
        }
        
        // set visability of image
        imageIsVisible = self.imageIsVisible
        tableView?.reloadData()
        
        //set separator type
        if tableSeparatorsIsActive {
            tableView?.separatorStyle = .singleLine
        } else {
            tableView?.separatorStyle = .none
        }
    }
    
    required init() {
        
        //initialisation during start
        
        if let imageIsVisible = defaults.object(forKey: UserDefaultsValue.imageIsVisible.rawValue) as? Bool {
            self.imageIsVisible = imageIsVisible
        } else { self.imageIsVisible = true }
            
        if let backgroungdColor = defaults.object(forKey: UserDefaultsValue.backgroungdColor.rawValue) as? String {
            self.backgroungdColor = Colors.init(rawValue: backgroungdColor)
        } else { backgroungdColor = Colors.white }
        
        if let tableSeparatorsIsActive = defaults.object(forKey: UserDefaultsValue.tableSeparatorsIsActive.rawValue) as? Bool {
            self.tableSeparatorsIsActive = tableSeparatorsIsActive
        } else { tableSeparatorsIsActive = true}
        
    }
    
}

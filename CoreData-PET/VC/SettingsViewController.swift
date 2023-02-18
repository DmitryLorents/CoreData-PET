//
//  SettingsViewController.swift
//  CoreData-PET
//
//  Created by Mac on 15.02.2023.
//

import UIKit

class SettingsViewController: UIViewController {
    
    

    @IBOutlet weak var tableViewSeettings: UITableView!
    var separatorSwitch: UISwitch!
    var imageSwitch: UISwitch!
    var segmentedControlColor: UISegmentedControl!
    var emptyBool: Bool?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewSeettings.layer.cornerRadius = 15
        tableViewSeettings.delegate = self
        tableViewSeettings.dataSource = self
        tableViewSeettings.register(UINib(nibName: "FirstTableViewCell", bundle: nil), forCellReuseIdentifier: "firstTypeCell")
        tableViewSeettings.register(UINib(nibName: "SecondTableViewCell", bundle: nil), forCellReuseIdentifier: "secondTypeCell")
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        SettingStorage.instance.setView(view: self.view, tableView: tableViewSeettings, imageIsVisible: &emptyBool)
       
    }
    //MARK: - Methods
    
    fileprivate func setSegmentedControlColor() {
        //set segmeented control initial state
        switch SettingStorage.instance.backgroungdColor {
        case .white:
            segmentedControlColor.selectedSegmentIndex = 0
        case .cyan:
            segmentedControlColor.selectedSegmentIndex = 1
        case .yellow:
            segmentedControlColor.selectedSegmentIndex = 2
        default:
            segmentedControlColor.selectedSegmentIndex = 0
        }
    }
    
    @objc func segmentedControlAction(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            SettingStorage.instance.backgroungdColor = .white
            self.view.backgroundColor = .white
            SettingStorage.instance.defaults.set(Colors.white.rawValue, forKey: UserDefaultsValue.backgroungdColor.rawValue)
        case 1:
            SettingStorage.instance.backgroungdColor = .cyan
            self.view.backgroundColor = .cyan
            SettingStorage.instance.defaults.set(Colors.cyan.rawValue, forKey: UserDefaultsValue.backgroungdColor.rawValue)
        case 2:
            SettingStorage.instance.backgroungdColor = .yellow
            self.view.backgroundColor = .yellow
            SettingStorage.instance.defaults.set(Colors.yellow.rawValue, forKey: UserDefaultsValue.backgroungdColor.rawValue)
        default:
            print("Invalid number of Color segment index")
            break
        }
        
    }
    
    @objc func switchAction(sender: UISwitch) {
        if sender == separatorSwitch {
            switch sender.isOn {
            case true:
               tableViewSeettings.separatorStyle = .singleLine
                SettingStorage.instance.tableSeparatorsIsActive = true
                SettingStorage.instance.defaults.set(true, forKey: UserDefaultsValue.tableSeparatorsIsActive.rawValue)
            case false:
               tableViewSeettings.separatorStyle = .none
                SettingStorage.instance.tableSeparatorsIsActive = false
                SettingStorage.instance.defaults.set(false, forKey: UserDefaultsValue.tableSeparatorsIsActive.rawValue)
            }
        }
        
        if sender == imageSwitch {
            switch sender.isOn {
            case true:
                SettingStorage.instance.imageIsVisible = true
                SettingStorage.instance.defaults.set(true, forKey: UserDefaultsValue.imageIsVisible.rawValue)
            case false:
                SettingStorage.instance.imageIsVisible = false
                SettingStorage.instance.defaults.set(false, forKey: UserDefaultsValue.imageIsVisible.rawValue)
            }
        }
    }

}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "firstTypeCell") as! FirstTableViewCell
            cell.labelTF.text = "Image is visible"
            cell.switchSetting.isOn = SettingStorage.instance.imageIsVisible
            imageSwitch = cell.switchSetting
            imageSwitch.addTarget(self, action: #selector(switchAction(sender:)), for: .valueChanged)
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "firstTypeCell") as! FirstTableViewCell
            cell.labelTF.text = "Separator is visible"
            cell.switchSetting.isOn = SettingStorage.instance.tableSeparatorsIsActive
            separatorSwitch = cell.switchSetting
            separatorSwitch.addTarget(self, action: #selector(switchAction(sender:)), for: .valueChanged)
    
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "secondTypeCell") as! SecondTableViewCell
            cell.label.text = "Background"
            segmentedControlColor = cell.segmentedControl
            segmentedControlColor.addTarget(self, action: #selector(segmentedControlAction(sender:)), for: .valueChanged)
            setSegmentedControlColor()
            return cell
        default: return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
}

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewSeettings.layer.cornerRadius = 20
        tableViewSeettings.delegate = self
        tableViewSeettings.dataSource = self
        tableViewSeettings.register(UINib(nibName: "FirstTableViewCell", bundle: nil), forCellReuseIdentifier: "firstTypeCell")
        tableViewSeettings.register(UINib(nibName: "SecondTableViewCell", bundle: nil), forCellReuseIdentifier: "secondTypeCell")
        
    }
    @objc func switchAction(sender: UISwitch) {
        print("You are fucking genious")
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
            cell.switchSetting.isOn = true
            imageSwitch = cell.switchSetting
            imageSwitch.addTarget(self, action: #selector(switchAction(sender:)), for: .valueChanged)
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "firstTypeCell") as! FirstTableViewCell
            cell.labelTF.text = "Separator is visible"
            cell.switchSetting.isOn = true
            separatorSwitch = cell.switchSetting
            separatorSwitch.addTarget(self, action: #selector(switchAction(sender:)), for: .valueChanged)
    
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "secondTypeCell") as! SecondTableViewCell
            cell.label.text = "Background"
            return cell
        default: return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
}

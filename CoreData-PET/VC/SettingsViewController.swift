//
//  SettingsViewController.swift
//  CoreData-PET
//
//  Created by Mac on 15.02.2023.
//

import UIKit

class SettingsViewController: UIViewController {
    
    

    @IBOutlet weak var tableViewSeettings: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewSeettings.layer.cornerRadius = 10
        tableViewSeettings.delegate = self
        tableViewSeettings.dataSource = self
        tableViewSeettings.register(UINib(nibName: "FirstTableViewCell", bundle: nil), forCellReuseIdentifier: "firstTypeCell")
        

    }
    

}
extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "firstTypeCell") as! FirstTableViewCell
        cell.labelTF.text = "Test"
        cell.switch.isOn = false
        
        
        return cell
    }
}

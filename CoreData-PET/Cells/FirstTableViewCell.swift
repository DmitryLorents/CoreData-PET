//
//  FirstTableViewCell.swift
//  CoreData-PET
//
//  Created by Mac on 18.02.2023.
//

import UIKit

class FirstTableViewCell: UITableViewCell {
    
    @IBOutlet weak var labelTF: UILabel!
    @IBOutlet weak var switchSetting: UISwitch!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

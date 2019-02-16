//
//  RegistrationTableViewCell.swift
//  surechigaiApp
//
//  Created by 川村周也 on 2019/02/16.
//  Copyright © 2019 川村周也. All rights reserved.
//

import UIKit

class RegistrationTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var inputTF: UITextField!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

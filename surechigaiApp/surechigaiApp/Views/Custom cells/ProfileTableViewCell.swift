//
//  ProfileTableViewCell.swift
//  surechigaiApp
//
//  Created by 川村周也 on 2019/02/17.
//  Copyright © 2019 川村周也. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var birthDayTF: DatePickerTextField!
    @IBOutlet weak var birthPlaceTF: UITextField!
    @IBOutlet weak var handleTF: UITextField!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

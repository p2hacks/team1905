//
//  ProfileTableViewCell.swift
//  surechigaiApp
//
//  Created by 川村周也 on 2019/02/17.
//  Copyright © 2019 川村周也. All rights reserved.
//

import UIKit

// 追加
protocol InputTextTableCellDelegate {
    func textFieldDidEndEditing(cell: ProfileTableViewCell, value: NSString) -> ()
}

class ProfileTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var birthDayTF: DatePickerTextField!
    @IBOutlet weak var birthPlaceTF: UITextField!
    @IBOutlet weak var handleTF: UITextField!
    
    var delegate: InputTextTableCellDelegate! = nil

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        birthDayTF.setup()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    internal func textFieldDidEndEditing(textField: UITextField) {
        self.delegate.textFieldDidEndEditing(self, value: textField.text!)
    }

}

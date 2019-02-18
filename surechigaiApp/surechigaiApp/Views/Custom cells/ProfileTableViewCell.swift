//
//  ProfileTableViewCell.swift
//  surechigaiApp
//
//  Created by 川村周也 on 2019/02/17.
//  Copyright © 2019 川村周也. All rights reserved.
//

import UIKit
import RealmSwift

class ProfileTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var birthDayTF: DatePickerTextField!
    @IBOutlet weak var birthPlaceTF: UITextField!
    @IBOutlet weak var handleTF: UITextField!
    
    let realm = try! Realm()
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setTF(){
        let results = realm.objects(Profile.self)
        
        nameTF.text = results[0].name
        birthDayTF.text = results[0].birthDay
        birthPlaceTF.text = results[0].birthplace
        handleTF.text = results[0].handle
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

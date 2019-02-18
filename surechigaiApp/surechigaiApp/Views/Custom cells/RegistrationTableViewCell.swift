//
//  RegistrationTableViewCell.swift
//  surechigaiApp
//
//  Created by 川村周也 on 2019/02/16.
//  Copyright © 2019 川村周也. All rights reserved.
//

import UIKit
import RealmSwift

class RegistrationTableViewCell: UITableViewCell {

    @IBOutlet weak var studentNumberTF: UITextField!
    @IBOutlet weak var gradeTF: PickerTextField!
    @IBOutlet weak var courseTF: PickerTextField!
    @IBOutlet weak var firstClassTF: PickerTextField!
    @IBOutlet weak var clubTF: UITextField!
    
    let realm = try! Realm()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    func setTF(){
        let results = realm.objects(Profile.self)
        
        studentNumberTF.text = results[0].student_number
        gradeTF.text = results[0].grade
        courseTF.text = results[0].course
        clubTF.text = results[0].club

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

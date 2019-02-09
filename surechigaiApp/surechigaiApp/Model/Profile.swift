//
//  Profile.swift
//  surechigaiApp
//
//  Created by 川村周也 on 2019/02/10.
//  Copyright © 2019 川村周也. All rights reserved.
//

import Foundation
import RealmSwift

class Profile : Object {
    
    dynamic var id = 0
    dynamic var handle = ""
    dynamic var name = ""
    dynamic var grade = 0
    dynamic var club = ""
    dynamic var part_of_class = ""
    dynamic var course = ""
    dynamic var student_number = ""
    dynamic var birthplace = ""
    dynamic var birthDay = ""
    
    
    // idをプライマリキーに設定
    override static func primaryKey() -> String? {
        return "id"
    }
    
}

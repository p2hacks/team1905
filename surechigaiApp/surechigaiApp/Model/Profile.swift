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
    
    @objc dynamic var id = ""
    @objc dynamic var handle = ""
    @objc dynamic var name = ""
    @objc dynamic var grade = 0
    @objc dynamic var club = ""
    @objc dynamic var part_of_class = ""
    @objc dynamic var course = ""
    @objc dynamic var student_number = ""
    @objc dynamic var birthplace = ""
    @objc dynamic var birthDay = ""
    
    
    // idをプライマリキーに設定
    override static func primaryKey() -> String? {
        return "id"
    }
    
}

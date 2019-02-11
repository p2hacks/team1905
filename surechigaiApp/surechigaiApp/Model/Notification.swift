//
//  Notification.swift
//  surechigaiApp
//
//  Created by 川村周也 on 2019/02/10.
//  Copyright © 2019 川村周也. All rights reserved.
//

import Foundation
import RealmSwift

class Notification : Object {
    
    @objc dynamic var id = ""
    @objc dynamic var type = ""
    @objc dynamic var title = ""
    @objc dynamic var text = ""
    @objc dynamic var organization = ""
    @objc dynamic var representative_name = ""
    @objc dynamic var representative_contact = ""
    @objc dynamic var representative_student_number = ""
    @objc dynamic var started_at_to_i = ""
    @objc dynamic var created_at_to_i = ""
    @objc dynamic var create_student_number = ""
    
    // idをプライマリキーに設定
    override static func primaryKey() -> String? {
        return "id"
    }
    
}

//
//  Notification.swift
//  surechigaiApp
//
//  Created by 川村周也 on 2019/02/10.
//  Copyright © 2019 川村周也. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class Notification : Object, NSCoding {
    
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
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.id, forKey: "ID")
        aCoder.encode(self.type, forKey: "TYPE")
        aCoder.encode(self.title, forKey: "TITLE")
        aCoder.encode(self.text, forKey: "TEXT")
        aCoder.encode(self.organization, forKey: "ORGANIZATION")
        aCoder.encode(self.representative_name, forKey: "REPRESENTATIVE_NAME")
        aCoder.encode(self.representative_contact, forKey: "REPRESENTATIVE_CONTACT")
        aCoder.encode(self.started_at_to_i, forKey: "STARTED_AT_TO_I")
        aCoder.encode(self.created_at_to_i, forKey: "CREATED_AT_TO_I")
        aCoder.encode(self.create_student_number, forKey: "CREATE_STUDENT_NUMBER")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init()
        self.id = aDecoder.decodeObject(forKey: "ID") as! String
        self.type = aDecoder.decodeObject(forKey: "TYPE") as! String
        self.title = aDecoder.decodeObject(forKey: "TITLE") as! String
        self.text = aDecoder.decodeObject(forKey: "TEXT") as! String
        self.organization = aDecoder.decodeObject(forKey: "ORGANIZATION") as! String
        self.representative_name = aDecoder.decodeObject(forKey: "REPRESENTATIVE_NAME") as! String
        self.representative_contact = aDecoder.decodeObject(forKey: "REPRESENTATIVE_CONTACT") as! String
        self.started_at_to_i = aDecoder.decodeObject(forKey: "STARTED_AT_TO_I") as! String
        self.created_at_to_i = aDecoder.decodeObject(forKey: "CREATED_AT_TO_I") as! String
        self.create_student_number = aDecoder.decodeObject(forKey: "CREATE_STUDENT_NUMBER") as! String
    }
    
    required init() {
        super.init()
        self.id = ""
        self.type = ""
        self.title = ""
        self.text = ""
        self.organization = ""
        self.representative_name = ""
        self.representative_contact = ""
        self.started_at_to_i = ""
        self.created_at_to_i = ""
        self.create_student_number = ""
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
    
    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    
}

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
    @objc dynamic var lecture_name = ""
    @objc dynamic var professor_name = ""
    @objc dynamic var textBook = ""
    @objc dynamic var event_name = ""
    @objc dynamic var event_place = ""
    @objc dynamic var event_bringThing = ""
    @objc dynamic var organization = ""
    @objc dynamic var wages = ""
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
        aCoder.encode(self.lecture_name, forKey: "LECTURE_NAME")
        aCoder.encode(self.professor_name, forKey: "PROFESSOR_NAME")
        aCoder.encode(self.textBook, forKey: "TEXTBOOK")
        aCoder.encode(self.event_name, forKey: "EVENT_NAME")
        aCoder.encode(self.event_place, forKey: "EVENT_PLACE")
        aCoder.encode(self.event_bringThing, forKey: "EVENT_BRINGTHING")
        aCoder.encode(self.organization, forKey: "ORGANIZATION")
        aCoder.encode(self.wages, forKey: "WAGES")
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
        self.lecture_name = aDecoder.decodeObject(forKey: "LECTURE_NAME") as! String
        self.professor_name = aDecoder.decodeObject(forKey: "PROFESSOR_NAME") as! String
        self.textBook = aDecoder.decodeObject(forKey: "TEXTBOOK") as! String
        self.event_name = aDecoder.decodeObject(forKey: "EVENT_NAME") as! String
        self.event_place = aDecoder.decodeObject(forKey: "EVENT_PLACE") as! String
        self.event_bringThing = aDecoder.decodeObject(forKey: "EVENT_BRINGTHING") as! String
        self.organization = aDecoder.decodeObject(forKey: "ORGANIZATION") as! String
        self.wages = aDecoder.decodeObject(forKey: "WAGES") as! String
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
        self.lecture_name = ""
        self.professor_name = ""
        self.textBook = ""
        self.event_name = ""
        self.event_place = ""
        self.event_bringThing = ""
        self.organization = ""
        self.id = ""
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

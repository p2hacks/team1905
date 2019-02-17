//
//  Profile.swift
//  surechigaiApp
//
//  Created by 川村周也 on 2019/02/10.
//  Copyright © 2019 川村周也. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class Profile : Object, NSCoding {
    
    @objc dynamic var id = ""
    @objc dynamic var handle = ""
    @objc dynamic var name = ""
    @objc dynamic var grade = ""
    @objc dynamic var club = ""
    @objc dynamic var part_of_class = ""
    @objc dynamic var course = ""
    @objc dynamic var student_number = ""
    @objc dynamic var birthplace = ""
    @objc dynamic var birthDay = ""
    @objc dynamic var recentlyDate = ""
    @objc dynamic var passTime = ""
    
    
    // idをプライマリキーに設定
    override static func primaryKey() -> String? {
        return "id"
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.id, forKey: "ID")
        aCoder.encode(self.handle, forKey: "HANDLE")
        aCoder.encode(self.name, forKey: "NAME")
        aCoder.encode(self.grade, forKey: "GRADE")
        aCoder.encode(self.club, forKey: "CLUB")
        aCoder.encode(self.part_of_class, forKey: "PART_OF_CLASS")
        aCoder.encode(self.course, forKey: "COURCE")
        aCoder.encode(self.student_number, forKey: "STUDENT_NUMBER")
        aCoder.encode(self.birthplace, forKey: "BIRTHPLACE")
        aCoder.encode(self.birthDay, forKey: "BIRTHDAY")
        aCoder.encode(self.recentlyDate, forKey: "RECENTLYDATE")
        aCoder.encode(self.passTime, forKey: "PASSTIME")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init()
        self.id = aDecoder.decodeObject(forKey: "ID") as! String
        self.handle = aDecoder.decodeObject(forKey: "HANDLE") as! String
        self.name = aDecoder.decodeObject(forKey: "NAME") as! String
        self.grade = aDecoder.decodeObject(forKey: "GRADE") as! String
        self.club = aDecoder.decodeObject(forKey: "CLUB") as! String
        self.part_of_class = aDecoder.decodeObject(forKey: "PART_OF_CLASS") as! String
        self.course = aDecoder.decodeObject(forKey: "COURCE") as! String
        self.student_number = aDecoder.decodeObject(forKey: "STUDENT_NUMBER") as! String
        self.birthplace = aDecoder.decodeObject(forKey: "BIRTHPLACE") as! String
        self.birthDay = aDecoder.decodeObject(forKey: "BIRTHDAY") as! String
        self.recentlyDate = aDecoder.decodeObject(forKey: "RECENTLYDATE") as! String
        self.passTime = aDecoder.decodeObject(forKey: "PASSTIME") as! String
    }
    
    required init() {
        super.init()
        self.id = ""
        self.handle = ""
        self.name = ""
        self.grade = ""
        self.club = ""
        self.part_of_class = ""
        self.course = ""
        self.student_number = ""
        self.birthplace = ""
        self.birthDay = ""
        self.recentlyDate = ""
        self.passTime = ""
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
    
    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    
}

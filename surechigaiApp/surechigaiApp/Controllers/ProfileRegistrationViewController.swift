//
//  ProfileRegistrationViewController.swift
//  surechigaiApp
//
//  Created by 川村周也 on 2019/02/11.
//  Copyright © 2019 川村周也. All rights reserved.
//

import UIKit
import RealmSwift

enum pickerType {
    case course
    case firstClass
    case grade
    case birthDay
}

// Todo: 各TextFieldの規定外bの入力があった時のアラート

class ProfileRegistrationViewController: UIViewController {
    
    let SET_TEXT_ERROR: String = "error: Realmのデータが空ですが、setTextが呼ばれています"
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var studentNumberTF: UITextField!
    @IBOutlet weak var birthDayTF: DatePickerTextField!
    @IBOutlet weak var birthPlaceTF: UITextField!
    @IBOutlet weak var courseTF: PickerTextField!
    @IBOutlet weak var firstClassTF: PickerTextField!
    @IBOutlet weak var handleTF: UITextField!
    @IBOutlet weak var clubTF: UITextField!
    @IBOutlet weak var gradeTF: PickerTextField!
    
    let realm = try! Realm()
    var profile: Profile = Profile()
    
    let courseList: [String] = ["", "情報システム", "デザイン", "知能システム", "複雑系", "高度ICT"]
    let firstClassList: [String] = ["", "前半", "中間", "後半"]
    let degreeList: [String] = ["", "学部", "院"]
    let gradeList: [String] = ["", "１", "2", "3", "4"]
    
    var defaultCourse_row: Int = 0
    var defaultFirstClass_row: Int = 0
    var defaultDegree_row: Int = 0
    var defaultGrade_row: Int = 0
    
    var isFirstResistration: Bool = true
    
    
    @IBAction func onTapRegistrationBtn(_ sender: Any) {
        profile.name = nameTF.text!
        profile.student_number = studentNumberTF.text!
        profile.birthDay = birthDayTF.text!
        profile.birthplace = birthPlaceTF.text!
        profile.course = courseTF.text!
        profile.part_of_class = firstClassTF.text!
        profile.handle = handleTF.text!
        profile.club = clubTF.text!
        profile.grade = gradeTF.text!
        
        if isFirstResistration {
            createProfile(data: profile)
            self.performSegue(withIdentifier: "toMain", sender: nil)
        } else {
            updateProfile(data: profile)
            navigationController?.popViewController(animated: true)
        }
        
        //navigationController?.popViewController(animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let results = realm.objects(Profile.self)
        
        if results.isEmpty {
            isFirstResistration = true
        } else {
            isFirstResistration = false
            setTextFields()
            
            birthDayTF.setup()
           
            courseTF.setup(dataList2: courseList)
            firstClassTF.setup(dataList2: firstClassList)
            gradeTF.setup(dataList1: degreeList, dataList2: gradeList)
        }
        
    }
    
    // Realm操作系の処理
    
    func createProfile(data: Profile) {
        // プライマリーキーをユニークな文字列で生成
        data.id = NSUUID().uuidString
        
        try! realm.write {
            realm.add(data)
        }
    }
    
    func updateProfile(data: Profile) {
        
        let results = realm.objects(Profile.self)
        
        try! realm.write {
            results[0].name = data.name
            results[0].student_number = data.student_number
            results[0].birthDay = data.birthDay
            results[0].birthplace = data.birthplace
            results[0].course = data.course
            results[0].part_of_class = data.part_of_class
            results[0].club = data.club
            results[0].grade = data.grade
            results[0].handle = data.handle
        }
    }
  
    //
    func setTextFields() {
        let results = realm.objects(Profile.self)
        
        guard results.isEmpty else {
            nameTF.text = results[0].name
            studentNumberTF.text = results[0].student_number
            birthDayTF.text = results[0].birthDay
            birthPlaceTF.text = results[0].birthplace
            courseTF.text = results[0].course
            firstClassTF.text = results[0].part_of_class
            handleTF.text = results[0].handle
            clubTF.text = results[0].club
            gradeTF.text = results[0].grade
            
            var degree: String = ""
            var grade: String = ""
            
            if results[0].grade != ""{
                degree = String(results[0].grade.prefix(results[0].grade.count - 2))
                grade = String(results[0].grade.suffix(2).prefix(1))
            }
            
            
            
            let defaultCourse_row = courseList.index(of: results[0].course)!
            let defaultFirstClass_row = firstClassList.index(of: results[0].part_of_class)!
            let defaultDegree_row = degreeList.index(of: degree)!
            let defaultGrade_row = gradeList.index(of: grade)!
            
            courseTF.setTextFields(default_row: defaultCourse_row)
            firstClassTF.setTextFields(default_row: defaultFirstClass_row)
            gradeTF.setTextFields(default_row: defaultDegree_row, degree_row: defaultGrade_row)
            gradeTF.setTextFields(default_row: defaultDegree_row)
            
            return
        }
        
        print(SET_TEXT_ERROR)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

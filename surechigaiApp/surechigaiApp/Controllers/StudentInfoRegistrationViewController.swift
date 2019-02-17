//
//  StudentInfoRegistrationViewController.swift
//  surechigaiApp
//
//  Created by 川村周也 on 2019/02/17.
//  Copyright © 2019 川村周也. All rights reserved.
//

import UIKit
import RealmSwift

class StudentInfoRegistrationViewController: UIViewController {

    @IBOutlet weak var inputTable: UITableView!
    
    let SET_TEXT_ERROR: String = "error: Realmのデータが空ですが、setTextが呼ばれています"
    
    @IBOutlet weak var studentNumberTF: UITextField!
    @IBOutlet weak var courseTF: PickerTextField!
    @IBOutlet weak var firstClassTF: PickerTextField!
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
        
        profile.student_number = studentNumberTF.text!
        profile.course = courseTF.text!
        profile.part_of_class = firstClassTF.text!
        profile.club = clubTF.text!
        profile.grade = gradeTF.text!
        
        
            updateProfile(data: profile)
            self.performSegue(withIdentifier: "toMain", sender: nil)
        
        //navigationController?.popViewController(animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let results = realm.objects(Profile.self)
        inputTable.delegate = self
        inputTable.dataSource = self
        //inputTable.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        if results.isEmpty {
            isFirstResistration = true
        } else {
            isFirstResistration = false
        }
        
        setTextFields()
        
        courseTF.setup(dataList2: courseList)
        firstClassTF.setup(dataList2: firstClassList)
        gradeTF.setup(dataList1: degreeList, dataList2: gradeList)
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
            studentNumberTF.text = results[0].student_number
            courseTF.text = results[0].course
            firstClassTF.text = results[0].part_of_class
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension StudentInfoRegistrationViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0: // 学籍番号 "student_number"
            let cell = tableView.dequeueReusableCell(withIdentifier: "student_number", for: indexPath) as UITableViewCell
            return cell
        case 1: // 学年 "grade"
            let cell = tableView.dequeueReusableCell(withIdentifier: "student_number", for: indexPath) as UITableViewCell
            return cell
        case 2: // コース "course"
            let cell = tableView.dequeueReusableCell(withIdentifier: "student_number", for: indexPath) as UITableViewCell
            return cell
        case 3: // 一年次クラス　"sfirst_class"
            let cell = tableView.dequeueReusableCell(withIdentifier: "student_number", for: indexPath) as UITableViewCell
            return cell
        case 4: // サークル　"club"
            let cell = tableView.dequeueReusableCell(withIdentifier: "student_number", for: indexPath) as UITableViewCell
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "student_number", for: indexPath) as UITableViewCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    
}

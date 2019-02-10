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
}

class ProfileRegistrationViewController: UIViewController {
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var studentNumberTF: UITextField!
    @IBOutlet weak var birthDayTF: UITextField!
    @IBOutlet weak var birthPlaceTF: UITextField!
    @IBOutlet weak var courseTF: UITextField!
    @IBOutlet weak var firstClassTF: UITextField!
    @IBOutlet weak var handleTF: UITextField!
    @IBOutlet weak var clubTF: UITextField!
    @IBOutlet weak var gradeTF: UITextField!
    
    var coursePickerView: UIPickerView = UIPickerView()
    var firstClassPickerView: UIPickerView = UIPickerView()
    var gradePickerView: UIPickerView = UIPickerView()
    
    let realm = try! Realm()
    var profile = Profile()
    
    let courseList = ["", "情報システム", "デザイン", "知能システム", "複雑系", "高度ICT"]
    let firstClassList = ["", "前半", "中間", "後半"]
    let degreeList = ["", "学部", "院"]
    let gradeList = ["", "１", "2", "3", "4"]
    
    
    @IBAction func onTapRegistrationBtn(_ sender: Any) {
        profile.name = nameTF.text
        profile.student_number = studentNumberTF.text
        profile.birthDay = birthDayTF.text
        profile.birthplace = birthPlaceTF.text
        profile.course = courseTF.text
        profile.part_of_class = firstClassTF.text
        profile.handle = handleTF.text
        profile.club = clubTF.text
        profile.grade = gradeTF.text
        
        createProfile(data: profile)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coursePickerView.delegate = self
        coursePickerView.dataSource = self
        coursePickerView.showsSelectionIndicator = true
        
        firstClassPickerView.delegate = self
        firstClassPickerView.dataSource = self
        firstClassPickerView.showsSelectionIndicator = true
        
        gradePickerView.delegate = self
        gradePickerView.dataSource = self
        gradePickerView.showsSelectionIndicator = true
        
        initPickerView()
        
    }
    
    func initPickerView() {
        // picker 上のツールバーを高さ38で生成
        let toolbar = UIToolbar(frame: CGRectMake(0, 0, 0, 35))
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(ProfileRegistrationViewController.done))
        let cancelItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(ProfileRegistrationViewController.cancel))
        toolbar.setItems([cancelItem, doneItem], animated: true)
        
        self.courseTF.inputView = coursePickerView
        self.courseTF.inputAccessoryView = toolbar
        
        self.courseTF.inputView = firstClassPickerView
        self.courseTF.inputAccessoryView = toolbar
        
        self.gradeTF.inputView = gradePickerView
        self.courseTF.inputAccessoryView = toolbar
    }
    
    func createProfile (data: Profile) {
        // プライマリーキーをユニークな文字列で生成
        data.id = NSUUID().uuidString
        
        try! realm.write {
            realm.add(data)
        }
    }
    
    func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
        return CGRect(x: x, y: y, width: width, height: height)
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

extension ProfileRegistrationViewController:  UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView == gradePickerView {
            return 2
        } else {
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
            
        case coursePickerView:
            return courseList.count
            
        case firstClassPickerView:
            return firstClassList.count
            
        case gradePickerView:
            if component == 0 {
                return degreeList.count
            } else {
                return gradeList.count
            }
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case coursePickerView:
            return courseList[row]
            
        case firstClassPickerView:
            return firstClassList[row]
            
        case gradePickerView:
            if component == 0 {
                return degreeList[row]
            } else {
                return gradeList[row]
            }
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case coursePickerView:
            self.courseTF.text = courseList[row]
            
        case firstClassPickerView:
            self.firstClassTF.text = firstClassList[row]
            
        case gradePickerView:
            var degree = ""
            var grade = ""
            if component == 0 {
                degree = degreeList[row]
            } else {
                grade = gradeList[row]
            }
            self.gradeTF.text = degree + grade
        }
    }
    
    func cancel() {
        self.textField.text = ""
        self.textField.endEditing(true)
    }
    
    func done() {
        self.textField.endEditing(true)
    }
}

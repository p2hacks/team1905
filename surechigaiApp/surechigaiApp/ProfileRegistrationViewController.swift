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
    @IBOutlet weak var birthDayTF: CustomTextField!
    @IBOutlet weak var birthPlaceTF: UITextField!
    @IBOutlet weak var courseTF: CustomTextField!
    @IBOutlet weak var firstClassTF: CustomTextField!
    @IBOutlet weak var handleTF: UITextField!
    @IBOutlet weak var clubTF: UITextField!
    @IBOutlet weak var gradeTF: CustomTextField!
    
    var coursePickerView: UIPickerView = UIPickerView()
    var firstClassPickerView: UIPickerView = UIPickerView()
    var gradePickerView: UIPickerView = UIPickerView()
    
    let datePicker = UIDatePicker()
    
    let realm = try! Realm()
    var profile: Profile = Profile()
    
    let courseList: [String] = ["", "情報システム", "デザイン", "知能システム", "複雑系", "高度ICT"]
    let firstClassList: [String] = ["", "前半", "中間", "後半"]
    let degreeList: [String] = ["", "学部", "院"]
    let gradeList: [String] = ["", "１", "2", "3", "4"]
    
    var degree: String = ""
    var grade: String = ""
    
    var defaultCourse_row: Int = 0
    var defaultFirstClass_row: Int = 0
    var defaultDegree_row: Int = 0
    var defaultGrade_row: Int = 0
    
    // Datepickerの最小値
    let minDateString: String = "1940/01/01"
     // Datepickerの初期値
    var defaultDateString: String = "1990/01/01"
    var defaultDate = Date()
    
    var pickerFlg: pickerType!
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
        } else {
            updateProfile(data: profile)
        }
        
        navigationController?.popViewController(animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        birthDayTF.delegate = self
        courseTF.delegate = self
        firstClassTF.delegate = self
        gradeTF.delegate = self
        
        coursePickerView.delegate = self
        coursePickerView.dataSource = self
        coursePickerView.showsSelectionIndicator = true
        
        firstClassPickerView.delegate = self
        firstClassPickerView.dataSource = self
        firstClassPickerView.showsSelectionIndicator = true
        
        gradePickerView.delegate = self
        gradePickerView.dataSource = self
        gradePickerView.showsSelectionIndicator = true
        
        let results = realm.objects(Profile.self)
        
        if results.isEmpty {
            isFirstResistration = true
        } else {
            isFirstResistration = false
            setTextFields()
        }
        
        initPickerView()
        initDatePicker()
        
    }
    
    func initPickerView() {
        // picker 上のツールバーを高さ38で生成
        let toolbar = UIToolbar(frame: CGRectMake(0, 0, 0, 35))
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(ProfileRegistrationViewController.done))
        let cancelItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(ProfileRegistrationViewController.cancel))
        toolbar.setItems([cancelItem, doneItem], animated: true)
        
        setDefaultPickerValue()
        
        self.courseTF.inputView = coursePickerView
        self.courseTF.inputAccessoryView = toolbar
        
        self.firstClassTF.inputView = firstClassPickerView
        self.firstClassTF.inputAccessoryView = toolbar
        
        self.gradeTF.inputView = gradePickerView
        self.gradeTF.inputAccessoryView = toolbar
    }
    
    func setDefaultPickerValue() {
        // 初期値を設定する
        coursePickerView.selectRow(defaultCourse_row, inComponent: 0, animated: true)
        firstClassPickerView.selectRow(defaultFirstClass_row, inComponent: 0, animated: true)
        gradePickerView.selectRow(defaultDegree_row, inComponent: 0, animated: true)
        gradePickerView.selectRow(defaultGrade_row, inComponent: 1, animated: true)
    }
    
    func initDatePicker() {
        
        let toolbar = UIToolbar(frame: CGRectMake(0, 0, 0, 35))
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(ProfileRegistrationViewController.done))
        let cancelItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(ProfileRegistrationViewController.cancel))
        toolbar.setItems([cancelItem, doneItem], animated: true)
        
        datePicker.addTarget(self, action: #selector(ProfileRegistrationViewController.datePickerValueChanged(sender:)), for: UIControl.Event.valueChanged)
        
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: "ja")
        
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        
        
        let minDate = dateFormatter.date(from: minDateString)
        
        datePicker.minimumDate = minDate
        datePicker.maximumDate = Date()
        
        defaultDate = dateFormatter.date(from: defaultDateString)!
        
        datePicker.date = defaultDate
        
        birthDayTF.inputView = datePicker
        birthDayTF.inputAccessoryView = toolbar
    }
    
    func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
    //datepickerが選択されたらtextfieldに表示
    @objc func datePickerValueChanged(sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat  = "yyyy/MM/dd";
        birthDayTF.text = dateFormatter.string(from: sender.date)
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
            
            degree = String(results[0].grade.prefix(results[0].grade.count - 2))
            grade = String(results[0].grade.suffix(2).prefix(1))
            
            defaultCourse_row = courseList.index(of: results[0].course)!
            defaultFirstClass_row = firstClassList.index(of: results[0].part_of_class)!
            defaultDegree_row = degreeList.index(of: degree)!
            defaultGrade_row = gradeList.index(of: grade)!
            defaultDateString = results[0].birthDay
            
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

// MARK: - UIPickerViewDelegate, UIPickerViewDataSource
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
        default:
            break
        }
        return 0
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
        default:
            break
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case coursePickerView:
            self.courseTF.text = courseList[row]
            
        case firstClassPickerView:
            self.firstClassTF.text = firstClassList[row]
            
        case gradePickerView:
            if component == 0 {
                degree = degreeList[row]
            } else {
                grade = gradeList[row]
            }
            if degree != "" , grade != ""{
                self.gradeTF.text = degree + grade + "年"
            } else if degree == "" {
                 self.gradeTF.text = ""
                self.gradeTF.placeholder = "学部もしくは院を選択"
            } else if grade == "" {
                 self.gradeTF.text = ""
                self.gradeTF.placeholder = "学年を選択"
            } else {
                self.gradeTF.text = ""
                self.gradeTF.placeholder = "学年"
            }
        default:
            break
        }
    }
    
    @objc func cancel() {
        switch pickerFlg {
        case .birthDay?:
            birthDayTF.text = ""
        case .course?:
            courseTF.text = ""
            defaultCourse_row = 0
        case .firstClass?:
            firstClassTF.text = ""
            defaultFirstClass_row = 0
        case .grade?:
            gradeTF.text = ""
            defaultDegree_row = 0
            defaultGrade_row = 0
        default:
            break
        }
        self.view.endEditing(true)
    }
    
    @objc func done() {
        self.view.endEditing(true)
    }
}

// MARK: - UITextFieldDelegate
extension ProfileRegistrationViewController: UITextFieldDelegate {
    //どの入力欄か判別する
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        setDefaultPickerValue() 
        
        switch textField {
        case birthDayTF:
            pickerFlg = .birthDay
            birthDayTF.text = defaultDateString
            
        case courseTF:
            pickerFlg = .course
            guard courseTF!.text != nil else {
                courseTF.text = courseList[defaultCourse_row]
                return
            }
            
        case firstClassTF:
            pickerFlg = .firstClass
            guard firstClassTF!.text != nil else {
                firstClassTF.text = firstClassList[defaultFirstClass_row]
                return
            }
            
        case gradeTF:
            pickerFlg = .grade
            guard gradeTF!.text != nil else {
                gradeTF.text = degreeList[defaultDegree_row] + gradeList[defaultGrade_row] + "年"
                return
            }
            
        default:
            break
        }
    }
}

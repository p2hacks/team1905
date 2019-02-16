//
//  InputLogic.swift
//  surechigaiApp
//
//  Created by 川村周也 on 2019/02/16.
//  Copyright © 2019 川村周也. All rights reserved.
//

import UIKit
/*
enum pickerType {
    case course
    case firstClass
    case grade
    case birthDay
}*/

// inputView = InputLogic.manager.coursePickerViewと書けば使えるようにしたい。

class InputLogic: NSObject {
    
    static let manager = InputLogic()
    
    private var cancelHandler: (() -> Void)? = nil
    private var doneHandler: (() -> Void)? = nil
    private var datePickerChangeHandler: (() -> Void)? = nil
    private var endEditingHandler: (() -> Void)? = nil
    
    var coursePickerView: UIPickerView = UIPickerView()
    var firstClassPickerView: UIPickerView = UIPickerView()
    var gradePickerView: UIPickerView = UIPickerView()
    let datePicker = UIDatePicker()
    
    var toolbar = UIToolbar()
    
    let courseList: [String] = ["", "情報システム", "デザイン", "知能システム", "複雑系", "高度ICT"]
    let firstClassList: [String] = ["", "前半", "中間", "後半"]
    let degreeList: [String] = ["", "学部", "院"]
    let gradeList: [String] = ["", "１", "2", "3", "4"]
    
    var grade_degree: String = ""
    var grade_year: String = ""
    
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
    
    private override init() {
        super.init()
        
        coursePickerView.delegate = self
        coursePickerView.dataSource = self
        coursePickerView.showsSelectionIndicator = true
        
        firstClassPickerView.delegate = self
        firstClassPickerView.dataSource = self
        firstClassPickerView.showsSelectionIndicator = true
        
        gradePickerView.delegate = self
        gradePickerView.dataSource = self
        gradePickerView.showsSelectionIndicator = true
        
        setToolBar()
        setDefaultPickerValue()
        initDatePicker()
    }
    
    func setMethods(cancelMethod: (() -> Void)? = nil, doneMethod: (() -> Void)? = nil, datePickerChangeMethod: (() -> Void)? = nil, endEditMethod: (() -> Void)? = nil) {
        cancelHandler = cancelMethod
        doneHandler = doneMethod
        datePickerChangeHandler = datePickerChangeMethod
        endEditingHandler = endEditMethod
    }
    
    func setDefaultPickerValue() {
        // 初期値を設定する
        coursePickerView.selectRow(defaultCourse_row, inComponent: 0, animated: true)
        firstClassPickerView.selectRow(defaultFirstClass_row, inComponent: 0, animated: true)
        gradePickerView.selectRow(defaultDegree_row, inComponent: 0, animated: true)
        gradePickerView.selectRow(defaultGrade_row, inComponent: 1, animated: true)
    }
    
    func setToolBar() {
        toolbar = UIToolbar(frame: CGRectMake(0, 0, 0, 35))
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(ProfileRegistrationViewController().done))
        let cancelItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(ProfileRegistrationViewController().cancel))
        toolbar.setItems([cancelItem, doneItem], animated: true)
    }
    
    func initDatePicker() {
        datePicker.addTarget(self, action: #selector(ProfileRegistrationViewController().datePickerValueChanged), for: UIControl.Event.valueChanged)
        
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: "ja")
        
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        
        
        let minDate = dateFormatter.date(from: minDateString)
        
        datePicker.minimumDate = minDate
        datePicker.maximumDate = Date()
        
        defaultDate = dateFormatter.date(from: defaultDateString)!
        
        datePicker.date = defaultDate
        
    }
    
    func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
    @objc func cancel() {
        switch InputLogic.manager.pickerFlg {
        case .birthDay?: break
            //birthDayTF.text = ""
        case .course?:
            //courseTF.text = ""
            defaultCourse_row = 0
        case .firstClass?:
            //firstClassTF.text = ""
            defaultFirstClass_row = 0
        case .grade?:
            //gradeTF.text = ""
            defaultDegree_row = 0
            defaultGrade_row = 0
        default:
            break
        }
        endEditingHandler!()
    }
    
    @objc func done() {
        endEditingHandler!()
    }
    
    //datepickerが選択されたらtextfieldに表示
    @objc func datePickerValueChanged(sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat  = "yyyy/MM/dd";
        ProfileRegistrationViewController().birthDayTF.text = dateFormatter.string(from: sender.date)
    }
    
    
}


// MARK: - UIPickerViewDelegate, UIPickerViewDataSource
extension InputLogic:  UIPickerViewDelegate, UIPickerViewDataSource {
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
        case coursePickerView: break
            //self.courseTF.text = courseList[row]
            
        case firstClassPickerView: break
            //self.firstClassTF.text = firstClassList[row]
            
        case gradePickerView:
            if component == 0 {
                grade_degree = degreeList[row]
            } else {
                grade_year = gradeList[row]
            }
            if grade_degree != "" , grade_year != ""{
                //self.gradeTF.text = grade_degree + grade_year + "年"
            } else if grade_degree == "" {
                //self.gradeTF.text = ""
               // self.gradeTF.placeholder = "学部もしくは院を選択"
            } else if grade_year == "" {
               // self.gradeTF.text = ""
                //self.gradeTF.placeholder = "学年を選択"
            } else {
                //self.gradeTF.text = ""
                //self.gradeTF.placeholder = "学年"
            }
        default:
            break
        }
    }
    
}

/*
// MARK: - UITextFieldDelegate
extension InputLogic: UITextFieldDelegate {
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
}*/



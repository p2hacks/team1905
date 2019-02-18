//
//  PickerTextField.swift
//  surechigaiApp
//
//  Created by 川村周也 on 2019/02/17.
//  Copyright © 2019 川村周也. All rights reserved.
//

import Foundation
import UIKit

class PickerTextField: UITextField {
    
    let picker = UIPickerView()
    
    var dataLists: [[String]] = [[String]]()
    var default_row: Int = 0
    var degree_row: Int = 0
    var grade_degree: String = ""
    var grade_year: String = ""
    
    init() {
        super.init(frame: CGRect.zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setup(dataList1: [String] = [], dataList2: [String]) {
        
        if dataList1.isEmpty {
            
        } else {
            self.dataLists.append(dataList1)
        }
        
        self.dataLists.append(dataList2)
        
        // picker 上のツールバーを高さ38で生成
        let toolbar = UIToolbar(frame: CGRectMake(0, 0, 0, 35))
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        let cancelItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        toolbar.setItems([cancelItem, doneItem], animated: true)
        
        setDefaultPickerValue()
        
        self.delegate = self
        
        picker.delegate = self
        picker.dataSource = self
        picker.showsSelectionIndicator = true
        
        self.inputView = picker
        self.inputAccessoryView = toolbar
    }
    
    func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
    func setDefaultPickerValue() {
        // 初期値を設定する
        picker.selectRow(default_row, inComponent: 0, animated: true)
        if dataLists.count == 1 {
            
        } else {
            picker.selectRow(default_row, inComponent: 1, animated: true)
        }
    }
    
    //
    func setTextFields(default_row: Int, degree_row: Int = 0) {
        self.default_row = default_row
        self.degree_row = degree_row
        if dataLists.count == 1 {
            self.text = dataLists[0][default_row]
        } else {
            self.text = dataLists[1][degree_row]
        }
        
    }
    
    @objc func cancel() {
        self.text = ""
        default_row = 0
        self.endEditing(true)
    }
    
    @objc func done() {
        self.endEditing(true)
    }
}

// MARK: - UIPickerViewDelegate, UIPickerViewDataSource
extension PickerTextField: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return dataLists.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return dataLists[0].count
        } else {
            return dataLists[1].count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return dataLists[0][row]
        } else {
            return dataLists[1][row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if component == 0 {
            self.text = dataLists[0][row]
            grade_degree = dataLists[0][row]
        } else {
            grade_year = dataLists[1][row]
        }
        
        if dataLists.count == 1{
            return
        }
        
        if grade_degree != "" , grade_year != ""{
            self.text = grade_degree + grade_year + "年"
        } else if grade_degree == "",  grade_year != ""{
            self.text = ""
            self.placeholder = "学部もしくは院を選択"
        } else if grade_degree != "" , grade_year == "" {
            self.text = ""
            self.placeholder = "学年を選択"
        } else {
            self.text = ""
            self.placeholder = "学年"
        }
    }
    
}


// MARK: - UITextFieldDelegate
extension PickerTextField: UITextFieldDelegate {
    //どの入力欄か判別する
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        setDefaultPickerValue()
        
        guard self.text != nil else {
            if dataLists.count == 1{
                self.text = dataLists[0][default_row]
            } else {
                self.text = dataLists[0][default_row] + dataLists[1][default_row] + "年"
            }
            return
        }
    }
    
}

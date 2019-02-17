//
//  DatePickerTextField.swift
//  surechigaiApp
//
//  Created by 川村周也 on 2019/02/17.
//  Copyright © 2019 川村周也. All rights reserved.
//

import Foundation
import UIKit

class DatePickerTextField: UITextField {
    // コピー・ペースト・選択等のメニュー非表示
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return false
    }
    
    // Datepickerの最小値
    let minDateString: String = "1940/01/01"
    // Datepickerの初期値
    var defaultDateString: String = "1990/01/01"
    var defaultDate = Date()
    
    let datePicker = UIDatePicker()
    var toolbar = UIToolbar()
    
    init() {
        super.init(frame: CGRect.zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setup() {
        self.delegate = self
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(sender:)), for: UIControl.Event.valueChanged)
        
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: "ja")
        
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        
        
        let minDate = dateFormatter.date(from: minDateString)
        
        datePicker.minimumDate = minDate
        datePicker.maximumDate = Date()

        defaultDate = dateFormatter.date(from: defaultDateString)!
        
        datePicker.date = defaultDate
        
        toolbar = UIToolbar(frame: CGRectMake(0, 0, 0, 35))
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        let cancelItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        toolbar.setItems([cancelItem, doneItem], animated: true)
       
        self.inputView = datePicker
        self.inputAccessoryView = toolbar
        
    }
    
    func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
    @objc func cancel() {
       self.text = ""
       self.endEditing(true)
    }
    
    @objc func done() {
        self.endEditing(true)
    }
    
    //datepickerが選択されたらtextfieldに表示
    @objc func datePickerValueChanged(sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat  = "yyyy/MM/dd";
        self.text = dateFormatter.string(from: sender.date)
    }
    
}

extension DatePickerTextField: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        defaultDateString = self.text!
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        defaultDate = dateFormatter.date(from: defaultDateString)!
        datePicker.date = defaultDate
    }
    
}

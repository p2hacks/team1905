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
    
    let realm = try! Realm()
    var profile: Profile = Profile()
    
    var default_date: String = "1990/01/01"
    
    var isFirstResistration: Bool = true
    
    @IBOutlet weak var inputTable: UITableView!
    
    @IBAction func onTapRegistrationBtn(_ sender: Any) {
        profile = Profile()
        getTFValue()
        
        if isFirstResistration {
            createProfile(data: profile)
            self.performSegue(withIdentifier: "toStudentInput", sender: nil)
        } else {
            updateProfile(data: profile)
            self.performSegue(withIdentifier: "toStudentInput", sender: nil)
        }
        
        //navigationController?.popViewController(animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        inputTable.delegate = self
        inputTable.dataSource = self
        
        let results = realm.objects(Profile.self)
        
        if results.isEmpty {
            isFirstResistration = true
        } else {
            isFirstResistration = false
            
        }
        
        getData()
        
    }
    
    func getData() {
        let results = realm.objects(Profile.self)
        
        guard results.isEmpty else {
            profile.name = results[0].name
            profile.handle = results[0].handle
            profile.birthDay = results[0].birthDay
            profile.birthplace = results[0].birthplace
            default_date = results[0].birthDay
            return
        }
        print(SET_TEXT_ERROR)
    }
    
    func getTFValue(){
        let nameCell = inputTable.cellForRow(at: IndexPath.init(row: 0, section: 0)) as! ProfileTableViewCell
        let handleCell = inputTable.cellForRow(at: IndexPath.init(row: 1, section: 0)) as! ProfileTableViewCell
        let birthDayCell = inputTable.cellForRow(at: IndexPath.init(row: 2, section: 0)) as! ProfileTableViewCell
        let birthPlaceCell = inputTable.cellForRow(at: IndexPath.init(row: 3, section: 0)) as! ProfileTableViewCell
        
        profile.name = nameCell.nameTF.text!
        profile.handle = handleCell.handleTF.text!
        profile.birthDay = birthDayCell.birthDayTF.text!
        profile.birthplace = birthPlaceCell.birthPlaceTF.text!
        
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
            results[0].birthDay = data.birthDay
            results[0].birthplace = data.birthplace
            results[0].handle = data.handle
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

extension ProfileRegistrationViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0: // 氏名 "student_number"
            let cell = tableView.dequeueReusableCell(withIdentifier: "name", for: indexPath) as! ProfileTableViewCell
            cell.nameTF.text = profile.name
        return cell
        case 1: // ハンドルネーム "grade"
        let cell = tableView.dequeueReusableCell(withIdentifier: "handle", for: indexPath) as! ProfileTableViewCell
        cell.handleTF.text = profile.handle
        return cell
        case 2: // 誕生日 "course"
        let cell = tableView.dequeueReusableCell(withIdentifier: "birthDay", for: indexPath) as! ProfileTableViewCell
        cell.birthDayTF.setup()
        cell.birthDayTF.setText(text: default_date)
        return cell
        case 3: // 出身地　"sfirst_class"
        let cell = tableView.dequeueReusableCell(withIdentifier: "birthPlace", for: indexPath) as! ProfileTableViewCell
        cell.birthPlaceTF.text = profile.birthplace
        return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "name", for: indexPath)as! ProfileTableViewCell
        return cell
    }
    }
    
    
}

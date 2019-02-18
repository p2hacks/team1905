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
    
    var isFirstResistration: Bool = true
    
    @IBOutlet weak var inputTable: UITableView!
    
    @IBAction func onTapRegistrationBtn(_ sender: Any) {
        profile = Profile()
        inputTable.reloadData()
        
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
        profile.name = cell.nameTF.text!
        return cell
        case 1: // ハンドルネーム "grade"
        let cell = tableView.dequeueReusableCell(withIdentifier: "handle", for: indexPath) as! ProfileTableViewCell
        profile.handle = cell.handleTF.text!
        return cell
        case 2: // 誕生日 "course"
        let cell = tableView.dequeueReusableCell(withIdentifier: "birthDay", for: indexPath) as! ProfileTableViewCell
        cell.birthDayTF.setup()
        profile.birthDay = cell.birthDayTF.text!
        return cell
        case 3: // 出身地　"sfirst_class"
        let cell = tableView.dequeueReusableCell(withIdentifier: "birthPlace", for: indexPath) as! ProfileTableViewCell
        profile.birthplace = cell.birthPlaceTF.text!
        return cell
        default:
        let cell = tableView.dequeueReusableCell(withIdentifier: "name", for: indexPath) as! UITableViewCell
        return cell
    }
    }
    
    
}

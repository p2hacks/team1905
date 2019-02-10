//
//  ProfileRegistrationViewController.swift
//  surechigaiApp
//
//  Created by 川村周也 on 2019/02/11.
//  Copyright © 2019 川村周也. All rights reserved.
//

import UIKit
import RealmSwift

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
    
    
    let realm = try! Realm()
    var profile = Profile()
    
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

        // Do any additional setup after loading the view.
    }
    
    func createProfile (data: Profile) {
        // プライマリーキーをユニークな文字列で生成
        data.id = NSUUID().uuidString
        
        try! realm.write {
            realm.add(data)
        }
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

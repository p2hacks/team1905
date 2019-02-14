//
//  HomeViewController.swift
//  surechigaiApp
//
//  Created by AIRU ISHIKURA on 2019/02/10.
//  Copyright © 2019 川村周也. All rights reserved.
//

import UIKit
import RealmSwift

enum dataType {
    case profile
    case notification
}

class HomeViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var studentNumberLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var birthPlaceLabel: UILabel!
    @IBOutlet weak var courseLabel: UILabel!
    @IBOutlet weak var firstClassLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var clubLabel: UILabel!
    @IBOutlet weak var gradeLabel: UILabel!
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initLabels()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        
        initLabels()
    }
    
    func initLabels() {
        let results = realm.objects(Profile.self)
        
        if results.isEmpty {
            
        } else {
            nameLabel.text = "氏名：" + results[0].name
            studentNumberLabel.text = "学籍番号：" + results[0].student_number
            birthdayLabel.text = "誕生日：" + results[0].birthDay
            birthPlaceLabel.text = "出身地：" + results[0].birthplace
            courseLabel.text = "コース：" + results[0].course
            firstClassLabel.text = "1年次クラス：" + results[0].part_of_class
            handleLabel.text = "ハンドルネーム：" + results[0].handle
            clubLabel.text = "サークル：" + results[0].club
            gradeLabel.text = "学年：" + results[0].grade
        }
        
    }
    
    // profileデータの引き継ぎ用
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if (segue.identifier == "toExchange") {
            //遷移先のUIViewControllerを取得
            let nextVC: ExchangeProfileViewController = (segue.destination as? ExchangeProfileViewController)!
            let results = realm.objects(Profile.self)
            //遷移先の変数に値を代入する
            nextVC.myProfile = results[0]
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

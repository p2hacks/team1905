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
    
    let realm = try! Realm()
    
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

//
//  SettingTableViewController.swift
//  surechigaiApp
//
//  Created by 前田陸 on 2019/02/11.
//  Copyright © 2019 川村周也. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SettingTableViewController: UITableViewController {

    @IBOutlet var settingTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func tableView(_ table: UITableView,didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        
        if (cell?.reuseIdentifier == "logoutCell") {
            
            logoutDialog()
        }
    }
    
    func logoutDialog() {
        
        let alertController:UIAlertController = UIAlertController(
            title: "ログアウト",
            message: "本当にログアウトしますか？",
            preferredStyle:  UIAlertController.Style.alert
        )
        
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (action: UIAlertAction) in
            // okが押されたときの処理
            print("ok")
            
            do {
                try Auth.auth().signOut()
                self.performSegue(withIdentifier: "toLogin", sender: nil)
            } catch {
                print("ログアウトできない")
            }
        }
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel) { (action: UIAlertAction) in
            // キャンセルが押されたときの処理
            print("Cancel")
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(defaultAction)
        
        self.present(alertController, animated: true, completion: nil)
    }

}

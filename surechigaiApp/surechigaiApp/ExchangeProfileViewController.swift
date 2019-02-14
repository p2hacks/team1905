//
//  ExchangeProfileViewController.swift
//  surechigaiApp
//
//  Created by 川村周也 on 2019/02/14.
//  Copyright © 2019 川村周也. All rights reserved.
//

import UIKit
import RealmSwift
import MultipeerConnectivity

class ExchangeProfileViewController: UIViewController {
    
    let realm = try! Realm()
    
    var myProfile: Profile = Profile()
    // ピアの表示名
    let displayName: String = ""
    // 告知用の文字列（相手を検索するのに使用するIDの様なもの）
    let serviceType = "fun-surechigaiApp"
    
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var recieveLabel: UILabel!
    @IBOutlet weak var sendMsgTF: UITextField!
    
    @IBAction func sendBtnTapped(_ sender: Any) {
        // データの送信
        P2PConnectivity.manager.send(message: sendMsgTF.text!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ToDo: ハンドルネームと実名の表示切り替え
        
        // 接続の開始
        P2PConnectivity.manager.start(
            serviceType: serviceType,
            displayName: myProfile.name,
            stateChangeHandler: { state in
                // 接続状況の変化した時の処理
                self.stateLabel.text = String(state.rawValue)
        }, recieveHandler: { data in
            // データを受信した時の処理
            self.recieveLabel.text = data
        }
        )
        
        // 終了
        P2PConnectivity.manager.stop()
        
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

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
    
    var recentlyDate = ""
    var passTime = 0
    
    // ピアの表示名
    let displayName: String = ""
    // 告知用の文字列（相手を検索するのに使用するIDの様なもの）
    // 一つのハイフンしか使用できず、15文字以下である必要がある
    let serviceType = "fun-surechigai"
    
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var recieveLabel: UILabel!
    @IBOutlet weak var sendMsgTF: UITextField!
    
    @IBAction func sendBtnTapped(_ sender: Any) {
        do {
            // Profile → NSData
            let codedProfile = try NSKeyedArchiver.archivedData(withRootObject: myProfile, requiringSecureCoding: false)
            // データの送信
            P2PConnectivity.manager.send(data: codedProfile)
        } catch {
            fatalError("archivedData failed with error: \(error)")
        }
        
    }
    
    @IBAction func selectWaitingBtn(_ sender: UIButton) {
        self.performSegue(withIdentifier: "toSelectWaiting", sender: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ToDo: ハンドルネームと実名の表示切り替え
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        // 接続の開始
        P2PConnectivity.manager.start(
            serviceType: serviceType,
            displayName: myProfile.name,
            stateChangeHandler: { state in
                // 接続状況の変化した時の処理
                DispatchQueue.main.async() {
                    switch state {
                    case .notConnected:
                        self.stateLabel.text = "No connection"
                    case .connecting:
                        self.stateLabel.text = "Connecting..."
                    case .connected:
                        self.stateLabel.text = "Connected!"
                    }
                }
        }, profileRecieveHandler: { data in
            // データを受信した時の処理（UIの更新処理はmain thread で行う必要がある）
            DispatchQueue.main.async() {
                self.printData(recieveData: data)
                self.getDateAndTime()
                self.passTime += 1
            }
        }
        )
    }
    
    func getDateAndTime() {
        // 現在日時
        let date = Date()
        // 年月日時分秒をそれぞれ個別に取得
        let calendar = Calendar.current
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        
        self.recentlyDate = "\(month)" + "/" + "\(day)" + " " + "\(hour)" + ":" + "\(minute)"
    }
    
    func printData(recieveData: Data) {
        
        do {
            // NSData → Profile
            let decoded = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(recieveData) as! Profile
            // データの反映
            self.recieveLabel.text = "名前：\(decoded.name)\n学籍番号：\(decoded.student_number)\n誕生日：\(decoded.birthDay)\n出身地：\(decoded.birthplace)\nコース：\(decoded.course)\n一年時クラス：\(decoded.part_of_class)\nハンドルネーム：\(decoded.handle)\nサークル：\(decoded.club)\n学年：\(decoded.grade)\n"
            // クエリによるデータの取得
            let results = realm.objects(Profile.self).last
            // データの更新
            try! realm.write {
                results?.recentlyDate = self.recentlyDate
                results?.passTime = String(self.passTime)
            }

            self.recieveLabel.sizeToFit()
        } catch {
            fatalError("archivedData failed with error: \(error)")
        }
        
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
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

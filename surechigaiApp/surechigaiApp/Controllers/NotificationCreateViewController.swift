//
//  NotificationCreateViewController.swift
//  surechigaiApp
//
//  Created by 前田陸 on 2019/02/11.
//  Copyright © 2019 川村周也. All rights reserved.
//

import UIKit
import RealmSwift
import CoreBluetooth

class NotificationCreateViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // アドバタイズ開始ボタン
    @IBAction func pushAdvertiseBtn(_ sender: UIButton) {

        // アドバタイズ開始のトリガは広告をセットしたタイミング
        BLEConnectivity.manager.startAdvertise()
    }
    
    // アドバタイズ終了ボタン
    @IBAction func stopAdvertisingBtn(_ sender: UIButton) {
        // 広告が外された時
        BLEConnectivity.manager.stopAdvertise()
    }
}

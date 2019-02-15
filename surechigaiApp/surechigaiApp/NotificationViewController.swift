//
//  NotificationViewController.swift
//  surechigaiApp
//
//  Created by 前田陸 on 2019/02/11.
//  Copyright © 2019 川村周也. All rights reserved.
//

import UIKit
import CoreBluetooth

class NotificationViewController: UIViewController, CBCentralManagerDelegate, CBPeripheralDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var notificationTableView: UITableView!
    var notification = ["none"]
    
    // プロパティ定義
    var centralManager: CBCentralManager!
    var peripheral: CBPeripheral!
    
    let serviceUUID = CBUUID(string: "0011")
    let charactericUUID = CBUUID(string: "0012")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 初期化
        centralManager = CBCentralManager(delegate: self, queue: nil)
        
        notificationTableView.delegate = self
        notificationTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    // スキャン開始ボタン
    @IBAction func pushScanBtn(_ sender: UIBarButtonItem) {
        /*
        // スキャン開始
        print("スキャン開始")
        centralManager.scanForPeripherals(withServices: [serviceUUID], options: nil)
        // 5秒後スキャン停止
        Timer.scheduledTimer(withTimeInterval: 5, repeats: false) {_ in
            print("スキャン停止")
            self.centralManager.stopScan()
        }*/
        BLEConnectivity.manager.startScan()
    }
    
    // 状態変化を取得
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        print ("state: \(central.state)")
    }
    
    // スキャン結果取得
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        print("peripheral: \(peripheral)")
        self.peripheral = peripheral
        // 見つけたペリフェラルへの接続開始
        self.centralManager.connect(self.peripheral, options: nil)
    }
    
    //  ペリフェラルへの接続成功時
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("Connect success!")
        
        peripheral.delegate = self
        peripheral.discoverServices([serviceUUID])
    }
    
    //  ペリフェラルへの接続失敗時
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        print("Connect failed...")
    }
    
    // サービス検索結果の取得
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard let services = peripheral.services else{
            print("error")
            return
        }
        print("\(services.count)個のサービスを発見。\(services)")
        
        //  サービスを見つけたらすぐにキャラクタリスティックを取得
        for obj in services {
            peripheral.discoverCharacteristics([charactericUUID], for: obj)
        }
    }
    
    // キャラクタリスティック検索結果の取得
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        if let characteristics = service.characteristics {
            print("\(characteristics.count)個のキャラクタリスティックを発見。\(characteristics)")
            
            peripheral.readValue(for: characteristics[0])
        }
    }
    
    // Read
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        if let error = error {
            print("Failed... error: \(error)")
            return
        }
        print("Succeeded! service uuid: \(characteristic.service.uuid), characteristic uuid: \(characteristic.uuid), value: \(String(describing: characteristic.value))")
        
        // バッテリーレベルのキャラクタリスティックかどうかを判定
        if characteristic.uuid.isEqual(CBUUID(string: "0012")) {
            let text = NSString(data: characteristic.value!, encoding: String.Encoding.utf8.rawValue)
            print(text!)
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notification.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notificationCell", for: indexPath)
        
        cell.textLabel!.text = notification[indexPath.row]
        return cell
    }
    
}

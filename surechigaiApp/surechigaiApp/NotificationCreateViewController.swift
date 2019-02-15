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

class NotificationCreateViewController: UIViewController, CBPeripheralManagerDelegate{
    
    @IBOutlet weak var titleTextField: UITextField!
    
    // プロパティ定義
    var peripheralManager: CBPeripheralManager!
    var serviceUUID: CBUUID!
    var characteristic: CBMutableCharacteristic!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // 状態変化を取得
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        print("periState: \(peripheral.state)")
        
        switch peripheral.state {
            
        case .poweredOn:
            // サービス登録開始
            self.publishservice()
            break
            
        default:
            break
        }
    }
    
    // サービスの登録
    func publishservice () {
        // サービスを作成
        self.serviceUUID = CBUUID(string: "0011")
        let service = CBMutableService(type: serviceUUID, primary: true)
        
        // キャラクタリスティックを作成
        let characteristicUUID = CBUUID(string: "0012")
        
        let properties = (
            CBCharacteristicProperties.notify.rawValue |
                CBCharacteristicProperties.read.rawValue |
                CBCharacteristicProperties.write.rawValue)
        
        let permissions = (
            CBAttributePermissions.readable.rawValue |
                CBAttributePermissions.writeable.rawValue)
        
        self.characteristic = CBMutableCharacteristic(
            type: characteristicUUID,
            properties: CBCharacteristicProperties(rawValue: properties),
            value: nil,
            permissions: CBAttributePermissions(rawValue: permissions))
        
        // キャラクタリスティックをサービスにセット
        service.characteristics = [self.characteristic]
        
        // サービスを Peripheral Manager にセット
        self.peripheralManager.add(service)
    }
    
    // サービス追加結果を取得
    func peripheralManager(_ peripheral: CBPeripheralManager, didAdd service: CBService, error: Error?) {
        if error != nil {
            print("Service Add Failed...")
            return
        }
        print("Service Add Success!")
    }
    
    // アドバタイズ結果を取得
    func peripheralManagerDidStartAdvertising(_ peripheral: CBPeripheralManager, error: Error?) {
        if error != nil {
            print("***Advertising ERROR")
            return
        }
        print("Advertising success")
    }
    
    func peripheralManager(_ peripheral: CBPeripheralManager, didReceiveRead request: CBATTRequest) {
        
        if request.characteristic.uuid.isEqual(characteristic.uuid) {
            
            // CBMutableCharacteristicのvalueをCBATTRequestのvalueにセット
            let msg: String = "あかさたな"
            
            let data: Data = msg.data(using: String.Encoding.utf8, allowLossyConversion:true)!
            print("data: \(String(describing: data))")
            self.characteristic.value = data
            request.value = self.characteristic.value
            
            // リクエストに応答
            peripheralManager.respond(to: request, withResult: .success)
        }
    }
    
    // アドバタイズ開始ボタン
    @IBAction func pushAdvertiseBtn(_ sender: UIButton) {
        /*
        let advertisementData = [CBAdvertisementDataLocalNameKey: "Test Device",
                                 CBAdvertisementDataServiceUUIDsKey: [self.serviceUUID]] as [String : Any]
        self.publishservice()
        peripheralManager.startAdvertising(advertisementData)*/
        BLEConnectivity.manager.startAdvertise()
    }
    
    // アドバタイズ終了ボタン
    @IBAction func stopAdvertisingBtn(_ sender: UIButton) {
        //peripheralManager.stopAdvertising()
        BLEConnectivity.manager.stopAdvertise()
    }
}

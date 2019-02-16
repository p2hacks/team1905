//
//  NotificationViewController.swift
//  surechigaiApp
//
//  Created by 前田陸 on 2019/02/11.
//  Copyright © 2019 川村周也. All rights reserved.
//

import UIKit
import CoreBluetooth

enum notificationType {
    case club
    case partTimeJob
    case lecture
    case event
}

class NotificationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var notificationTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    // スキャン開始ボタン
    @IBAction func pushScanBtn(_ sender: UIBarButtonItem) {
        
        BLEConnectivity.manager.startScan()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0//notification.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notificationCell", for: indexPath)
        
        //cell.textLabel!.text = notification[indexPath.row]
        return cell
    }
    
}

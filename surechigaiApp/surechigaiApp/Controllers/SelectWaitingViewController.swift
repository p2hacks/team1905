//
//  SelectWaitingViewController.swift
//  surechigaiApp
//
//  Created by AIRU ISHIKURA on 2019/02/16.
//  Copyright © 2019 川村周也. All rights reserved.
//

import UIKit
import RealmSwift
import MultipeerConnectivity

class SelectWaitingViewController: UIViewController {
    
    @IBOutlet weak var peerTable: UITableView!
    
    var peerIDs = P2PConnectivity.peerIDs
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            // セルを取得す
            let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            // セルに表示する値を設定する
            cell.textLabel!.text = peerIDs[indexPath.row] as? String ?? ""
            return cell
        }
        
    }
    
}

extension SelectWaitingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peerIDs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = peerIDs[indexPath.row] as? String ?? ""
        cell.accessoryType = .disclosureIndicator
        //cell.accessoryView = UISwitch() // スィッチ
        return cell
    }
 
    // セルがタップされたとき呼ばれる
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let browser: MCNearbyServiceBrowser = MCNearbyServiceBrowser()
        browser.invitePeer(P2PConnectivity.peerIDs[indexPath.row], to: P2PConnectivity.manager.session, withContext: nil, timeout: 0)
    }
    
    
    
    
}

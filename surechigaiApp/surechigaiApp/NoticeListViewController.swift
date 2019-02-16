//
//  NoticeListViewController.swift
//  surechigaiApp
//
//  Created by 前田陸 on 2019/02/16.
//  Copyright © 2019 川村周也. All rights reserved.
//

import UIKit

class NoticeListViewController: UIViewController {

    var noticeListCell = [""]
    
    @IBOutlet weak var noticeListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.noticeListCell = self
        
        noticeListTableView.delegate = self
        noticeListTableView.dataSource = self
    }
    
    func addCell() {
        noticeListCell.insert("新規の広告を受信しました。", at: 0)
        noticeListTableView.reloadData()
    }
    
    @IBAction func pushBackBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension NoticeListViewController: UITableViewDelegate {
    
}

extension NoticeListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noticeListCell.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noticeCell", for: indexPath)
        cell.textLabel!.text = noticeListCell[indexPath.row]
        return cell
    }
}

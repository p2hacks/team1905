//
//  CarouselCell.swift
//  surechigaiApp
//
//  Created by 前田陸 on 2019/02/16.
//  Copyright © 2019 川村周也. All rights reserved.
//

import UIKit

class CarouselCell: UICollectionViewCell {
    
    
    
    @IBOutlet weak var registerView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var historyDayLabel: UILabel!
    @IBOutlet weak var historyTimeLabel: UILabel!
    @IBOutlet weak var registerTableView: UITableView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    func setup() {
        // ここでセットアップする
        // セルを角丸にする
        registerView.layer.cornerRadius = 10
        registerView.layer.shadowOffset = CGSize(width: 1,height: 1) // 影の位置
        registerView.layer.shadowColor = UIColor.gray.cgColor        // 影の色
        registerView.layer.shadowOpacity = 0.7                       // 影の透明度
        registerView.layer.shadowRadius = 5                          // 影の広がり
    }

    @IBAction func pushProfileBtn(_ sender: Any) {
    }
    @IBAction func pushNotificationBtn(_ sender: Any) {
    }
    @IBAction func pushHistoryBtn(_ sender: Any) {
    }
}

//
//  CarouselCell.swift
//  surechigaiApp
//
//  Created by 前田陸 on 2019/02/16.
//  Copyright © 2019 川村周也. All rights reserved.
//

import UIKit

class CarouselCell: UICollectionViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var historyLabel: UILabel!
    @IBOutlet weak var historyTimeLabel: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    func setup() {
        // ここでセットアップする
    }

    @IBAction func pushProfileBtn(_ sender: UIButton) {
    }
    @IBAction func pushNotificationBtn(_ sender: UIButton) {
    }
    @IBAction func pushHistoryBtn(_ sender: UIButton) {
    }
}

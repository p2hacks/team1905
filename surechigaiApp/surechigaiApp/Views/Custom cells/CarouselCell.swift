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
    }

    @IBAction func pushProfileBtn(_ sender: Any) {
    }
    @IBAction func pushNotificationBtn(_ sender: Any) {
    }
    @IBAction func pushHistoryBtn(_ sender: Any) {
    }
}

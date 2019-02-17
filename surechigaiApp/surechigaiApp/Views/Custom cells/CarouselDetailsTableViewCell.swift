//
//  CarouselDetailsTableViewCell.swift
//  surechigaiApp
//
//  Created by 前田陸 on 2019/02/17.
//  Copyright © 2019 川村周也. All rights reserved.
//

import UIKit

class CarouselDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var adDetailsLabel: UILabel!
    
    func setCell() {
        adDetailsLabel.text = "詳細"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let view = Bundle.main.loadNibNamed("CarouselDetailsTableViewCell", owner: self, options: nil)?.first as! UIView
        view.frame = frame
        addSubview(view)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        let view = Bundle.main.loadNibNamed("CarouselDetailsTableViewCell", owner: self, options: nil)?.first as! UIView
        view.frame = frame
        addSubview(view)
        
        // Configure the view for the selected state
    }
    
    static func getRowHeight() -> CGFloat {
        return 20.0
    }
    
}

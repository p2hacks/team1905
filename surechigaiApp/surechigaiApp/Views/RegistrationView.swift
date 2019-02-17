//
//  RegistrationView.swift
//  surechigaiApp
//
//  Created by 川村周也 on 2019/02/16.
//  Copyright © 2019 川村周也. All rights reserved.
//

import UIKit

class RegistrationView: UIView {
    
    @IBOutlet var inputTable: UITableView!
    @IBOutlet weak var inputImage: UIImageView!
    
    @IBAction func nextBtnTapped(_ sender: Any) {
        
    }
    
    
    
    override func awakeFromNib() {
        // XIB読み込み
        let view = Bundle.main.loadNibNamed("RegistrationView", owner: self, options: nil)?.first as! UIView
        addSubview(view)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let view = Bundle.main.loadNibNamed("RegistrationView", owner: self, options: nil)?.first as! UIView
        view.frame = frame
        addSubview(view)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

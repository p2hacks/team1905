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
    @IBOutlet weak var infoTable: UITableView!
    
    var switchingNumber = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let view = Bundle.main.loadNibNamed("CarouselCell", owner: self, options: nil)?.first as! UIView
        view.frame = frame
        addSubview(view)
        
        
        
        //initCarouselTableView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        /*registerTableView.delegate = self
        registerTableView.dataSource = self*/
        //initCourceTableView()
    }
    
    //MARK: - TableView init
    /*func initCourceTableView() {
        
        let nib = UINib(nibName: "CarouselDetailsTableViewCell", bundle: nil)
        registerTableView.register(nib, forCellReuseIdentifier: "carouselDetailCell_ID")
    }*/
    
    
    @IBAction func pushProfileBtn(_ sender: Any) {
        switchingNumber = 0
    }
    @IBAction func pushNotificationBtn(_ sender: Any) {
        switchingNumber = 1
    }
    @IBAction func pushHistoryBtn(_ sender: Any) {
        switchingNumber = 2
    }
    
    
}

/*extension CarouselCell: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.registerTableView.dequeueReusableCell(withIdentifier: "carouselDetailCell_ID", for: indexPath) as! CarouselDetailsTableViewCell
        cell.setCell()
        if self.switchingNumber == 0 {
            cell.adDetailsLabel.text = "プロフィール"
        } else if self.switchingNumber == 1 {
            cell.adDetailsLabel.text = "広告"
        } else {
            cell.adDetailsLabel?.text = "履歴"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.registerTableView.deselectRow(at: indexPath, animated: true)
    }
    
}
*/

//
//  HomeViewController.swift
//  surechigaiApp
//
//  Created by AIRU ISHIKURA on 2019/02/10.
//  Copyright © 2019 川村周也. All rights reserved.
//

import UIKit
import RealmSwift

enum dataType {
    case profile
    case notification
}

class HomeViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var studentNumberLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var birthPlaceLabel: UILabel!
    @IBOutlet weak var courseLabel: UILabel!
    @IBOutlet weak var firstClassLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var clubLabel: UILabel!
    @IBOutlet weak var gradeLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  RegisterProfileViewController.swift
//  surechigaiApp
//
//  Created by 前田陸 on 2019/02/15.
//  Copyright © 2019 川村周也. All rights reserved.
//

import UIKit

class RegisterProfileViewController: UIViewController {

    var carouselView:CarouselView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let width = self.view.frame.width
        let height = self.view.frame.height
        
        carouselView = CarouselView(frame: CGRect(x:0, y:0, width:width, height:height+200))
        carouselView.center = CGPoint(x:width / 2,y: height / 2)
        carouselView.register(UINib(nibName: "CarouselCell", bundle: nil), forCellWithReuseIdentifier: "registerCell")
        carouselView.layoutMargins.left = 5
        carouselView.layoutMargins.right = 5
        self.view.addSubview(carouselView)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        carouselView.scrollToFirstItem()
    }
}

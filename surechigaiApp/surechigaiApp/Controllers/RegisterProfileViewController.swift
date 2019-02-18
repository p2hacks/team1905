//
//  RegisterProfileViewController.swift
//  surechigaiApp
//
//  Created by 前田陸 on 2019/02/15.
//  Copyright © 2019 川村周也. All rights reserved.
//

import UIKit
import RealmSwift

class RegisterProfileViewController: UIViewController {

    var carouselView:CarouselView!
    
    let realm = try! Realm()
    
    var name = [""]
    var nickName = [""]
    var number = [""]
    var recentlyDate = [""]
    var passTime = [""]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let width = self.view.frame.width
        let height = self.view.frame.height
        
        carouselView = CarouselView(frame: CGRect(x:0, y:0, width:width, height:height+200))
        carouselView.center = CGPoint(x:width / 2,y: height / 2)
        //let view = Bundle.main.loadNibNamed("CarouselCell", owner: self, options: nil)?.first as! UIView
        //view.frame = carouselView.frame
        carouselView.register(UINib(nibName: "CarouselCell", bundle: nil), forCellWithReuseIdentifier: "registerCell")
        carouselView.layoutMargins.left = 5
        carouselView.layoutMargins.right = 5
        self.view.addSubview(carouselView)
        
        addElement()
        
        carouselView.delegate = self
        carouselView.dataSource = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        carouselView.scrollToFirstItem()
    }
    
    func addElement(){
        // オブジェクトの取得.
        let objs = realm.objects(Profile.self)
        
        if let obj = objs.last {
            name = [obj.name]
            nickName = [obj.handle]
            number = [obj.student_number]
            recentlyDate = [obj.recentlyDate]
            passTime = [obj.passTime]
        }
    }
}

extension RegisterProfileViewController: UICollectionViewDataSource {
    // セクションごとのセル数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // realmに登録しているprofileの個数を返せば良い？
        return realm.objects(Profile.self).count+1
    }
    
    // セルの設定
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:CarouselCell = carouselView.dequeueReusableCell(withReuseIdentifier: "registerCell", for: indexPath) as! CarouselCell
        
        //configureCell(cell: cell, indexPath: indexPath)
        
        cell.nameLabel.text = name[indexPath.row+1]
        cell.nicknameLabel.text = nickName[indexPath.row+1]
        cell.numberLabel.text = number[indexPath.row+1]
        cell.historyDayLabel.text = recentlyDate[indexPath.row+1]
        cell.historyTimeLabel.text = passTime[indexPath.row+1]
        
        return cell
    }
    
    func configureCell(cell: CarouselCell,indexPath: IndexPath) {
        // indexを修正する
        //let fixedIndex = isInfinity ? indexPath.row % pageCount : indexPath.row
        //cell.contentView.backgroundColor = colors[fixedIndex]
    }
}

extension RegisterProfileViewController: UICollectionViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        /*if isInfinity {
            if cellItemsWidth == 0.0 {
                cellItemsWidth = floor(scrollView.contentSize.width / 3.0) // 表示したい要素群のwidthを計算
            }
            
            if (scrollView.contentOffset.x <= 0.0) || (scrollView.contentOffset.x > cellItemsWidth * 2.0) { // スクロールした位置がしきい値を超えたら中央に戻す
                scrollView.contentOffset.x = cellItemsWidth
            }
        }*/
    }
}

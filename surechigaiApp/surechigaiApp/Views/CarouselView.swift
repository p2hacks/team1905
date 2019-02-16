//
//  CarouselView.swift
//  surechigaiApp
//
//  Created by 前田陸 on 2019/02/16.
//  Copyright © 2019 川村周也. All rights reserved.
//

import UIKit

class CarouselView: UICollectionView {
    
    // 実際に表示させるセルのwidthの変数
    var cellItemsWidth: CGFloat = 0.0
    
    // スクロールの無限化判定
    let isInfinity = false
    
    // セルの配色
    let colors:[UIColor] = [.blue,.yellow,.red,.green,.gray]

    let cellIdentifier = "registerCell"
    let pageCount = 5
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.delegate = self
        self.dataSource = self
        self.register(CarouselCell.self, forCellWithReuseIdentifier: cellIdentifier)
    }
    
    convenience init(frame: CGRect) {
        let layout = PagingPerCellFlowLayout()
        layout.itemSize = CGSize(width: 300, height: frame.height / 2)
        // スクロールの向きを水平に変更
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = -20
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        self.init(frame: frame, collectionViewLayout: layout)
        
        // 水平方向のスクロールバーを非表示にする
        self.showsHorizontalScrollIndicator = false
        
        self.backgroundColor = UIColor.white
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 画面内に表示されているセルを取得
        let cells = self.visibleCells
        for cell in cells {
            // ここでセルのScaleを変更する
            transformScale(cell: cell)
        }
        
    }
    
    // 初期位置を真ん中にする
    func scrollToFirstItem() {
        self.layoutIfNeeded()
        if isInfinity {
            self.scrollToItem(at:IndexPath(row: self.pageCount, section: 0) , at: .centeredHorizontally, animated: false)
        }
    }
    
    func transformScale(cell: UICollectionViewCell) {
        // 計算してスケールを変更する
        let cellCenter:CGPoint = self.convert(cell.center, to: nil) //セルの中心座標
        let screenCenterX:CGFloat = UIScreen.main.bounds.width / 2  //画面の中心座標x
        //中心までの距離
        let cellCenterDisX:CGFloat = abs(screenCenterX - cellCenter.x)
        let reductionRatio:CGFloat = -0.0009                        //縮小率
        let maxScale:CGFloat = 1                                    //最大値
        let newScale = reductionRatio * cellCenterDisX + maxScale   //新しいスケール
        cell.transform = CGAffineTransform(scaleX:newScale, y:newScale)
    }
}

extension CarouselView: UICollectionViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if isInfinity {
            if cellItemsWidth == 0.0 {
                cellItemsWidth = floor(scrollView.contentSize.width / 3.0) // 表示したい要素群のwidthを計算
            }
            
            if (scrollView.contentOffset.x <= 0.0) || (scrollView.contentOffset.x > cellItemsWidth * 2.0) { // スクロールした位置がしきい値を超えたら中央に戻す
                scrollView.contentOffset.x = cellItemsWidth
            }
        }
    }
}

extension CarouselView: UICollectionViewDataSource {
    // セクションごとのセル数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // 実際のセル数の３倍のセルを用意
        return isInfinity ? pageCount * 3 : pageCount
    }
    
    // セルの設定
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:CarouselCell = dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! CarouselCell
        
        configureCell(cell: cell, indexPath: indexPath)
        
        return cell
    }
    
    func configureCell(cell: CarouselCell,indexPath: IndexPath) {
        // indexを修正する
        let fixedIndex = isInfinity ? indexPath.row % pageCount : indexPath.row
        //cell.contentView.backgroundColor = colors[fixedIndex]
    }
}

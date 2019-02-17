//
//  PagingPerCellFlowLayout.swift
//  surechigaiApp
//
//  Created by 前田陸 on 2019/02/16.
//  Copyright © 2019 川村周也. All rights reserved.
//

import UIKit

class PagingPerCellFlowLayout: UICollectionViewFlowLayout {
/*
    var cellWidth:CGFloat = 300
    let windowWidth:CGFloat = UIScreen.main.bounds.width
    
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        var offsetAdjustment:CGFloat = CGFloat(MAXFLOAT)
        let horizontalOffest:CGFloat = proposedContentOffset.x + ( windowWidth - cellWidth ) / 2
        let targetRect = CGRect(x:proposedContentOffset.x,
                                y:0,
                                width:self.collectionView!.bounds.size.width,
                                height:self.collectionView!.bounds.size.height)
        
        let array = super.layoutAttributesForElements(in: targetRect)
        
        for layoutAttributes in array! {
            let itemOffset = layoutAttributes.frame.origin.x
            if abs(itemOffset - horizontalOffest) < abs(offsetAdjustment) {
                offsetAdjustment = itemOffset - horizontalOffest
            }
        }
        
        return CGPoint(x:proposedContentOffset.x + offsetAdjustment, y:proposedContentOffset.y)
    }*/

    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        if let collectionViewBounds = self.collectionView?.bounds {
            
            let halfWidthOfVC = collectionViewBounds.size.width * 0.5
            let proposedContentOffsetCenterX = proposedContentOffset.x + halfWidthOfVC
            
            if let attributesForVisibleCells = self.layoutAttributesForElements(in: collectionViewBounds) {
                
                var candidateAttribute : UICollectionViewLayoutAttributes?
                
                for attributes in attributesForVisibleCells {
                    
                    let candAttr : UICollectionViewLayoutAttributes? = candidateAttribute
                    
                    if candAttr != nil {
                        
                        let a = attributes.center.x - proposedContentOffsetCenterX
                        let b = candAttr!.center.x - proposedContentOffsetCenterX
                        
                        if abs(a) < abs(b) {
                            candidateAttribute = attributes
                        }
                    } else {
                        candidateAttribute = attributes
                        continue
                    }
                }
                
                if candidateAttribute != nil {
                    return CGPoint(x: candidateAttribute!.center.x - halfWidthOfVC, y: proposedContentOffset.y);
                }
            }
        }
        return CGPoint.zero
    }
}

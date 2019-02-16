//
//  PagingPerCellFlowLayout.swift
//  surechigaiApp
//
//  Created by 前田陸 on 2019/02/16.
//  Copyright © 2019 川村周也. All rights reserved.
//

import UIKit

class PagingPerCellFlowLayout: UICollectionViewFlowLayout {

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
                        
                        if fabs(a) < fabs(b) {
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

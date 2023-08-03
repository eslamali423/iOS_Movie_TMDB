//
//  UICollectionView+Extension.swift
//  Movies_task
//
//  Created by Eslam Ali  on 03/08/2023.
//

import Foundation
import UIKit

extension UICollectionView {
    
    func formatingCollectionView(topPadding:CGFloat,rightPadding:CGFloat,leftPadding:CGFloat,bottomPadding:CGFloat,width:CGFloat, height:CGFloat,minimumInteritemSpacing:CGFloat,minimumLineSpacing:CGFloat, scrollDirection: UICollectionView.ScrollDirection? = .vertical){
        var flowLayout: UICollectionViewFlowLayout?
        scrollDirection == .vertical ? (flowLayout = UICollectionViewFlowLayout()) : (flowLayout = RightLeftFlowLayout())
        
        flowLayout!.sectionInset = UIEdgeInsets(top: topPadding,left: leftPadding,bottom: bottomPadding,right: rightPadding )
        flowLayout!.itemSize = CGSize(width: (width) , height: (height) )
        flowLayout!.minimumInteritemSpacing = minimumInteritemSpacing
        flowLayout!.minimumLineSpacing = minimumLineSpacing
        flowLayout!.scrollDirection = scrollDirection ?? .vertical
        self.setCollectionViewLayout(flowLayout!, animated: true)
    }
    
}


final class DWUICollectionViewPagingFlowLayout: UICollectionViewFlowLayout {
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView else { return proposedContentOffset }
        let offset = isVertical ? collectionView.contentOffset.y : collectionView.contentOffset.x
        let velocity = isVertical ? velocity.y : velocity.x
        let flickVelocityThreshold: CGFloat = 0.2
        let currentPage = offset / pageSize
        
        if abs(velocity) > flickVelocityThreshold {
            let nextPage = velocity > 0.0 ? ceil(currentPage) : floor(currentPage)
            let nextPosition = nextPage * pageSize
            return isVertical ? CGPoint(x: proposedContentOffset.x, y: nextPosition) : CGPoint(x: nextPosition, y: proposedContentOffset.y)
        } else {
            let nextPosition = round(currentPage) * pageSize
            return isVertical ? CGPoint(x: proposedContentOffset.x, y: nextPosition) : CGPoint(x: nextPosition, y: proposedContentOffset.y)
        }
    }
    
    private var isVertical: Bool {
        return scrollDirection == .vertical
    }
    
    private var pageSize: CGFloat {
        if isVertical {
            return itemSize.height + minimumInteritemSpacing
        } else {
            return itemSize.width + minimumLineSpacing
        }
    }
}

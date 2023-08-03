//  DWHelper.swift
//  Dawarha
//
//  Created by Eslam Ali on 14/02/2023.
//

import Foundation
import UIKit
import Drops


class Helper {
    static let shared = Helper()
  
     func getCurrentViewController() -> UIViewController? {
        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        guard var topController = keyWindow?.rootViewController else {return nil}
        while let presentedViewController = topController.presentedViewController {
            topController = presentedViewController
        }
        return topController
    }
    
      func displayToast(message : String){
        let drop = Drop(title:message,titleNumberOfLines: 0 , subtitleNumberOfLines: 0 , accessibility: Drop.Accessibility(message: message))
        Drops.show(drop)
    }
}

class RightLeftFlowLayout: UICollectionViewFlowLayout {
    override var flipsHorizontallyInOppositeLayoutDirection: Bool {
        return true
    }
    
    public override init() {
        super.init()
        scrollDirection = .horizontal
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

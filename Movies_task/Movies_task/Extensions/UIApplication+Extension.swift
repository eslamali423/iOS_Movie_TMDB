//
//  UIApplication+Extension.swift
//  Movies_task
//
//  Created by Eslam Ali  on 03/08/2023.
//

import Foundation
import UIKit

extension UIApplication {
    var statusBarHeight : CGFloat {
        
        if #available(iOS 13.0, *) {
            let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            return window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        } else {
            return UIApplication.shared.statusBarFrame.height
        }
    }
}

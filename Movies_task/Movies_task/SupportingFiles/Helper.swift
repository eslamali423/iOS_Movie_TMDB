//  DWHelper.swift
//  Dawarha
//
//  Created by Eslam Ali on 14/02/2023.
//

import Foundation
import UIKit


class Helper {
    static let shared = Helper()
    
    func getAppLang() -> String {
        guard let languageArray = UserDefaults.standard.object(forKey: "AppleLanguages") as? [String] else {return ""}
        let currentLanguage = languageArray.first!
        if let hyphenIndex = currentLanguage.firstIndex(of: "-") {
            return String(currentLanguage[..<hyphenIndex])
        }else {
            return currentLanguage
        }
        
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

//
//  GameConfig.swift
//  
//
//  Created by  on 4/8/19.
//  Copyright © 2019 . All rights reserved.
//

import Foundation
import SpriteKit

struct GameConfig {
    static let currentScore = "CurrentScore"
    static let bestScore = "BestScore"
    static let currentCoin = "currentCoin"
    static let currentBlood = "currentBlood"
    static let currentProtect = "currentProtect"
    static let level = "levelGame"
    static let mode = "modeGame"
    
    static let hasLaunchedOnce = "HasLaunchedOnce"
    static let neverRateAfterGame =  "NeverRateAfterGame"
    
    static let fontText:String = "impact"
    static let fontNumber:String = "impact"
    static let textColor: UIColor = #colorLiteral(red: 1, green: 0.1817393711, blue: 0.9051496257, alpha: 1)
    
    struct zPosition {
        static let layer_1:CGFloat = 0
        static let layer_2:CGFloat = 1
        static let layer_3:CGFloat = 2
        static let layer_4:CGFloat = 3
        static let layer_5:CGFloat = 4
    }
}

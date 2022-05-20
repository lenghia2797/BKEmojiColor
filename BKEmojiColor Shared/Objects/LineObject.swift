//
//  EnemyObject.swift
//  SPEEDBOAT
//
//  Created by Mr. Joker on 8/15/19.
//  Copyright © 2019 ORI GAME. All rights reserved.
//

import Foundation
import SpriteKit

class LineObject : Sprite {
    var obj1 = Sprite()
    var obj2 = Sprite()
    
    override init() {
        super.init()
    }
    
    init(size: CGSize, position: CGPoint, zPosition: CGFloat) {
        super.init(imageNamed: "_bat_1.png", size: size, position: position, zPosition: zPosition)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

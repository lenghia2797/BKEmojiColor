//
//  PlayerObject.swift
//  SPEEDBOAT
//
//  Created by Mr. Joker on 8/14/19.
//  Copyright © 2019 ORI GAME. All rights reserved.
//

import Foundation
import SpriteKit

class ColorObject : Sprite {
    
    var nPart: Int = 0
    
    var parts = [SKShapeNode()]
    
    override init() {
        super.init()
        parts.removeAll()
    }

    override init(imageNamed: String, size: CGSize, position: CGPoint, zPosition: CGFloat) {
        super.init(imageNamed: imageNamed, size: size, position: position, zPosition: zPosition)

        parts.removeAll()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createObject(_nPart: Int, _part: SKShapeNode, _arr: [Int], _colors: [UIColor]) {
        nPart = _nPart
        
        let angle: CGFloat = (.pi * 2)/CGFloat(nPart)
        
        for i in 0...nPart-1 {
            let part: SKShapeNode = SKShapeNode()
            
            part.path = _part.path
            part.fillColor = _colors[_arr[i]]
            part.lineWidth = _part.lineWidth
            part.strokeColor = _part.strokeColor
            part.zPosition = 4
            
            part.position = .zero
            
            part.name = String(i)
            
            parts.append(part)
            
            self.addChild(part)
            
            part.zRotation = angle*CGFloat(i)
            
            let name = _arr[i]
            let emoji = Sprite(imageNamed: "_emoji_\(name)", size: .sizeOfNode(_sizeOfTexture: SKTexture(imageNamed: "Images/_emoji_\(name)").size(), _sizeofNode: .withPercentScaled(roundByWidth: 7)), position: CGPoint(x: 0, y: 30), zPosition: 10)
            emoji.zRotation = -1*part.zRotation
            part.addChild(emoji)
            
        }
    }
}

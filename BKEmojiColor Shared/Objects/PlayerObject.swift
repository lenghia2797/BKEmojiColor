//
//  PlayerObject.swift
//  SPEEDBOAT
//
//  Created by Mr. Joker on 8/14/19.
//  Copyright © 2019 ORI GAME. All rights reserved.
//

import Foundation
import SpriteKit

class PlayerObject : Sprite {
    
    var isProtect: Bool = false
    
    let effectSpr = Sprite(imageNamed: "img_player_effect_1", size: CGSize.withPercentScaled(roundByWidth: 30), position: CGPoint.zero, zPosition: -1)
    
    override init() {
        super.init()
    }
    
    init(size: CGSize, position: CGPoint, zPosition: CGFloat) {
        super.init(imageNamed: "img_player_run_1", size: size, position: position, zPosition: zPosition)
        
        var animateFrames = [SKTexture]()
        
        for i in 1...8 {
            animateFrames.append(SKTexture(imageNamed: "Images/img_player_run_" + "\(i)"))
        }
        
        self.run(SKAction.repeatForever(SKAction.animate(with: animateFrames,
                                                    timePerFrame: 0.1,
                                                    resize: false,
                                                    restore: false)))
        
        animateFrames.removeAll()
        for i in 1...7 {
            animateFrames.append(SKTexture(imageNamed: "Images/img_player_effect_" + "\(i)"))
        }
        
        addChild(effectSpr)
        effectSpr.isHidden = true
        effectSpr.position = CGPoint(x: 0, y: -effectSpr.frame.height*0.35)
        effectSpr.run(SKAction.repeatForever(SKAction.animate(with: animateFrames,
                                                    timePerFrame: 0.1,
                                                    resize: false,
                                                    restore: false)))
        
        setScale(0.75)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func onProtected() {
        isProtect = true
        effectSpr.isHidden = false
        
        self.removeAction(forKey: "skprotect")
        self.run(SKAction.sequence([SKAction.wait(forDuration: 10), SKAction.customAction(withDuration: 0, actionBlock: {_,_ in self.isProtect = false; self.effectSpr.isHidden = true})]), withKey: "skprotect")
    }
}

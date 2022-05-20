
import Foundation
import SpriteKit

extension GameScene {
    
    func updateScore(s: Int) {
        var score = UserDefaults.standard.integer(forKey: GameConfig.currentScore)
        score += s
        UserDefaults.standard.set(score, forKey: GameConfig.currentScore)
        scoreLbl.changeTextWithAnimationScaled(withText: "Score: \(score)")
        Sounds.sharedInstance().playSound(soundName: "Sounds/sound_score.mp3")
        
        if score > UserDefaults.standard.integer(forKey: GameConfig.bestScore) {
            UserDefaults.standard.set(score, forKey: GameConfig.bestScore)
        }
        
        updateProgressX(value: 0.1)
        
        if score > levelScore*3 && levelScore < 10 {
            levelScore += 1
            progressBarDec *= 1.03
        }
    }
    
    func hightlightsSpr(spr : Sprite) {
        spr.run(SKAction.sequence([
            SKAction.scale(to: 1.15, duration: 0.05),
            SKAction.scale(to: 1, duration: 0.05),
        ]))
    
    }
    
    func displayHearts(number : Int) {
        if number < 0 {
            changeSceneTo(scene: EndScene(size: self.size))
        }
        for h in hearts {
            h.removeFromParent()
        }
        hearts.removeAll()
        if number > 0 {
            for _ in 1...number {
                let heart = Sprite(imageNamed: "_heart.png", size: CGSize.withPercentScaled(roundByWidth: 6), position: CGPoint.zero, zPosition: 3)
                addChild(heart)
                hearts.append(heart)
                heart.run(SKAction.sequence([
                    SKAction.scale(to: 1.2, duration: 0.1),
                    SKAction.scale(to: 1, duration: 0.1),
                    SKAction.scale(to: 1.2, duration: 0.1),
                    SKAction.scale(to: 1, duration: 0.1),
                ]))
                
            }
            
        }
        GameViewHelper.alignItemsHorizontallyWithPadding(padding: 5, items: hearts, position: CGPoint.withPercent(85, y: 45))
        
        
    }
    
    func addFallingHeart(duration : Double) {
            
        let heart = Sprite(imageNamed: "_heart.png", size: CGSize.withPercentScaled(roundByWidth: 6), position: randomPositionBottomScreenEspecially(), zPosition: 3)
        heart.run(SKAction.move(to: CGPoint(x: heart.position.x, y: self.size.height*1.1), duration: duration))
        addChild(heart)
        let heart_balloon = Sprite(imageNamed: "_heart_balloon.png", size: CGSize.withPercentScaled(roundByWidth: 16), position: CGPoint(x: 0, y: -10), zPosition: heart.zPosition - 0.1)
        heart_balloon.alpha = 0.65
        heart.addChild(heart_balloon)
        heart.physicsBody = SKPhysicsBody(rectangleOf: heart.size)
        heart.physicsBody?.isDynamic = true
        heart.physicsBody?.affectedByGravity = false
//        heart.physicsBody?.categoryBitMask = physicDefine.heart.rawValue
//        heart.physicsBody?.contactTestBitMask = physicDefine.astronaut.rawValue
//        heart.physicsBody?.collisionBitMask = physicDefine.astronaut.rawValue
            
        fallingHearts.append(heart)
    }
 
    func randomPositionInScreen() -> CGPoint {
        return CGPoint(x: CGFloat.random(in: 0.3*self.size.width...self.size.width*0.7), y: CGFloat.random(in: 0.3*self.size.height...self.size.height*0.7))
    }
    
    func showToast(_ pos: CGPoint) {
        toastLbl.position = pos
        toastLbl.removeAllActions()
        toastLbl.run(SKAction.sequence([SKAction.unhide(), SKAction.moveBy(x: 0, y: 100, duration: 1.0), SKAction.hide()]))
    }
    
    func addExplodeEffect(pos : CGPoint, imageNamed: String) {
        let bombLbl = Sprite(imageNamed: imageNamed, size: CGSize.withPercentScaled(roundByWidth: 5), position: pos, zPosition: 3)
        bombLbl.run(SKAction.sequence([SKAction.scale(by: 1.5, duration: 0.3),
                                          SKAction.removeFromParent()
        ]))
        
        addChild([bombLbl])
    }
    
    func addOneLbl(pos : CGPoint, score : Int, color : UIColor) {
        let add_oneLbl:Label
        add_oneLbl = Label(text: "+\(score)", fontSize: 20, fontName: GameConfig.fontText, color: color, position: CGPoint(x: pos.x+10, y: pos.y+10), zPosition: GameConfig.zPosition.layer_5)
        add_oneLbl.run(SKAction.sequence([SKAction.scale(by: 1.3, duration: 0.5),
                                          SKAction.removeFromParent()
        ]))
        addChild([add_oneLbl])
    }
    
    func decHeart() {
        nHeart -= 1
        displayHearts(number: nHeart)
    }
    
    func increHeart() {
        if nHeart < maxHeart {
            nHeart += 1
            displayHearts(number: nHeart)
        }
    }
    
    func compensationAngle(angle : CGFloat) -> CGFloat {
        return angle - CGFloat.pi/2
    }
    
    func betaAngle(point0 : CGPoint, point1 : CGPoint) -> CGFloat {
        return CGFloat(atan2f(Float(point1.y - point0.y), Float(point1.x - point0.x)))
    }
    
    func randomPositionAboveScreenEspecially() -> CGPoint {
        return CGPoint(x: CGFloat.random(in: self.size.width*0.3...self.size.width*0.7), y: self.size.height)
    }
    
    func randomPositionBottomScreenEspecially() -> CGPoint {
        return CGPoint(x: CGFloat.random(in: self.size.width*0.3...self.size.width*0.7), y: 0)
    }
    
    func randomPositionLeftScreenEspecially() -> CGPoint {
        return CGPoint(x: 0, y: CGFloat.random(in: self.size.height*0.3...self.size.height*0.7))
    }
    
    func randomPositionRightScreenEspecially() -> CGPoint {
        return CGPoint(x: self.size.width, y: CGFloat.random(in: self.size.height*0.3...self.size.height*0.7))
    }
    
    func changeBackground() {
        if UserDefaults.standard.integer(forKey: "currentSkin") == 1 {
            backgroundSpr.texture = SKTexture(imageNamed: "Images/background1.png")
        } else if UserDefaults.standard.integer(forKey: "currentSkin") == 2 {
            backgroundSpr.texture = SKTexture(imageNamed: "Images/background2.png")
        } else if UserDefaults.standard.integer(forKey: "currentSkin") == 3 {
            backgroundSpr.texture = SKTexture(imageNamed: "Images/background3.png")
        } else if UserDefaults.standard.integer(forKey: "currentSkin") == 4 {
            backgroundSpr.texture = SKTexture(imageNamed: "Images/background4.png")
        }
    }
    
    func randPosOutRect() -> CGPoint {
        var randX:CGFloat
        var randY:CGFloat
        
        if Int.random(in: (0...1)) == 0 {
            randX = CGFloat.random(in: -self.size.width*0.2...0)
        } else {
            randX = CGFloat.random(in: self.size.width...self.size.width*1.2)
        }
        
        if Int.random(in: (0...1)) == 0 {
            randY = CGFloat.random(in: -self.size.height*0.2...0)
        } else {
            randY = CGFloat.random(in: self.size.height...self.size.height*1.2)
        }
        
        return CGPoint(x: randX, y: randY)
    }

    func randPosInRect() -> CGPoint {
        var randX:CGFloat
        var randY:CGFloat
        
        randX = CGFloat.random(in: 0...self.size.width)
        randY = CGFloat.random(in: 0...self.size.height)
        
        return CGPoint(x: randX, y: randY)
    }
    
    func flipSpr(spr : Sprite, posEnd: CGPoint, isLeft : inout Bool) {
        if isLeft == true && spr.position.x < posEnd.x {
            spr.xScale = -1
            isLeft = false
        } else if isLeft == false && spr.position.x > posEnd.x {
            spr.xScale = 1
            isLeft = true
        }
    }
    
    func addHeartEffect(imageNamed: String, pos : CGPoint) {
        let heart = Sprite(imageNamed: imageNamed, size: CGSize.withPercentScaled(roundByWidth: 8), position: pos, zPosition: 3)
        heart.run(SKAction.fadeOut(withDuration: 0.5))
        addChild(heart)
        heart.run(SKAction.sequence([
            SKAction.scale(to: 1.5, duration: 0.5),
            SKAction.removeFromParent(),
        ]))
        
    }
    
    func addTickMark(pos : CGPoint) {
        let tick_mark = Sprite(imageNamed: "_tick_mark.png", size: CGSize.withPercentScaled(roundByWidth: 5), position: CGPoint(x: pos.x, y: pos.y + 16), zPosition: 2)
        addChild(tick_mark)
        self.run(SKAction.sequence([
            SKAction.wait(forDuration: 0.3),
            SKAction.run {
                tick_mark.removeFromParent()
            }
        ]))
    }
    
    func randomColor() -> UIColor {
        switch Int.random(in: 1...5) {
        case 1:
            return #colorLiteral(red: 0.4686641924, green: 1, blue: 0.2689790707, alpha: 1)
        case 2:
            return #colorLiteral(red: 0.4951277004, green: 0.361221467, blue: 1, alpha: 1)
        case 3:
            return #colorLiteral(red: 0.9810759391, green: 0.345651741, blue: 0.2520267362, alpha: 1)
        case 4:
            return #colorLiteral(red: 0.8863341969, green: 0.1393614121, blue: 0.06643594549, alpha: 1)
        default:
            return #colorLiteral(red: 0.1068250058, green: 0.06095791443, blue: 0.8863341969, alpha: 1)
        }
    }
    
    func resetPlayer(_player : Sprite) {
        _player.alpha = 0.5
        _player.physicsBody = nil
        self.run(SKAction.sequence([
            SKAction.wait(forDuration: 0.5),
            SKAction.run {
                _player.alpha = 1
                _player.physicsBody = SKPhysicsBody(circleOfRadius: _player.size.width/3)
                _player.physicsBody?.isDynamic = true
                _player.physicsBody?.affectedByGravity = false
                _player.physicsBody?.categoryBitMask = physicDefine.player.rawValue
                _player.physicsBody?.contactTestBitMask = physicDefine.enemy.rawValue
                _player.physicsBody?.collisionBitMask = physicDefine.enemy.rawValue
            }
        ]))
    }
}

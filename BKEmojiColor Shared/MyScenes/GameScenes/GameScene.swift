
import Foundation
import SpriteKit

class GameScene : Scene, SKPhysicsContactDelegate {
    
    
    let toastLbl = Label(text: "Speed Up", fontSize: 20, fontName: GameConfig.fontText, color: UIColor.green, position: CGPoint.zero, zPosition: 7)

    var hearts = [Sprite()]
    var nHeart:Int = 0
    var maxHeart: Int = 0
    var fallingHearts = [Sprite()]
    
    var progressBar = IMProgressBar(emptyImageName: "spr_progress_bar",filledImageName: "spr_progress_bar_level")
    var progressX: CGFloat = 1
    
    var progressBarDec: CGFloat = 0
    
    // New
    
    var moveNode:SKNode?
    var location0 = CGPoint.zero
    enum physicDefine:UInt32{
        case player = 0
        case line = 1
        case enemy = 2
    }
    
    var firstPlayer: Bool = true
    
    // New
    
    var aboveRectangles = [SKShapeNode()]
    var bottomRectangles = [SKShapeNode()]
    
    let fillColor = #colorLiteral(red: 0.6600097215, green: 1, blue: 0.9833781512, alpha: 1)
    let normalStrokeColor = #colorLiteral(red: 0.3235277243, green: 0.7192866847, blue: 1, alpha: 1)
    let selectStrokeColor = #colorLiteral(red: 0.6094424747, green: 0.307185543, blue: 0.9786838367, alpha: 1)
    let rightStrokeColor = #colorLiteral(red: 1, green: 0.2919802303, blue: 0.9323549114, alpha: 1)
    let wrongStrokeColor = #colorLiteral(red: 0.8397627915, green: 0.07316640224, blue: 0.05286230138, alpha: 1)
    
    var nBottomRectChooseMode: Int = 4
    
    var colors = [#colorLiteral(red: 0.1979285553, green: 1, blue: 0.3622191145, alpha: 1), #colorLiteral(red: 0.9466078368, green: 0.1948649512, blue: 0.05735914573, alpha: 1), #colorLiteral(red: 0.1578507359, green: 0.293118766, blue: 1, alpha: 1), #colorLiteral(red: 0.2318634543, green: 1, blue: 0.9881618297, alpha: 1), #colorLiteral(red: 1, green: 0.2858582022, blue: 0.6281127071, alpha: 1), #colorLiteral(red: 0.2664734773, green: 1, blue: 0.5711733818, alpha: 1), #colorLiteral(red: 1, green: 0.6341988924, blue: 0.2044364695, alpha: 1)]
    var emojis = [1,2,3,4,5,6,7]
    
    var bottomColorArr = [ColorObject()]

    override func didMove(to view: SKView) {
        super.didMove(to: view)
        self.physicsWorld.contactDelegate = self
        
        createGameLayer()
        
        createControlLayer()
       
    }
    
    override func update(_ currentTime: TimeInterval) {
        updateProgressBar()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            
            if soundBtn.contains(location) {
                soundBtn.run(SKAction.scale(to: 0.85, duration: 0.025))
            }
            else if homeBtn.contains(location){
                self.changeSceneTo(scene: MenuScene(size: self.size), withTransition: .push(with: .right, duration: 0.5))
            }
            location0 = location
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first, moveNode != nil {
            let location = touch.location(in: self)
            
//            moveNode?.run(.move(to: location, duration: 0.05))
            

        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            if soundBtn.contains(location) {
                soundBtn.changeSwitchState()
            } else {
                touchOnRectangleChooseMode(_location: location)
            }
            
            
        }
        soundBtn.run(SKAction.scale(to: 1.0, duration: 0.025))
        touchUpAllButtons()
    }
    
    func didBegin(_ contact : SKPhysicsContact) {
        let contactMark = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        
        if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask){
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        }
        else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        
        if gameEnd==false {
            switch contactMark {
            default:
                return
            }
        }
    }
        
}

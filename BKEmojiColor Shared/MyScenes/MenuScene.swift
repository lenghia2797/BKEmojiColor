

import Foundation
import SpriteKit

class MenuScene : Scene  {

    let easyModeBtn = Button(normalName: "menu_back.png", size: CGSize.zero, position: CGPoint.withPercent(35, y: 30), zPosition: GameConfig.zPosition.layer_3)
    
    let mediumModeBtn = Button(normalName: "menu_back.png", size: CGSize.zero, position: CGPoint.withPercent(50, y: 50), zPosition: GameConfig.zPosition.layer_3)
    
    let hardModeBtn = Button(normalName: "menu_back.png", size: CGSize.zero, position: CGPoint.withPercent(65, y: 70), zPosition: GameConfig.zPosition.layer_3)
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        easyModeBtn.size = .sizeOfNode(_sizeOfTexture: SKTexture(imageNamed: "Images/menu_back").size() , _sizeofNode: CGSize.withPercentScaled(roundByWidth: 32))
        
        mediumModeBtn.size = easyModeBtn.size
        
        hardModeBtn.size = easyModeBtn.size
        
        easyModeBtn.addChild(Label(text: "Easy", fontSize: 28, fontName: GameConfig.fontText, color: #colorLiteral(red: 0.9252943894, green: 0.477932212, blue: 0.05914667602, alpha: 1), position: CGPoint.zero, zPosition: mediumModeBtn.zPosition + 0.1))
        
        mediumModeBtn.addChild(Label(text: "Medium", fontSize: 28, fontName: GameConfig.fontText, color: #colorLiteral(red: 0.2520450931, green: 0.4372060848, blue: 0.9686274529, alpha: 1), position: CGPoint.zero, zPosition: mediumModeBtn.zPosition + 0.1))
        
        hardModeBtn.addChild(Label(text: "Hard", fontSize: 28, fontName: GameConfig.fontText, color: #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1), position: CGPoint.zero, zPosition: hardModeBtn.zPosition + 0.1))
        
        //
        addChild([backgroundSpr, hardModeBtn, easyModeBtn, mediumModeBtn, soundBtn])
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            
            if soundBtn.contains(location) {
                soundBtn.run(SKAction.scale(to: 0.85, duration: 0.025))
            }
            //Check press to switch
            
            touchDownButtons(atLocation: location)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            
            soundBtn.changeSwitchState(ifInLocation: location)
            
            if easyModeBtn.contains(location) {
                UserDefaults.standard.set(0, forKey: GameConfig.mode)
                self.changeSceneTo(scene: GameScene(size: self.size), withTransition: .push(with: .left, duration: 0.5))
            }
            else if mediumModeBtn.contains(location) {
                UserDefaults.standard.set(1, forKey: GameConfig.mode)
                self.changeSceneTo(scene: GameScene(size: self.size), withTransition: .push(with: .left, duration: 0.5))
            }
            else if hardModeBtn.contains(location) {
                UserDefaults.standard.set(2, forKey: GameConfig.mode)
                self.changeSceneTo(scene: GameScene(size: self.size), withTransition: .push(with: .left, duration: 0.5))
            }
            
            soundBtn.run(SKAction.scale(to: 1.0, duration: 0.025))
        }
        
        touchUpAllButtons()
    }
}

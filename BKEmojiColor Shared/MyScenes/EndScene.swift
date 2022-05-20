

import Foundation
import SpriteKit

class EndScene : Scene  {

    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        replayBtn.position = CGPoint.withPercent(50, y: 40)
        
        setScore()
        scoreLbl.position = CGPoint.withPercent(50, y: 75)
        bestLbl.position = CGPoint.withPercent(50, y: 60)
        
        Sounds.sharedInstance().playSound(soundName: "Sounds/sound_over.mp3")
        
        /*
        score_backSpr.position = scoreLbl.position
        best_backSpr.position = bestLbl.position
        
        score_backSpr.size = sizeOfNode(_sizeOfTexture: SKTexture(imageNamed: "Images/score_back").size(), _sizeofNode: CGSize.withPercentScaled(roundByWidth: 15))
        best_backSpr.size = sizeOfNode(_sizeOfTexture: SKTexture(imageNamed: "Images/score_back").size(), _sizeofNode: CGSize.withPercentScaled(roundByWidth: 25))
        
        score_backSpr.zPosition = scoreLbl.zPosition - 0.1
        best_backSpr.zPosition = bestLbl.zPosition - 0.1
 
         */
        
//        scoreLbl.attributedText = setStrokeForTextLbl(label: scoreLbl)
//        bestLbl.attributedText = setStrokeForTextLbl(label: bestLbl)
        
        addChild([homeBtn, backgroundSpr, scoreLbl, bestLbl, replayBtn])
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            
            //Check press to switch
            
            touchDownButtons(atLocation: location)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            if homeBtn.contains(location){
                changeSceneTo(scene: MenuScene(size: self.size), withTransition: .doorsOpenHorizontal(withDuration: 0.5))}
            else if replayBtn.contains(location){
                changeSceneTo(scene: GameScene(size: self.size), withTransition: .push(with: .right, duration: 0.5))
            }
            
        }
        
        touchUpAllButtons()
    }
    
    func setStrokeForTextLbl(label : Label) -> NSMutableAttributedString {
        let strokeTextAttributes = [
            NSAttributedString.Key.font : UIFont(name: GameConfig.fontText, size: label.fontSize) ?? UIFont.boldSystemFont(ofSize: label.fontSize),
            NSAttributedString.Key.foregroundColor : UIColor.white,
            NSAttributedString.Key.strokeColor : UIColor.blue,
            NSAttributedString.Key.strokeWidth : -4.0
            
        ] as [NSAttributedString.Key : Any]
        
        return NSMutableAttributedString(string: label.text ?? "LabelStroke", attributes: strokeTextAttributes)
    }
}

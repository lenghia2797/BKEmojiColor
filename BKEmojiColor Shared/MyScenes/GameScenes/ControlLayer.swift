
import Foundation
import SpriteKit

extension GameScene {
    
    func createControlLayer() {
        
    }
    
    func touchOnRectangleMatchMode(_location: CGPoint) {
        for r in bottomRectangles {
            if r.contains(_location) {
                
                if r.strokeColor == normalStrokeColor {
                    r.strokeColor = selectStrokeColor
                } else if r.strokeColor == selectStrokeColor {
                    r.strokeColor = normalStrokeColor
                }
                
            }
        }
        
    }
    
    func touchOnRectangleChooseMode(_location: CGPoint) {
        for r in bottomRectangles {
            if r.contains(_location) {
                
                if r.name == "0" {
                    r.strokeColor = rightStrokeColor
                    aboveRectangles.first?.strokeColor = rightStrokeColor
                    
                    self.run(SKAction.sequence([.wait(forDuration: 0.3),
                                                .run {
                                                    self.setColorChooseMode()
                                                }]))
                    updateScore(s: 1)
                    
                    addExplodeEffectWithSKEmitterNode(_pos: r.position, fileNamed: "Explode_\(Int.random(in: 1...5))")
                } else {
                    r.strokeColor = wrongStrokeColor
                    self.run(SKAction.sequence([.wait(forDuration: 0.3),
                                                .run {
                                                    self.changeSceneTo(scene: EndScene(size: self.size), withTransition: .push(with: .left, duration: 0.5))
                                                }]))
                }
                
            }
        }
        
    }
    
}

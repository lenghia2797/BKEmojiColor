//
//  BaseScene.swift
//  
//
//  Created by  on 3/21/19.
//  Copyright © 2019 . All rights reserved.
//

import SpriteKit

class Scene : SKScene, ToggleButtonDelegate {
    
    var score: Int = 0
    var best: Int = 0
    
    var width: CGFloat = 0
    var height: CGFloat = 0
    
    var buttons = [Button]()
    
    var backgrounds = [Sprite()]
    
    var gameEnd:Bool = false        // Check if endGame or not

    var levelScore:Int = 1
    
    let backgroundSpr = Sprite.init(imageNamed: "background.png", size: CGSize.withPercent(100, height: 100), position: VisibleRect.center(), zPosition: GameConfig.zPosition.layer_1)
     
    let soundBtn = ToggleButton(imageOn: "music-on.png", size: CGSize.withPercentScaled(roundByWidth: 15), position: CGPoint.withPercent(88, y: 90), zPosition: GameConfig.zPosition.layer_5)
     
    let rankingBtn = Button(normalName: "ranking.png", size: CGSize.withPercentScaled(roundByWidth: 18), position: CGPoint.withPercent(35, y: 25), zPosition: GameConfig.zPosition.layer_5)
     
    let homeBtn = Button(normalName: "empty_btn", size: CGSize.withPercentScaled(roundByWidth: 15), position: CGPoint.withPercent(12, y: 90), zPosition: GameConfig.zPosition.layer_5)
    
    let backBtn = Button(normalName: "empty_btn", size: CGSize.withPercentScaled(roundByWidth: 15), position: CGPoint.withPercent(50, y: 15), zPosition: GameConfig.zPosition.layer_5)
    
    let menuBtn = Button(normalName: "empty_btn", size: CGSize.withPercentScaled(roundByWidth: 15), position: CGPoint.withPercent(50, y: 15), zPosition: GameConfig.zPosition.layer_5)
    
    let rateBtn = Button(normalName: "rating.png", size: CGSize.withPercentScaled(roundByWidth: 20), position: CGPoint.withPercent(35, y: 25), zPosition: GameConfig.zPosition.layer_5)
    
    let playBtn = Button(normalName: "empty_btn", size: CGSize.withPercentScaled(roundByWidth: 25), position: CGPoint.withPercent(50, y: 50), zPosition: GameConfig.zPosition.layer_3)
    
    let replayBtn = Button(normalName: "empty_btn", size: CGSize.withPercentScaled(roundByWidth: 25), position: CGPoint.withPercent(50, y: 50), zPosition: GameConfig.zPosition.layer_3)

    let howToPlayBtn = Button(normalName: "empty_btn", size: CGSize.withPercentScaled(roundByWidth: 15), position: CGPoint.withPercent(50, y: 35), zPosition: 3)
     
    var scoreLbl = Label(text: "0", fontSize: 30, fontName: GameConfig.fontNumber, color: GameConfig.textColor, position: CGPoint.withPercent(50, y: 90), zPosition: 5)
     
    var bestLbl = Label(text: "0", fontSize: 30, fontName: GameConfig.fontNumber, color: GameConfig.textColor, position: CGPoint.withPercent(50, y: 68), zPosition: 5)
     
    let shopBtn = Button(normalName: "img_shop", size: CGSize.withPercentScaled(roundByWidth: 18), position: CGPoint.withPercent(50, y: 15), zPosition: 5)
     
    let coinLbl = Label(text: "30", fontSize: 30, fontName: GameConfig.fontNumber, color: UIColor.white, position: CGPoint.withPercent(50, y: 75), zPosition: GameConfig.zPosition.layer_2)
    
//    let score_backSpr = Sprite(imageNamed: "score_back.png", size: CGSize.withPercent(10, height: 10), position: CGPoint.withPercent(50, y: 88), zPosition: 5)
//    let best_backSpr = Sprite(imageNamed: "score_back.png", size: CGSize.withPercent(10, height: 10), position: CGPoint.withPercent(50, y: 88), zPosition: 5)
    
    let homeBtnContent = Sprite(imageNamed: "home", size: CGSize.withPercentScaled(roundByWidth: 8), position: CGPoint.zero, zPosition: 3)
    
    let backBtnContent = Sprite(imageNamed: "back", size: CGSize.withPercentScaled(roundByWidth: 8), position: CGPoint.zero, zPosition: 3)
    
    let menuBtnContent = Sprite(imageNamed: "menu", size: CGSize.withPercentScaled(roundByWidth: 8), position: CGPoint.zero, zPosition: 3)
    
    let playBtnContent = Sprite(imageNamed: "play", size: CGSize.withPercentScaled(roundByWidth: 11.5), position: CGPoint(x: 10, y: 0), zPosition: 3)
    
    let replayBtnContent = Sprite(imageNamed: "replay", size: CGSize.withPercentScaled(roundByWidth: 11.5), position: CGPoint.zero, zPosition: 3)
    
    let howtoplayBtnContent = Sprite(imageNamed: "howtoplay", size: CGSize.withPercentScaled(roundByWidth: 8), position: CGPoint.zero, zPosition: 3)
    
    
    override func didMove(to view: SKView) {
        soundBtn.setSwitchState(UserDefaults.standard.bool(forKey: SoundConfig.playSounds))
        soundBtn.delegate = self
        
        width = self.size.width
        height = self.size.height
        
        homeBtn.addChild(homeBtnContent)
        
        playBtn.addChild(playBtnContent)
        
        replayBtn.addChild(replayBtnContent)
        
        howToPlayBtn.addChild(howtoplayBtnContent)
        
        backBtn.addChild(backBtnContent)
        
        menuBtn.addChild(menuBtnContent)
    }
    
    func changeToggleButtonState(_ sender: ToggleButton) {
        Sounds.sharedInstance().changeSoundAndMusicState()
    }
    
    func addChild(_ button: Button) {
        buttons.append(button)
        super.addChild(button)
    }
    
    func addChild(_ nodes: [SKNode]) {
        for (_, value) in nodes.enumerated() {
            if value.isKind(of: Button.self) {
                addChild(value as! Button)
            }
            else {
                addChild(value)
            }
        }
    }
    
    /**
     We can call this func for change all buttons state on scene to simple.
     */
    func touchUpAllButtons() {
        
        for button in buttons { button.touchUp()}
    }
    
    func touchDownButtons(atLocation location: CGPoint) {
        
        for (_ ,button) in buttons.enumerated() {
            button.touchDown(ifInLocation: location)
        }
    }
    
    func changeSceneTo(scene : SKScene) {
        
        Sounds.sharedInstance().sceneForPlayingSounds = scene
        
        //Show new scene
        view?.presentScene(scene)
        
        //Clean old scene after show new
        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(cleanOldScene), userInfo: nil, repeats: false)
    }
    
    func changeSceneTo(scene : SKScene, withTransition transition: SKTransition) {
        
        Sounds.sharedInstance().sceneForPlayingSounds = scene
        
        //Show new scene
        view?.presentScene(scene, transition: transition)
        
        //Clean old scene after show new
        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(cleanOldScene), userInfo: nil, repeats: false)
    }
    
    func showLeaderboard() {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "showLeaderboard"), object: nil)
    }
    
    func getLeaderboard() {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "getLeaderboard"), object: nil)
    }
    
    func submitScore() {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "submitScore"), object: nil)
    }
    
    func setSoundBtn(_ size:CGSize, _ position:CGPoint) {
        soundBtn.size = size
        soundBtn.position = position
    }
    
    func setRankingBtn(_ size:CGSize, _ position:CGPoint) {
        rankingBtn.size = size
        rankingBtn.position = position
    }
    
    func setHomeBtn(_ size:CGSize, _ position:CGPoint) {
        homeBtn.size = size
        homeBtn.position = position
    }
    
    func setScoreLbl(_ fontSize:CGFloat, _ color:UIColor, _ position:CGPoint) {
        scoreLbl.fontSize = fontSize
        scoreLbl.color = color
        scoreLbl.position = position
    }
    
    func setBestLbl(_ fontSize:CGFloat, _ color:UIColor, _ position:CGPoint) {
        bestLbl.fontSize = fontSize
        bestLbl.color = color
        bestLbl.position = position
    }
    
    func setScore() {
        score = UserDefaults.standard.integer(forKey: GameConfig.currentScore)
        best = UserDefaults.standard.integer(forKey: GameConfig.bestScore)
        
        scoreLbl.text = "Score: " + String(score)
        bestLbl.text = "Best Score: " + String(best)
    }
    
    
    
    /**
     This function helped to clean old scene from something nodes and actions
     */
    @objc func cleanOldScene() {
        removeAllChildren()
        removeAllActions()
        removeFromParent()
        print("GlobalScene: Old scene is been cleaned")
    }
    
    func distance(pos0: CGPoint, pos1: CGPoint) -> Double {
        return Double(sqrt(pow(pos1.y-pos0.y, 2) + pow(pos1.x - pos0.x, 2)))
    }
    
}

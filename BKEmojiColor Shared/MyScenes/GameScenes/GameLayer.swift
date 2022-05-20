
import Foundation
import SpriteKit

extension GameScene {
    
    func createGameLayer(){
       
        setInterFace()
        
        setArr()
        
        setMode()
        
        addProgressbar()
        
        addRectangles(_nRectAbove: 1, _nRectBottom: nBottomRectChooseMode)
        
        setColorChooseMode()
        
    }
    
    func setMode() {
        
        var t:CGFloat = 15
        
        if UserDefaults.standard.integer(forKey: GameConfig.mode) == 0 {
            nBottomRectChooseMode = 4
            t = 40
        } else if UserDefaults.standard.integer(forKey: GameConfig.mode) == 1 {
            nBottomRectChooseMode = 4
            t = 32
        } else {
            nBottomRectChooseMode = 5
            t = 22
        }
        
        progressBarDec = 0.01929/(t)
    }
    
    func makeWrongArray(_rightArr : [Int], _nColor: Int) -> [Int] {
        
        var arr = _rightArr
        arr.shuffle()
        
        var arr2:[Int] = []
        if _nColor == 5 {
            arr2 = [1,2,3,4,5]
        } else if _nColor == 6 {
            arr2 = [1,2,3,4,5,6]
        }
        
        arr2.shuffle()
        
        for i in arr2 {
            if !_rightArr.contains(i) {
                arr[Int.random(in: 0...arr.count-1)] = i
                break
            }
        }
        
        return arr
    }
    
    func makeRandomArr(_nColor: Int, _nPart: Int) -> [Int] {
        var arr:[Int] = []
        if _nColor == 5 {
            arr = [1,2,3,4,5]
        } else if _nColor == 6 {
            arr = [1,2,3,4,5,6]
        }
        
        arr.shuffle()
        
        if _nColor == 6 && _nPart == 4 {
            arr.removeFirst()
            arr.removeFirst()
        } else if _nColor == 5 && _nPart == 4 {
            arr.removeFirst()
        } else if _nColor == 6 && _nPart == 5 {
            arr.removeFirst()
        }
        
        return arr
    }
    
    func createAllBottomColor(_rightArr: [Int] ,_nColor: Int, _nRectBottom: Int) -> [[Int]] {
        var arr: [[Int]] = []
        
        arr.removeAll()
        
        arr.append(_rightArr.shuffled())
        
        for _ in 1..._nRectBottom-1 {
            arr.append(makeWrongArray(_rightArr: _rightArr, _nColor: _nColor))
        }
        
        return arr
    }
    
    func createBottomColorArr(_rightArr: [Int], _nRectBottom: Int) {
        
        // allArr has the first element as the goal element, the rest as the wrong element
        let allArr = createAllBottomColor(_rightArr: _rightArr, _nColor: calNColor(), _nRectBottom: _nRectBottom)
        for i in 0..._nRectBottom-1 {
            
            let color = ColorObject()
            
            color.createObject(_nPart: calNpart(), _part: createPart(), _arr: allArr[i], _colors: colors)
            
            bottomColorArr.append(color)
            
        }
        
    }
    
    func calNpart() -> Int {
        if UserDefaults.standard.integer(forKey: GameConfig.mode) == 0 {
            return 4
        } else if UserDefaults.standard.integer(forKey: GameConfig.mode) == 1 {
            return 4
        } else {
            return 5
        }
    }
    
    func calNColor() -> Int {
        if UserDefaults.standard.integer(forKey: GameConfig.mode) == 0 {
            return 5
        } else if UserDefaults.standard.integer(forKey: GameConfig.mode) == 1 {
            return 6
        } else {
            return 6
        }
    }
    
    func createPart() -> SKShapeNode {
        let part = SKShapeNode()
        var radiusOfShape = self.size.width*0.12
        let path = UIBezierPath()
        
        if UserDefaults.standard.integer(forKey: GameConfig.mode) == 0 {
            
            radiusOfShape = self.size.width*0.1
            
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: radiusOfShape, y: radiusOfShape))
            path.addLine(to: CGPoint(x: -1 * radiusOfShape, y: radiusOfShape))
            path.close()
            
        } else if UserDefaults.standard.integer(forKey: GameConfig.mode) == 1 {
            
            radiusOfShape = self.size.width*0.12
            
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: radiusOfShape/2, y: radiusOfShape/2))
            path.addLine(to: CGPoint(x: 0, y: radiusOfShape))
            path.addLine(to: CGPoint(x: -1 * radiusOfShape/2, y: radiusOfShape/2))
            path.close()
            
        } else {
            
            radiusOfShape = self.size.width*0.13
            
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: radiusOfShape*cos(.pi*3/10), y: radiusOfShape*sin(.pi*3/10)))
            path.addLine(to: CGPoint(x: 0, y: radiusOfShape))
            path.addLine(to: CGPoint(x: -1 * radiusOfShape*cos(.pi*3/10), y: radiusOfShape*sin(.pi*3/10)))
            path.close()
            
        }
        part.path = path.cgPath
        
        part.fillColor = .blue
        part.strokeColor = .orange
        part.lineWidth = 2
        
        return part
    }
    
    func setColorChooseMode() {
        
        removeOldColor()
        
        addChooseColorMode(_nRectBottom: nBottomRectChooseMode)
    }
    
    func addRectangles(_nRectAbove: Int, _nRectBottom: Int) {
        for _ in 1..._nRectAbove {
            let rectangle = SKShapeNode(rect: CGRect(x: -55, y: -55, width: 110, height: 110), cornerRadius: 10)

            rectangle.fillColor = fillColor
            rectangle.strokeColor = normalStrokeColor
            rectangle.lineWidth = 5
            
            addChild(rectangle)
            
            aboveRectangles.append(rectangle)
            
            GameViewHelper.alignItemsHorizontallyWithPadding(padding: width*0.04, items: aboveRectangles, position: CGPoint.withPercent(50, y: 65))
            
            rectangle.run(.repeatForever(SKAction.sequence([.scale(to: 0.9, duration: 1), .scale(to: 1, duration: 1)])))
        }
        
        for _ in 1..._nRectBottom {
            let rectangle = SKShapeNode(rect: CGRect(x: -55, y: -55, width: 110, height: 110), cornerRadius: 10)

            rectangle.fillColor = fillColor
            rectangle.strokeColor = normalStrokeColor
            rectangle.lineWidth = 5
            
            addChild(rectangle)
            
            bottomRectangles.append(rectangle)
            
            GameViewHelper.alignItemsHorizontallyWithPadding(padding: width*0.02, items: bottomRectangles, position: CGPoint.withPercent(50, y: 20))
            
            self.run(.sequence([
                .wait(forDuration: TimeInterval.random(in: 0 ... 1)),
                .run {
                    rectangle.run(.repeatForever(.sequence([
                        .scale(to: 0.9, duration: 1),
                        .scale(to: 1, duration: 1)
                    ])))
                }
            ]))
            
        }
        
        if _nRectBottom == 4 {
            GameViewHelper.alignItemsRowsAndCols(paddingX: width*0.02, paddingY: width*0.02, rows: 2, cols: 2, items: bottomRectangles, position: CGPoint.withPercent(50, y: 25))
        } else if _nRectBottom == 5 {
            GameViewHelper.alignItemsHorizontallyWithPadding(padding: width*0.04, items: [bottomRectangles[0], bottomRectangles[1]], position: CGPoint.withPercent(50, y: 35))
            GameViewHelper.alignItemsHorizontallyWithPadding(padding: width*0.04, items: [bottomRectangles[2], bottomRectangles[3], bottomRectangles[4]], position: CGPoint.withPercent(50, y: 20))
        }
    }
    
    func addChooseColorMode(_nRectBottom: Int) {

        let rightArr = makeRandomArr(_nColor: calNColor(), _nPart: calNpart())
        
        let aboveColor = ColorObject()
        
        aboveColor.createObject(_nPart: calNpart(), _part: createPart(), _arr: rightArr, _colors: colors)
        
        aboveColor.alpha = 0
        aboveColor.setScale(0)
        aboveColor.run(.fadeIn(withDuration: 0.25))
        aboveColor.run(.scale(to: 1, duration: 0.25))
        
        
        if !aboveRectangles.isEmpty {
            aboveRectangles.first?.addChild(aboveColor)
        }
        
        createBottomColorArr(_rightArr: rightArr, _nRectBottom: _nRectBottom)
        
        // Mang nay de tao ngau nhien color vao rectangle
        var arr = [0,1,2,3]
        if _nRectBottom == 5 {
            arr = [0,1,2,3,4]
        }
        arr.shuffle()
        
        var i = 0
        
        for c in bottomRectangles {
            
            let firstPos = CGPoint(x: 0, y: (Bool.random() ? -1 * height * 0.2 : height * 0.2))
            bottomColorArr[arr[i]].position = firstPos
            bottomColorArr[arr[i]].run(.move(to: CGPoint.zero, duration: TimeInterval.random(in: 0.2 ... 0.4)))
            bottomColorArr[arr[i]].alpha = 0
            bottomColorArr[arr[i]].run(.fadeIn(withDuration: 0.4))
            
            c.addChild(bottomColorArr[arr[i]])
            c.name = "\(arr[i])"
            
//            c.addChild(Label(text: c.name ?? "-1", fontSize: 20, fontName: GameConfig.fontText, color: UIColor.black, position: CGPoint.zero, zPosition: 5))
            
            i += 1
            
        }
        
    }
    
    func removeOldColor () {
        for r in aboveRectangles {
            r.strokeColor = normalStrokeColor
            r.removeAllChildren()
        }
        for r in bottomRectangles {
            r.strokeColor = normalStrokeColor
            r.removeAllChildren()
        }
        bottomColorArr.removeAll()
    }
    
    func setInterFace(){
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -5)
//        soundBtn.position = CGPoint.withPercent(8, y: 55)
//        homeBtn.position = CGPoint.withPercent(8, y: 75)
//        scoreLbl.position = CGPoint.withPercent(85, y: 60)
        
        UserDefaults.standard.set(0, forKey: GameConfig.currentScore)
        setScore()

        addChild([soundBtn, backgroundSpr, homeBtn, scoreLbl, toastLbl])

        toastLbl.isHidden = true
    }
    
    func setArr() {
        hearts.removeAll()
        
        aboveRectangles.removeAll()
        bottomRectangles.removeAll()
        
        bottomColorArr.removeAll()
    }
    
    func addExplodeEffectWithSKEmitterNode(_pos: CGPoint, fileNamed: String) {
        if let explodeEffect = SKEmitterNode(fileNamed: fileNamed) {
            explodeEffect.position = _pos
            explodeEffect.zPosition = 6
            addChild(explodeEffect)
        }
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
    
    /* ProgressBar fuction */
    
    func addProgressbar() {
        addChild(progressBar)
        progressBar.setScale(0.13)
        progressBar.position = .withPercent(50, y: 85)
        
        progressBar.setXProgress(xProgress: progressX)
        
    }
    
    func updateProgressBar() {
        if progressX > 0 {
            progressX -= progressBarDec
            progressBar.setXProgress(xProgress: progressX)
        } else {
            changeSceneTo(scene: EndScene(size: self.size), withTransition: .push(with: .left, duration: 0.5))
        }
    }
    
    func updateProgressX(value: CGFloat) {
        progressX += value
        if progressX > 1.05 {
            progressX = 1.05
        }
        
        progressBar.setXProgress(xProgress: progressX)
    }
    
    /* End ProgressBar*/
}

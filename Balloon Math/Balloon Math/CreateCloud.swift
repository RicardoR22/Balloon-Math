//
//  CreateCloud.swift
//  Balloon Math
//
//  Created by Ricardo Rodriguez on 10/15/18.
//  Copyright © 2018 Ricardo Rodriguez. All rights reserved.
//

import SpriteKit

//Class for creating Clouds
class Cloud: SKSpriteNode {
    var answerValue: Int
    var answerLabel = SKLabelNode(text: "2")

    init(scene: SKScene, answer: Int) {
        let texture = SKTexture(imageNamed: "cloud")
        let size = CGSize(width: 150, height: 90)
        self.answerValue = answer
        super.init(texture: texture, color: .red, size: size)
        self.name = "cloud"
        answerLabel.zPosition = 10
        answerLabel.horizontalAlignmentMode = .center
        answerLabel.verticalAlignmentMode = .center
        answerLabel.fontName = "Optima-Bold"
        answerLabel.fontColor = .black
        answerLabel.text = String(self.answerValue)
        
 
        addChild(answerLabel)
        
    }
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented")}
}

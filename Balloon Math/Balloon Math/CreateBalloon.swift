//
//  CreateBalloon.swift
//  Balloon Math
//
//  Created by Ricardo Rodriguez on 10/15/18.
//  Copyright © 2018 Ricardo Rodriguez. All rights reserved.
//

import SpriteKit

class Balloon: SKSpriteNode {
    init(scene: SKScene) {
        let texture = SKTexture(imageNamed: "Balloon")
        let size = CGSize(width: 50, height: 50)
        super.init(texture: texture, color: .red, size: size)
        self.name = "balloon"
//        self.physicsBody?.categoryBitMask = 4
//        self.physicsBody?.collisionBitMask = 4
//        self.physicsBody?.isDynamic = false
    }
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented")}
}

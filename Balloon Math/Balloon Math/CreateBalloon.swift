//
//  CreateBalloon.swift
//  Balloon Math
//
//  Created by Ricardo Rodriguez on 10/15/18.
//  Copyright © 2018 Ricardo Rodriguez. All rights reserved.
//

import SpriteKit

//Class for creating Balloon
class Balloon: SKSpriteNode {
    init(scene: SKScene) {
        let texture = SKTexture(imageNamed: "Balloon")
        let size = CGSize(width: 50, height: 50)
        super.init(texture: texture, color: .red, size: size)
        self.name = "balloon"

    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented")}
}


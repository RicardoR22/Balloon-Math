//
//  GameScene.swift
//  Balloon Math
//
//  Created by Ricardo Rodriguez on 10/15/18.
//  Copyright © 2018 Ricardo Rodriguez. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var balloon : Balloon?
    var cloud1 : Cloud?
    var cloud2 : Cloud?
    var questionLabel = SKLabelNode(fontNamed: "Optima-Bold")
    var arg1: Int?
    var arg2: Int?
    var answer1 = 0
    var answer2 = 0
    

    
    override func didMove(to view: SKView) {
        createBalloon()
        createProblem()
        createResponses()
        createClouds()
    }
    
    // Function that handles creating the balloon
    func createBalloon() {
        
        // Creates instance of Balloon Class
        balloon = Balloon(scene: self)
        
        if let view = self.view {
            // Action for making balloon "float" up
            let moveUp = SKAction.moveBy(x: 0.00, y: view.bounds.height/4, duration: 2.0)
            if let balloon = balloon {
                
                // Positions Balloon at center of screen, horizontally
                balloon.position.x = view.bounds.width/2 - balloon.size.width/2
                // Positions Balloon at bottom of screen
                balloon.position.y = 0
                
                let sequence = SKAction.sequence([moveUp])
                balloon.run(sequence)
            
            }
        }
        addChild(balloon!)
    }
    
    
    // Function that handles creating the clouds
    func createClouds() {
        // Created instances of Cloud class
        cloud1 = Cloud(scene: self, answer: answer1)
        cloud2 = Cloud(scene: self, answer: answer2)
        
        if let view = self.view {
            // Actions for making clouds come down
            let moveDown = SKAction.moveBy(x: 0.00, y: -view.bounds.height/3, duration: 2.0)
            let sequence = SKAction.sequence([moveDown])

            if let cloud1 = cloud1 {
                if let cloud2 = cloud2 {
                    // Set Cloud properties
                    cloud1.position.x = CGFloat(0 + (cloud1.size.width/2))
                    cloud1.position.y = size.height
                    cloud1.zPosition = 2
                    cloud2.position.x = CGFloat(view.bounds.width - (cloud1.size.width - 15))
                    cloud2.position.y = size.height
                    cloud2.zPosition = 2
                    cloud1.run(sequence)
                    cloud2.run(sequence)
                }
            }
            addChild(cloud1!)
            addChild(cloud2!)
        }
    }
    
    // Function that handles creating the math problem
    func createProblem() {
        // generate 2 random integers
        arg1 = Int.random(in: 5...10)
        arg2 = Int.random(in: 5...10)
        
        if let arg1 = arg1{
            if let arg2 = arg2 {
                // Display the problem. Integer1 + Integer2
                questionLabel.text = ("\(arg1) + \(arg2)")

            }
        }
        
        // Set properties for the label displaying the problem
        if let view = self.view{
            questionLabel.fontSize = 30
            questionLabel.fontColor = .black
            questionLabel.position.x = view.bounds.width/2 -  30
            questionLabel.position.y = view.bounds.height/1.5

        }
        addChild(questionLabel)
    }
    
    // Function that handles creating the responses for the question
    func createResponses() {
        // Chooses a random cloud to hold the correct answer
        let correctCloud = Int.random(in: 1...2)
        guard let arg1 = arg1 else {
            print("No Argument 1")
            return
        }
        guard let arg2 = arg2 else {
            print("No Argument 2")
            return
        }
        
        // Assigns the answer values to each cloud.
        if correctCloud == 1 {
            // One gets the correct answer, the other get a random answer.
            answer1 = arg1 + arg2
            answer2 = Int.random(in: 5...10) + Int.random(in: 5...9)
        } else {
            answer2 = arg1 + arg2
            answer1 = Int.random(in: 5...10) + Int.random(in: 5...9)
        }
    }
    
    // Handles the detection of a touch on a cloud
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: self)
        let node = atPoint(location)
        if node.name == "cloud" {
            // Moves balloon to cloud that was touched
            let moveToCloud = SKAction.move(to: location, duration: 1)
            balloon?.run(moveToCloud)
        }
    }
    
}

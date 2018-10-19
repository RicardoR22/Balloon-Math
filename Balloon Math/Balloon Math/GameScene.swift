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
    var timerLabel = SKLabelNode(fontNamed: "Optima-Bold")
    var timeLabel = SKLabelNode(fontNamed: "Optima-Bold")
    var scoreLabel = SKLabelNode(fontNamed: "Optima-Bold")
    var scoreText = SKLabelNode(fontNamed: "Optima-Bold")
    var timer = Timer()
    var expectingInput = true
    var arg1: Int?
    var arg2: Int?
    var answer1 = 0
    var answer2 = 0
    var score = 0
    var timeLimit = 5
    
    
    override func didMove(to view: SKView) {
        self.gameLoop()

    }
    
    // Function that handles creating the balloon
    func createBalloon() {
        
        // Creates instance of Balloon Class
        if balloon == nil {
            balloon = Balloon(scene: self)
        } else {
            balloon?.removeFromParent()
            balloon = Balloon(scene: self)
        }
        
        if let view = self.view {
            // Action for making balloon "float" up
            let moveUp = SKAction.moveBy(x: 0.00, y: view.bounds.height/4, duration: 2.0)
            if let balloon = balloon {
                
                // Positions Balloon at center of screen, horizontally
                balloon.position.x = view.bounds.width/2 - balloon.size.width/2
                // Positions Balloon at bottom of screen
                balloon.position.y = 0
                
                balloon.run(moveUp)
            
            }
        }
        if balloon?.parent == nil {
            addChild(balloon!)
        }
    }
    
    
    // Function that handles creating the clouds
    func createClouds() {
        // Created instances of Cloud class
        if (cloud1 == nil) && (cloud2 == nil) {
            cloud1 = Cloud(scene: self, answer: answer1)
            cloud2 = Cloud(scene: self, answer: answer2)
        } else {
            cloud1?.removeFromParent()
            cloud2?.removeFromParent()
            cloud1 = Cloud(scene: self, answer: answer1)
            cloud2 = Cloud(scene: self, answer: answer2)
        }
        
        
        if let view = self.view {
            // Actions for making clouds come down
            let moveDown = SKAction.moveBy(x: 0.00, y: -view.bounds.height/3, duration: 2.0)

            if let cloud1 = cloud1 {
                if let cloud2 = cloud2 {
                    // Set Cloud properties
                    cloud1.position.x = CGFloat(0 + (cloud1.size.width/2))
                    cloud1.position.y = size.height
                    cloud1.zPosition = 2
                    cloud2.position.x = CGFloat(view.bounds.width - (cloud1.size.width - 15))
                    cloud2.position.y = size.height
                    cloud2.zPosition = 2
                    cloud1.run(moveDown)
                    cloud2.run(moveDown)
                }
            }
            if cloud1?.parent == nil && cloud2?.parent == nil {
                addChild(cloud1!)
                addChild(cloud2!)
            }
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
        if questionLabel.parent == nil {
            addChild(questionLabel)
        }
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
            if answer1 == answer2 {
                answer2 = Int.random(in: 5...10) + Int.random(in: 5...9)
            }
        } else {
            answer2 = arg1 + arg2
            answer1 = Int.random(in: 5...10) + Int.random(in: 5...9)
            if answer1 == answer2 {
                answer1 = Int.random(in: 5...10) + Int.random(in: 5...9)
            }
        }
    }
    
    // Timer function
    func countdown() {
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){ t in
            self.timeLimit -= 1
            self.timerLabel.text = String(self.timeLimit)
            // Checks if time is up
            if self.timeLimit == 0 {
                // Stop timer
                t.invalidate()
                // Notify that time is up
                self.questionLabel.text = "Times up!"
                self.loseAnimations()
                self.score = 0
                self.timeLimit = 5
                // Restart game after a short delay
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.gameLoop()
                }
            }
        }

    }
    
    // The game loop. Responsible for keeping the game running
    func gameLoop() {
        
        if let view = self.view{
            timerLabel.fontSize = 15
            timerLabel.fontColor = .black
            timerLabel.position.x = view.bounds.width - 80
            timerLabel.position.y = view.bounds.height - 150
            timerLabel.text = String(timeLimit)
            
            scoreLabel.fontSize = 15
            scoreLabel.fontColor = .black
            scoreLabel.position.x =  30
            scoreLabel.position.y =  view.bounds.height - 130
            scoreLabel.text = "Score"
            
            scoreText.fontSize = 15
            scoreText.fontColor = .black
            scoreText.position.x =  30
            scoreText.position.y =  view.bounds.height - 150
            scoreText.text = String(score)
            
            timeLabel.fontSize = 15
            timeLabel.fontColor = .black
            timeLabel.position.x = view.bounds.width - 85
            timeLabel.position.y = view.bounds.height - 130
            timeLabel.text = "Time"
        }
        if timerLabel.parent == nil {
            addChild(scoreLabel)
            addChild(scoreText)
            addChild(timeLabel)
            addChild(timerLabel)
        }
        createBalloon()
        createProblem()
        createResponses()
        createClouds()
        // Start timer
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.expectingInput = true
            self.countdown()
        }
    }
    
    // Checks the users answer
    func checkAnswer(node: Cloud)  {
        guard let arg1 = arg1 else {
            print("No Argument 1")
            return
        }
        guard let arg2 = arg2 else {
            print("No Argument 2")
            return
        }
       
        if node.answerValue == arg1 + arg2 {
            questionLabel.text = "Correct!"
            score += 1
            winAnimations()
        } else {
            questionLabel.text = "Wrong"
            loseAnimations()
            score = 0
            timeLimit = 5

        }
    }
    
    // Animations that are used when you get the correct answer
    func winAnimations() {
        guard let view = self.view else{
            return
        }
        guard let balloon = balloon else {
            return
        }
        guard let cloud1 = cloud1 else {
            return
        }
        guard let cloud2 = cloud2 else {
            return
        }
         // SKActions for answer animations
        let balloonFloatUp = SKAction.moveBy(x: 0.00, y: view.bounds.height, duration: 2.0)
        let moveDown = SKAction.moveBy(x: 0.00, y: -view.bounds.height, duration: 2.0)
        let remove = SKAction.removeFromParent()

        let balloonWinSeq = SKAction.sequence([balloonFloatUp, remove])
        let cloudWinSeq = SKAction.sequence([moveDown, remove])
        
        balloon.run(balloonWinSeq)
        cloud1.run(cloudWinSeq)
        cloud2.run(cloudWinSeq)
    }
    
    // Animations that are used when you don't get the correct answer
    func loseAnimations() {
        guard let view = self.view else{
            return
        }
        guard let balloon = balloon else {
            return
        }
        guard let cloud1 = cloud1 else {
            return
        }
        guard let cloud2 = cloud2 else {
            return
        }
         // SKActions for answer animations
        let balloonFloatDown = SKAction.moveBy(x: 0.00, y: -view.bounds.height, duration: 2.0)
        let moveUp = SKAction.moveBy(x: 0.00, y: view.bounds.height, duration: 2.0)
        let scaleDown = SKAction.scale(by: -0.5, duration: 2.0)
        let remove = SKAction.removeFromParent()
        
        let cloudLoseSeq = SKAction.sequence([moveUp, remove])
        let balloonLoseGroup = SKAction.group([balloonFloatDown, scaleDown])
        let balloonLoseSeq = SKAction.sequence([balloonLoseGroup, remove])
        
        balloon.run(balloonLoseSeq)
        cloud1.run(cloudLoseSeq)
        cloud2.run(cloudLoseSeq)
    }
    
    
    // Handles the detection of a touch on a cloud
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: self)
        let node = atPoint(location)
        if node.name == "cloud" && expectingInput == true {
            expectingInput = false
            // Moves balloon to cloud that was touched
            let moveToCloud = SKAction.move(to: location, duration: 1)
            balloon?.run(moveToCloud)
            self.timer.invalidate()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.checkAnswer(node: node as! Cloud)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.timeLimit = 5
                self.gameLoop()
            }
        }
    }
    
}

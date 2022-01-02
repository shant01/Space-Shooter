//
//  GameScene.swift
//  Space Shooter
//
//  Created by Shant Hovagimian on 1/1/22.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var starfield: SKEmitterNode!
    var player : SKSpriteNode!
    
    var scoreLabel : SKLabelNode!
    var score: Int = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    
    var possibleAliens = ["alien", "alien2", "alien3"]
    
    var gameTimer: Timer!
    override func didMove(to view: SKView) {
        
        self.anchorPoint = CGPoint(x: 0, y: 0)
        starfield = SKEmitterNode(fileNamed: "Starfield")
        starfield.position = CGPoint(x: self.frame.midX, y: self.frame.maxY )
        starfield.advanceSimulationTime(10)
        self.addChild(starfield)
        starfield.zPosition = -1

        player = SKSpriteNode(imageNamed: "shuttle")
        //player.anchorPoint = CGPoint(x: 0, y: 0)
        player.position = CGPoint(x: self.frame.size.width/2, y: player.size.height/2 + 60 )
        self.addChild(player)

        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsWorld.contactDelegate = self
     
        scoreLabel = SKLabelNode(text: "Score: 0")
        scoreLabel.position = CGPoint(x: 200, y: self.frame.size.height - 100)
        scoreLabel.fontName = "AmericanTypewriter-Bold"
        scoreLabel.fontSize = 36
        scoreLabel.fontColor = .white
        score = 0
        self.addChild(scoreLabel)
        
        
        
        gameTimer = Timer.scheduledTimer(timeInterval: 0.75, target: self, selector: #selector(addAlien), userInfo: nil, repeats: true )
        
    }

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    //MARK: - Add Alien
    
    @objc func addAlien() {
        possibleAliens = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: possibleAliens) as! [String]
        
        let alien = SKSpriteNode(imageNamed: possibleAliens[0])
        
        let randomPos = GKRandomDistribution(lowestValue: 0, highestValue: Int(self.frame.maxX))
        let position = CGFloat(randomPos.nextInt())
        
        alien.position = CGPoint(x: position, y: self.frame.maxY + alien.size.height)
        
        alien.physicsBody = SKPhysicsBody(rectangleOf: alien.size)
        alien.physicsBody?.isDynamic = true
        
        
        
        
        
        
        
    }
    
}

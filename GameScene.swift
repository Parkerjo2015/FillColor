//
//  GameScene.swift
//  TEST
//
//  Created by Parker Joseph on 2018-06-08.
//  Copyright © 2018 Parker Joseph. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    var ground:UInt32       = 0x00000001 << 0
    var player:UInt32       = 0x00000001 << 1
    var Boundries:UInt32    = 0x00000001 << 2
    var DifColour: UInt32   = 0x00000001 << 3
    var Wall: UInt32        = 0x00000001 << 4
   
    let ball =      SKShapeNode(circleOfRadius: 20)
    let Ground =    SKSpriteNode(imageNamed: "Ground")
    let Boundrie =  SKSpriteNode(imageNamed: "TopWall")
    let DiffColour = SKShapeNode(circleOfRadius: 20)
    let startButton = SKShapeNode(circleOfRadius: 100)
    let background = SKSpriteNode(imageNamed: "Background?")
    let wall = SKSpriteNode()
    var Hold = false
    var timer = Timer()
    var timing = 0.01
    var level = 0
    var wallP = 4.0
    var RandomC = arc4random_uniform(1)
    var usedRed = false
    var usedBlue = false
    var usedYellow = false
    var usedPurple = false
    var Start = false
    var TapS = false
    var TimesB = 0
    var color = ""
    var runTime = 0
    var tapP:CGFloat = 10
    @objc func Updating(){
        RandomC = arc4random_uniform(4)
   wall.position.x -= 10.0
        DiffColour.position.x -= 10.0
        
        if runTime == 0{
            DiffColour.isHidden = false
            wall.position = CGPoint(x: frame.size.width, y: frame.size.height / 2)
            DiffColour.position = CGPoint(x: wall.position.x - 70, y: wall.position.y)
        }
        if Start{
            runTime = 2
            
        }
        if wall.position.x < 0{
            
            DiffColour.isHidden = false
            wall.position = CGPoint(x: frame.size.width, y: frame.size.height / 2)
             DiffColour.position = CGPoint(x: wall.position.x - 70, y: wall.position.y)
           TimesB += 1
            if TimesB == 0{
                wall.texture = SKTexture(imageNamed: "GreenWall")
                color = "green"
                DiffColour.fillColor = UIColor.green
            }
            if TimesB == 1{
                wall.texture = SKTexture(imageNamed: "BlueWall")
               color = "blue"
                DiffColour.fillColor = UIColor.blue
            }
            if TimesB == 2 {
                wall.texture = SKTexture(imageNamed: "RedWall")
                color = "red"
                DiffColour.fillColor = UIColor.red
            }
            if TimesB == 3{
                wall.texture = SKTexture(imageNamed: "Yellow Wall")
                color = "yellow"
                DiffColour.fillColor = UIColor.yellow
                TimesB = 0
            }
            
        }
        
    
           
        
    }
    func Check(){
        if Start{
            timer = Timer.scheduledTimer(timeInterval: timing , target: self, selector: #selector(Updating), userInfo: nil, repeats: true)
            
        }
    }
    override func didMove(to view: SKView) {
        
        
       print("\(color)")
        
        background.size = CGSize(width: frame.size.width, height: frame.size.height)
        background.zPosition = 1
        background.position = CGPoint(x: frame.width / 2, y: frame.height / 2)
    
        addChild(background)
        
        //Start Button
       
        
           // timer = Timer.scheduledTimer(timeInterval: 0.0 , target: self, selector: #selector(Updating), userInfo: nil, repeats: true)
        

       
        //WALL
        wall.position = CGPoint(x: frame.size.width + 100, y: frame.size.height / 2)
        wall.size = CGSize(width: 50, height: frame.size.height)
        wall.zPosition = 4
        wall.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 50, height: frame.size.height))
        wall.physicsBody?.affectedByGravity = false
        wall.texture = SKTexture(imageNamed: "BlueWall")
        addChild(wall)
        
        //BALL
            self.physicsWorld.contactDelegate = self
        ball.physicsBody = SKPhysicsBody(circleOfRadius: 20)
        ball.fillColor = UIColor.blue
       // ball.strokeColor = UIColor.clear
        ball.zPosition = 3
        ball.position = CGPoint(x: frame.width/2, y: frame.height/2)
        addChild(ball)
        
        //GROUND
        Ground.zPosition = 5
        Ground.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: frame.width * 2, height: 100))
        Ground.position = CGPoint(x : frame.width / 2, y: 0 )
        Ground.size = CGSize(width: frame.size.width, height: 100)
        Ground.physicsBody?.affectedByGravity = false
       
        addChild(Ground)
        
        //BOUNDRIE
        Boundrie.zPosition = 6
       Boundrie.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: frame.width, height: 100))
        Boundrie.position = CGPoint(x: frame.width/2, y: frame.height)
        Boundrie.size = CGSize(width: frame.width, height: 100 )
        Boundrie.physicsBody?.affectedByGravity = false
        

        addChild(Boundrie)
       
        //DIFFERENT COLOUR
        DiffColour.zPosition = 7
       DiffColour.physicsBody = SKPhysicsBody(circleOfRadius: 10)
        DiffColour.position = CGPoint(x: wall.position.x - 70, y: wall.position.y)
        DiffColour.strokeColor = UIColor.clear
        DiffColour.fillColor = UIColor.blue
        addChild(DiffColour)
        
        //PHYSICS BODY
        Boundrie.physicsBody?.categoryBitMask = Boundries
        wall.physicsBody?.categoryBitMask = Wall
      DiffColour.physicsBody?.categoryBitMask = DifColour
        ball.physicsBody?.categoryBitMask = player
     
        Ground.physicsBody?.categoryBitMask = ground
        Ground.physicsBody?.linearDamping = 0
        Ground.physicsBody?.angularVelocity = 0
        Boundrie.physicsBody?.isDynamic = false
        DiffColour.physicsBody?.isDynamic = true
        Ground.physicsBody?.isDynamic = false
        wall.physicsBody?.isDynamic = false
        ball.physicsBody?.isDynamic = true
        wall.physicsBody?.contactTestBitMask = player
        ball.physicsBody?.contactTestBitMask = DifColour
        Ground.physicsBody?.contactTestBitMask = player
        Boundrie.physicsBody?.contactTestBitMask = player
       
       
     
     
        ball.physicsBody?.density = 0
        wall.physicsBody?.linearDamping = 1
        
        ball.physicsBody?.affectedByGravity = false
    
    }
 
   func didBegin(_ contact: SKPhysicsContact) {
    let colison:UInt32 = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        if colison == ground | player {
            print("Contact")
            ball.physicsBody?.isDynamic = true
            ball.isHidden = true
        }
    
    if colison == player | Wall{
        if ball.fillColor != DiffColour.fillColor{
            ball.isHidden = true
            
        }
        
        
        if ball.fillColor == DiffColour.fillColor {
            ball.physicsBody?.isDynamic = false
          
        }
       
        
        
        
     
    }
    if colison == player | DifColour{
        DiffColour.isHidden = true
       
        if ball.fillColor == DiffColour.fillColor {
            ball.physicsBody?.isDynamic = false
        }
       
        
        if ball.fillColor != DiffColour.fillColor{
            ball.fillColor = DiffColour.fillColor
                    }
    }
    if colison == player | Boundries{
      ball.isHidden = true
    }
            
          //  ball.isHidden = true
    
 }
    func didEnd(_ contact: SKPhysicsContact) {
        let End:UInt32 = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        if End == player | Wall{
            ball.physicsBody?.isDynamic = true
        }
    }
  
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       
        let touch = touches.first
        //let force = touch?.maximumPossibleForce
       
      
        
      
        if (touch != nil){
           Hold = true
        }

    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
       let touch = touches.first
       if (touch != nil){
            Hold = false
        }
    }
    override func update(_ currentTime: TimeInterval) {
        // wall.position.x -= 1
        
    
        

        if ball.isHidden{
             ball.position = CGPoint(x: frame.width/2, y: frame.height/2)
            Start = false
            ball.fillColor = UIColor.white
            ball.isHidden = false
            runTime = 0
        }
     //   ball.physicsBody?.isDynamic = true
        if ball.fillColor != DiffColour.fillColor{
            ball.physicsBody?.isDynamic = true
        }
        if Hold{
            ball.position.y += tapP
        }
        if Hold == false{
            ball.position.y -= tapP
        }
        }

    }


//
//  GameScene.swift
//  PeevedPenguins
//
//  Created by Davi Rodrigues Chaves on 6/13/16.
//  Copyright (c) 2016 davichaves. All rights reserved.
//

import Foundation
import SpriteKit

class GameScene: SKScene {
    
    /* Game object connections */
    var catapultArm: SKSpriteNode!
    /* Level loader holder */
    var levelNode: SKNode!
    /* Camera helpers */
    var cameraTarget: SKNode?
    /* UI Connections */
    var buttonRestart: MSButtonNode!
    
    override func didMoveToView(view: SKView) {
        /* Set reference to catapultArm node */
        catapultArm = childNodeWithName("catapultArm") as! SKSpriteNode
        
        /* Set reference to the level loader node */
        levelNode = childNodeWithName("//levelNode")
        
        /* Load Level 1 */
        let resourcePath = NSBundle.mainBundle().pathForResource("Level1", ofType: "sks")
        let newLevel = SKReferenceNode (URL: NSURL (fileURLWithPath: resourcePath!))
        levelNode.addChild(newLevel)
        
        /* Set UI connections */
        buttonRestart = childNodeWithName("//buttonRestart") as! MSButtonNode
        
        buttonRestart.selectedHandler = {
            
            /* Grab reference to our SpriteKit view */
            let skView = self.view as SKView!
            
            /* Load Game scene */
            let scene = GameScene(fileNamed:"GameScene") as GameScene!
            
            /* Ensure correct aspect mode */
            scene.scaleMode = .AspectFill
            
            /* Show debug */
            skView.showsPhysics = true
            skView.showsDrawCount = true
            skView.showsFPS = false
            
            /* Restart game scene */
            skView.presentScene(scene)
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Add a new penguin to the scene */
        let resourcePath = NSBundle.mainBundle().pathForResource("Penguin", ofType: "sks")
        let penguin = MSReferenceNode(URL: NSURL (fileURLWithPath: resourcePath!))
        addChild(penguin)
        
        /* Position penguin in the catapult bucket area */
        penguin.avatar.position = CGPoint(x: catapultArm.position.x+32, y: catapultArm.position.y+50)
        
        /* Impulse vector */
        let launchDirection = CGVector(dx: 15, dy: 0)
        let force = launchDirection
        
        /* Apply impulse to penguin */
        penguin.avatar.physicsBody?.applyImpulse(force)
        
        /* Set camera to follow penguin */
        cameraTarget = penguin.avatar
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        /* Check we have a valid camera target to follow */
        if let cameraTarget = cameraTarget {
            
            /* Set camera position to follow target horizontally, keep vertical locked */
            camera?.position = CGPoint(x:cameraTarget.position.x, y:camera!.position.y)
            
            /* Clamp camera horizontal scrolling to our visible scene area only */
            camera?.position.x.clamp(283, 677)
        }
        
    }
    
}
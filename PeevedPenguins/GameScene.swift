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
    
    override func didMoveToView(view: SKView) {
        /* Set reference to catapultArm node */
        catapultArm = childNodeWithName("catapultArm") as! SKSpriteNode
        
        /* Set reference to the level loader node */
        levelNode = childNodeWithName("//levelNode")
        
        /* Load Level 1 */
        let resourcePath = NSBundle.mainBundle().pathForResource("Level1", ofType: "sks")
        let newLevel = SKReferenceNode (URL: NSURL (fileURLWithPath: resourcePath!))
        levelNode.addChild(newLevel)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Add a new penguin to the scene */
        let resourcePath = NSBundle.mainBundle().pathForResource("Penguin", ofType: "sks")
        let penguin = MSReferenceNode(URL: NSURL (fileURLWithPath: resourcePath!))
        addChild(penguin)
        
        /* Position penguin in the catapult bucket area */
        penguin.avatar.position = CGPoint(x: catapultArm.position.x+32, y: catapultArm.position.y+50)
        
        /* Impulse vector */
        let launchDirection = CGVector(dx: 4, dy: 0)
        let force = launchDirection
        
        /* Apply impulse to penguin */
        penguin.avatar.physicsBody?.applyImpulse(force)
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
}
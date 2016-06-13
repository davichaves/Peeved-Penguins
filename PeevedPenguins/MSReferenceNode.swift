//
//  MSReferenceNode.swift
//  PeevedPenguins
//
//  Created by Davi Rodrigues Chaves on 6/13/16.
//  Copyright © 2016 davichaves. All rights reserved.
//

import Foundation
import SpriteKit

class MSReferenceNode: SKReferenceNode {
    
    /* Avatar node connection */
    var avatar: SKSpriteNode!
    
    override func didLoadReferenceNode(node: SKNode?) {
        
        /* Set reference to avatar node */
        avatar = childNodeWithName("//avatar") as! SKSpriteNode
    }
}
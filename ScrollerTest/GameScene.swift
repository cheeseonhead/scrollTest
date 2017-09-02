//
//  GameScene.swift
//  ScrollerTest
//
//  Created by Jeffrey Wu on 2017-09-01.
//  Copyright © 2017 okAy Studios. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene
{
    let numberOfRopes = 4

    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()

    var entityManager: EntityManager!

    var cameraNode: SKCameraNode!
    var tomato: Tomato!

    override func didMove(to view: SKView) {
        super.didMove(to: view)

        entityManager = EntityManager(scene: self)

        addRopes()
        addCamera()
        addTomato()
    }
}

// MARK: Adding Entities
private extension GameScene
{
    func addRopes()
    {
        let spacing = size.width / CGFloat(numberOfRopes)
        let leftSpacing = spacing / 2

        var height = CGFloat(0)
        var ropeHeight = CGFloat(0)
        while height < size.height {
            for i in 0..<numberOfRopes {
                let xPos = leftSpacing + spacing * CGFloat(i)
                let yPos = height

                let rope = Rope()
                if let spriteComponent = rope.component(ofType: SpriteComponent.self) {
                    spriteComponent.node.position = CGPoint(x: xPos, y: yPos)
                    if ropeHeight == 0 {
                        ropeHeight = spriteComponent.node.size.height
                    }
                }
                entityManager.add(rope)
            }

            height+=ropeHeight
        }
    }

    func addCamera()
    {
        cameraNode = SKCameraNode()

        camera = cameraNode
        addChild(cameraNode)

        cameraNode.position = CGPoint(x: size.width/2, y: size.height/2)
    }

    func addTomato()
    {
        let ropeNumber = Int.random(min: 0, max: numberOfRopes)
        let ropes = entityManager.entities(ofType: Rope.self)
        let targetRope = ropes[ropeNumber]

        tomato = Tomato()
        if let spriteComponent = tomato.component(ofType: SpriteComponent.self),
           let ropeSprite = targetRope.component(ofType: SpriteComponent.self) {
            let ropePos = ropeSprite.node.position
            spriteComponent.node.position = CGPoint(x: ropePos.x, y: spriteComponent.node.size.height/4)
        }

        entityManager.add(tomato)
    }
}

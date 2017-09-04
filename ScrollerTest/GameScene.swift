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

    // Update time
    var lastUpdateTimeInterval: TimeInterval = 0

    override func didMove(to view: SKView) {
        super.didMove(to: view)

        entityManager = EntityManager(scene: self)

        addRopes()
        addCamera()
        addTomato()
        addBoards()
    }

    override func update(_ currentTime: TimeInterval)
    {
        let deltaTime = currentTime - lastUpdateTimeInterval
        lastUpdateTimeInterval = currentTime

        entityManager.update(deltaTime)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for touch in touches {
            print("Touch: \(touch.location(in: self))")
        }
    }
}

// MARK: Adding Entities
private extension GameScene
{
    func addRopes()
    {
        for i in 0..<numberOfRopes {
            let xPos = ropeXPos(forIndex: i)

            let rope = Rope(position: CGPoint(x: xPos, y: 0), scene: self)
            entityManager.add(rope)
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
//        let ropeNumber = Int.random(min: 0, max: numberOfRopes)
        let ropeNumber = 0

        tomato = Tomato(entityManager: entityManager)
        if let spriteComponent = tomato.component(ofType: SpriteComponent.self) {
            let xPos = ropeXPos(forIndex: ropeNumber)
            spriteComponent.node.position = CGPoint(x: xPos, y: 50)
            spriteComponent.node.zPosition = 3
        }

        entityManager.add(tomato)
    }

    func addBoards()
    {
        let height: [CGFloat] = [250, 450, 600, 250, 300]
        let index = [0,1,2,2,2]

        for i in 0..<5 {
            let board = WoodenBoard(fittingWidth: ropeSpacing())

            if let spriteComponent = board.component(ofType: SpriteComponent.self) {
                let xPos = ropeXPos(forIndex: index[i])
                spriteComponent.node.position = CGPoint(x: xPos, y: height[i])
                spriteComponent.node.zPosition = 2
            }

            entityManager.add(board)
        }
    }
}

// MARK: Helpers
private extension GameScene
{
    func ropeSpacing() -> CGFloat
    {
        return size.width / CGFloat(numberOfRopes)
    }

    func ropeXPos(forIndex index: Int) -> CGFloat
    {
        let spacing = ropeSpacing()
        let leftSpacing = spacing / 2

        return leftSpacing + spacing * CGFloat(index)
    }
}

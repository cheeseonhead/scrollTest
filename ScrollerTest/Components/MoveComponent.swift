//
// Created by Jeffrey Wu on 2017-09-01.
// Copyright (c) 2017 okAy Studios. All rights reserved.
//

import GameplayKit
import SpriteKit

class MoveComponent: GKAgent2D, GKAgentDelegate
{
    let entityManager: EntityManager

    var targetBoard: WoodenBoard?

    init(maxSpeed: Float, maxAcceleration: Float, radius: Float, entityManager: EntityManager)
    {
        self.entityManager = entityManager

        super.init()
        delegate = self
        self.maxSpeed = maxSpeed
        self.radius = radius
        self.maxAcceleration = maxAcceleration

        self.mass = 1
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func update(deltaTime seconds: TimeInterval)
    {
        super.update(deltaTime: seconds)

//        print("Entity: \(entity)")
        guard let entity = entity,
            let nextBoard = nextBoardInPath() else {
            return
        }

        if let targetBoard = targetBoard, nextBoard.position() == targetBoard.position() {
            return
        }
        targetBoard = nextBoard

        if type(of: entity) != Tomato.self {
            return
        }

        let curPoint = float2(Float(entity.position().x), Float(entity.position().y))
        let targetPoint = float2(Float(entity.position().x), Float(nextBoard.position().y))

        let testNode0 = GKGraphNode2D(point: vector2(Float(entity.position().x), Float(entity.position().y)))
        let testNode = GKGraphNode2D(point: vector2(Float(entity.position().x), Float(entity.position().y + 1)))
        let testNode2 = GKGraphNode2D(point: vector2(Float(nextBoard.position().x), Float(nextBoard.position().y)))
        let testNode3 = GKGraphNode2D(point: vector2(Float(nextBoard.position().x + nextBoard.size().width), Float(nextBoard.position().y)))

        print("Start and End \(testNode.position), \(testNode2.position)")

        let path = GKPath(graphNodes: [testNode0, testNode2, testNode3], radius: 1)
//        let path = GKPath(points: [curPoint, targetPoint], radius: 70, cyclical: false)

//        behavior = GKBehavior(goal: GKGoal(toSeekAgent: nextBoard.component(ofType: MoveComponent.self)!), weight: 1.0)

        behavior = MoveBehavior(path: path, targetSpeed: maxSpeed)
    }

    func agentWillUpdate(_ agent: GKAgent)
    {
        guard let spriteComponent = entity?.component(ofType: SpriteComponent.self) else {
            return
        }

        rotation = Float(spriteComponent.node.zRotation)
        position = float2(spriteComponent.node.position)
    }

    func agentDidUpdate(_ agent: GKAgent)
    {
        guard let spriteComponent = entity?.component(ofType: SpriteComponent.self) else {
            return
        }

//        print("Agent Moved to position \(position)")
        spriteComponent.node.zRotation = CGFloat(rotation)
        spriteComponent.node.position = CGPoint(position)
    }
}

// MARK: Helpers
extension MoveComponent
{
    func nextBoardInPath() -> WoodenBoard?
    {
        let nextBoard: WoodenBoard? = entityManager.entities(ofType: WoodenBoard.self) { (challenge, champion) in

                if let entity = entity, challenge.position().x > entity.position().x ||
                    challenge.position().x + challenge.size().width < entity.position().x ||
                        challenge.position().y < entity.position().y {
                    return false
                }
                else {
                    if champion == nil || challenge.position().y < champion!.position().y {
                        return true
                    }
                    
                    return false
                }
         }

        return nextBoard
    }
}

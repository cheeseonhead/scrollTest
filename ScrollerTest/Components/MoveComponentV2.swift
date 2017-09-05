//
// Created by Jeffrey Wu on 2017-09-03.
// Copyright (c) 2017 okAy Studios. All rights reserved.
//

import SpriteKit
import GameplayKit

class MoveComponentV2: GKComponent
{
    let entityManager: EntityManager

    var destinationPoint: CGPoint?
    var speed: CGFloat

    init(speed: CGFloat, entityManager: EntityManager)
    {
        self.entityManager = entityManager
        self.speed = speed

        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func update(deltaTime seconds: TimeInterval)
    {
        super.update(deltaTime: seconds)

        guard let node = entity?.component(ofType: SpriteComponent.self)?.node else { return }

        let intersectionComponents = entityManager.components(ofType: IntersectionComponent.self)

        var targetPoint: CGPoint? = nil
        var nextPoint: CGPoint? = nil

        for intersectionComponent in intersectionComponents {
            for intersection in intersectionComponent.intersections {
                if intersection.x == node.position.x, intersection.y > node.position.y {
                    if targetPoint == nil || intersection.y < targetPoint!.y {
                        targetPoint = intersection
                        nextPoint = intersectionComponent.intersections[1]
                    }
                }
            }
        }
        
        guard targetPoint != nil, targetPoint != destinationPoint else { return }

        destinationPoint = targetPoint
        let distance = (destinationPoint! - node.position).length()
        let action = SKAction.move(to: targetPoint!, duration: Double(distance / speed))
        let sequence = SKAction.sequence([action])
        
        node.run(sequence)
    }
}

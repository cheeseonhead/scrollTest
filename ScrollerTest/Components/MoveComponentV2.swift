//
// Created by Jeffrey Wu on 2017-09-03.
// Copyright (c) 2017 okAy Studios. All rights reserved.
//

import SpriteKit
import GameplayKit

class MoveComponentV2: GKComponent
{
    let entityManager: EntityManager

    var curDestination: CGPoint?
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

        guard let node = entity?.component(ofType: SpriteComponent.self)?.node,
            let curPosition = entity?.getPosition() else { return }

        let intersectionComponents = entityManager.components(ofType: IntersectionComponent.self)
        
        var bestIntersectionComponent: IntersectionComponent?
        var bestPoint: CGPoint?
        
        for intersectionComponent in intersectionComponents {
            for intersection in intersectionComponent.intersections {
                if intersection.x == curPosition.x, intersection.y > curPosition.y {
                    if bestPoint == nil || intersection.y < bestPoint!.y {
                        bestPoint = intersection
                        bestIntersectionComponent = intersectionComponent
                    }
                }
            }
        }
        
        guard let targetPoint = bestPoint,
            let targetIntersectionComponent = bestIntersectionComponent,
            targetPoint != curDestination else { return }
        curDestination = targetPoint
        
        let path = targetIntersectionComponent.pathToTravel(withStarting: targetPoint)
        
        var actionSequence = [SKAction]()
        
        for index in 0..<path.count {
            let point = path[index]
            var previousPoint = curPosition
            
            if index > 0 {
                previousPoint = path[index - 1]
            }
            
            let distance = (point - previousPoint).length()
            let action = SKAction.move(to: point, duration: Double(distance / speed))
            
            actionSequence.append(action)
        }
        
        node.run(SKAction.sequence(actionSequence))
    }
}

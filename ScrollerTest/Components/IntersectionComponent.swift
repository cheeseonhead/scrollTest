//
// Created by Jeffrey Wu on 2017-09-02.
// Copyright (c) 2017 okAy Studios. All rights reserved.
//

import GameplayKit

class IntersectionComponent: GKComponent
{
    var intersections = [CGPoint(), CGPoint()]
    var entityPosition = CGPoint(x: 0, y: 0)

    override func update(deltaTime seconds: TimeInterval)
    {
        super.update(deltaTime: seconds)

        if let spriteNode = entity?.component(ofType: SpriteComponent.self)?.node {

            guard entityPosition != spriteNode.position else {return}

            entityPosition = spriteNode.position

            let frame = spriteNode.frame
            let yPos = frame.origin.y + frame.size.height / 2
            intersections[0] = CGPoint(x: frame.origin.x, y: yPos)
            intersections[1] = CGPoint(x: frame.origin.x + frame.size.width, y: yPos)
        }
    }
}

//
// Created by Jeffrey Wu on 2017-09-04.
// Copyright (c) 2017 okAy Studios. All rights reserved.
//

import GameplayKit
import SpriteKit

class LeftIntersectionComponent: IntersectionComponent
{
    override func update(deltaTime seconds: TimeInterval)
    {
        super.update(deltaTime: seconds)

        if let spriteNode = entity?.component(ofType: SpriteComponent.self)?.node {
            let frame = spriteNode.frame
            position = CGPoint(x: frame.origin.x, y: frame.origin.y + frame.size.height / 2)
        }
    }
}

//
// Created by Jeffrey Wu on 2017-09-01.
// Copyright (c) 2017 okAy Studios. All rights reserved.
//

import GameplayKit
import SpriteKit

class MoveComponent: GKAgent2D, GKAgentDelegate
{
    let entityManager: EntityManager

    init(maxSpeed: Float, maxAcceleration: Float, radius: Float, entityManager: EntityManager)
    {
        self.entityManager = entityManager

        super.init()
        delegate = self
        self.maxSpeed = maxSpeed
        self.radius = radius
        self.maxAcceleration = maxAcceleration
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

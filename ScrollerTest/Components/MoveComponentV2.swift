//
// Created by Jeffrey Wu on 2017-09-03.
// Copyright (c) 2017 okAy Studios. All rights reserved.
//

import SpriteKit
import GameplayKit

class MoveComponentV2: GKComponent
{
    let entityManager: EntityManager

    var targetIntersection: IntersectionComponent?

    init(entityManager: EntityManager)
    {
        self.entityManager = entityManager

        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

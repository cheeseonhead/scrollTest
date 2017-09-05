//
// Created by Jeffrey Wu on 2017-09-01.
// Copyright (c) 2017 okAy Studios. All rights reserved.
//

import GameplayKit
import SpriteKit

class Tomato: GKEntity
{
    init(entityManager: EntityManager)
    {
        super.init()

        let texture = SKTexture(imageNamed: "Spaceship")
        let spriteComponent = SpriteComponent(texture: texture)

        spriteComponent.node.scale(toWidth: 100)

        addComponent(spriteComponent)
        addComponent(MoveComponentV2(speed: 100, entityManager: entityManager))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

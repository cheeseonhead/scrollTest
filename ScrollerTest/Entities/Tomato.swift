//
// Created by Jeffrey Wu on 2017-09-01.
// Copyright (c) 2017 okAy Studios. All rights reserved.
//

import GameplayKit
import SpriteKit

class Tomato: GKEntity
{
    override init()
    {
        super.init()

        let texture = SKTexture(imageNamed: "Spaceship")
        let spriteComponent = SpriteComponent(texture: texture)

        spriteComponent.node.scale(toWidth: 100)

        addComponent(spriteComponent)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

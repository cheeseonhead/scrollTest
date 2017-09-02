//
// Created by Jeffrey Wu on 2017-09-02.
// Copyright (c) 2017 okAy Studios. All rights reserved.
//

import GameplayKit
import SpriteKit

class WoodenBoard: GKEntity
{
    override init()
    {
        super.init()

        let texture = SKTexture(imageNamed: "WoodenBoard")
        let spriteComponent = SpriteComponent(texture: texture)

        addComponent(spriteComponent)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

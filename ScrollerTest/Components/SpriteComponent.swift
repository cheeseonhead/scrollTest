//
// Created by Jeffrey Wu on 2017-09-01.
// Copyright (c) 2017 okAy Studios. All rights reserved.
//

import SpriteKit
import GameplayKit

class SpriteComponent: GKComponent
{
    let node: SKSpriteNode

    init(texture: SKTexture)
    {
        node = SKSpriteNode(texture: texture)
        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

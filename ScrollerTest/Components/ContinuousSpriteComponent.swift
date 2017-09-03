//
// Created by Jeffrey Wu on 2017-09-03.
// Copyright (c) 2017 okAy Studios. All rights reserved.
//

import GameplayKit
import SpriteKit

class ContinuousSpriteComponent: GKComponent
{
    weak var scene: SKScene?

    init(scene: SKScene)
    {
        self.scene = scene
        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

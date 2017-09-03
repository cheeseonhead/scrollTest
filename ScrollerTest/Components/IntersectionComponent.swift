//
// Created by Jeffrey Wu on 2017-09-02.
// Copyright (c) 2017 okAy Studios. All rights reserved.
//

import GameplayKit

class IntersectionComponent: GKComponent
{
    var position: CGPoint

    init(position: CGPoint)
    {
        self.position = position

        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

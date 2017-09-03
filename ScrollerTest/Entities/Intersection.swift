//
// Created by Jeffrey Wu on 2017-09-02.
// Copyright (c) 2017 okAy Studios. All rights reserved.
//

import GameplayKit

class Intersection: GKEntity
{
    init(position: CGPoint)
    {
        super.init()
        
        let intersectionComponent = IntersectionComponent(position: position)
        addComponent(intersectionComponent)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

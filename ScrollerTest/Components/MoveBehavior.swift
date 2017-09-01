//
// Created by Jeffrey Wu on 2017-09-01.
// Copyright (c) 2017 okAy Studios. All rights reserved.
//

import GameplayKit

class MoveBehavior: GKBehavior
{
    init(path: GKPath)
    {
        super.init()

        setWeight(1.0, for: GKGoal(toFollow: path, maxPredictionTime: 1.0, forward: true))
    }
}

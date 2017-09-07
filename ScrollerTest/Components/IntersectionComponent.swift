//
// Created by Jeffrey Wu on 2017-09-02.
// Copyright (c) 2017 okAy Studios. All rights reserved.
//

import GameplayKit

class IntersectionComponent: GKComponent
{
    let intersectAnchors: [CGPoint]

    var intersections = [CGPoint]()
    var entityPosition = CGPoint(x: 0, y: 0)
    var previousFrame: CGRect?

    init(anchors: [CGPoint])
    {
        intersectAnchors = anchors

        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func update(deltaTime seconds: TimeInterval)
    {
        super.update(deltaTime: seconds)
        
        guard let frame = entity?.frame(), frame != previousFrame else {
            return
        }
        previousFrame = frame
        
        intersections = [CGPoint]()
        for anchor in intersectAnchors {
            let anchorPosition = frame.position(forAnchor: anchor)
            
            intersections.append(anchorPosition)
        }
    }
    
    func pathToTravel(forward: Bool)
    {
        if forward {
            return intersections
        }
        else {
            return intersections.reversed()
        }
    }
}

//
// Created by Jeffrey Wu on 2017-09-01.
// Copyright (c) 2017 okAy Studios. All rights reserved.
//

import Foundation
import SpriteKit

extension Int
{
    static func random(min: Int, max: Int) -> Int
    {
        assert(max > min)
        let upperBound = UInt32(max - min)
        return Int(arc4random_uniform(upperBound)) + min
    }
}

extension SKSpriteNode
{
    func scale(toWidth width: CGFloat)
    {
        let ratio = size.height/size.width
        let newHeight = ratio * width

        size = CGSize(width: width, height: newHeight)
    }
}
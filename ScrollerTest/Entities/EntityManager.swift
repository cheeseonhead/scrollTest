//
// Created by Jeffrey Wu on 2017-09-01.
// Copyright (c) 2017 okAy Studios. All rights reserved.
//

import SpriteKit
import GameplayKit

class EntityManager
{
    weak var scene: SKScene?

    var entities = Set<GKEntity>()

    init(scene: SKScene) {
        self.scene = scene
    }
}

// MARK: Editing
extension EntityManager
{
    func add(_ entity: GKEntity)
    {
        entities.insert(entity)

        if let spriteNode = entity.component(ofType: SpriteComponent.self)?.node
        {
            scene?.addChild(spriteNode)
        }
    }
}

// MARK: Access
extension EntityManager
{
    func entities<EntityType>(ofType type: EntityType.Type) -> [EntityType]
    {
        var returnEntities = [EntityType]()

        for entity in entities {
            if let matchedEntity = entity as? EntityType {
                returnEntities.append(matchedEntity)
            }
        }

        return returnEntities
    }
}
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
    var toRemove = Set<GKEntity>()
    lazy var componentSystems: [GKComponentSystem] = {
        let moveSystem = GKComponentSystem(componentClass: MoveComponentV2.self)
        let continuousSpriteSystem = GKComponentSystem(componentClass: ContinuousSpriteComponent.self)
        let intersectionSystem = GKComponentSystem(componentClass: IntersectionComponent.self)
        return [moveSystem, continuousSpriteSystem, intersectionSystem]
    }()

    init(scene: SKScene) {
        self.scene = scene
    }

    func update(_ deltaTime: CFTimeInterval)
    {
        for componentSystem in componentSystems {
            componentSystem.update(deltaTime: deltaTime)
        }

        for currentRemove in toRemove {
            entities.remove(currentRemove)
            for componentSystem in componentSystems {
                componentSystem.removeComponent(foundIn: currentRemove)
            }
        }

        toRemove.removeAll()
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

        for componentSystem in componentSystems {
            componentSystem.addComponent(foundIn: entity)
        }
    }

    func remove(_ entity: GKEntity)
    {
        if let spriteNode = entity.component(ofType: SpriteComponent.self)?.node {
            spriteNode.removeFromParent()
        }
        if let component = entity.component(ofType: ContinuousSpriteComponent.self) {
            component.removeFromParent()
        }

        toRemove.insert(entity)
    }
}

// MARK: Access
extension EntityManager
{
    func entities<EntityType>(ofType type: EntityType.Type) -> [EntityType]
    {
        return entities.flatMap { entity in
            if let matched = entity as? EntityType {
                return matched
            }

            return nil
        }
    }

    func entities<EntityType>(ofType type: EntityType.Type, compare: (EntityType, EntityType?) -> Bool) -> EntityType?
    {
        var target: EntityType? = nil

        for entity in entities {
            if let matched = entity as? EntityType {
                if compare(matched, target) {
                    target = matched
                }
            }
        }

        return target
    }

    func components<ComponentType: GKComponent>(ofType type: ComponentType.Type) -> Set<ComponentType>
    {
        var components = Set<ComponentType>()

        for entity in entities {
            if let targetComponent = entity.component(ofType: ComponentType.self) {
                components.insert(targetComponent)
            }
        }

        return components
    }
}

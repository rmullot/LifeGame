//
//  Leaf.h
//  LifeGame
//
//  Created by Romain MULLOT on 13/08/2014.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCSprite.h"

@interface Leaf : CCSprite
{
    
}
// stores the current state of the cell
@property (nonatomic, assign) BOOL isAlive;
// stores the amount of living neighbors
@property (nonatomic, assign) NSInteger livingNeighbours;
- (id)initLeaf;
@end

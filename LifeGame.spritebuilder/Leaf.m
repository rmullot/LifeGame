//
//  Leaf.m
//  LifeGame
//
//  Created by Romain MULLOT on 13/08/2014.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Leaf.h"

@implementation Leaf

- (instancetype)initLeaf {
    self = [super initWithImageNamed:@"GameOfLifeAssets/Assets/leaf.png"];
    
    if (self) {
        self.isAlive = NO;
    }
    
    return self;
}

- (void)setIsAlive:(BOOL)newState {

    _isAlive = newState;
    
    _visible = _isAlive;
}
@end

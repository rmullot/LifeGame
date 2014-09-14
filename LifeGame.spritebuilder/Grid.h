//
//  Grid.h
//  LifeGame
//
//  Created by Romain MULLOT on 13/08/2014.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCSprite.h"

@interface Grid : CCSprite
{
    
}
@property (nonatomic, assign) int totalAlive;
@property (nonatomic, assign) int generation;
-(void)evolveStep;
-(void)rebootGrid;
@end

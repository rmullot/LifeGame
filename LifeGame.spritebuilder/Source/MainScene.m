//
//  MainScene.m
//  PROJECTNAME
//
//  Created by Romain MULLOT on 13/08/2014.
//  Copyright (c) 2013 Apportable. All rights reserved.
//

#import "MainScene.h"
#import "Grid.h"

@interface MainScene()
{
    Grid *_grid;
    CCTimer *_timer;
    CCLabelTTF *_generationLabel;
    CCLabelTTF *_populationLabel;
}
@end

@implementation MainScene

- (id)init
{
    self = [super init];
    
    if (self) {
        _timer = [[CCTimer alloc] init];
    }
    
    return self;
}

- (void)play
{
    //this tells the game to call a method called 'step' every half second.
    [self schedule:@selector(step) interval:0.5f];
}

- (void)pause
{
    [self unschedule:@selector(step)];
}

- (void)restart
{
    [self pause];
    [_grid rebootGrid];
    _grid.generation=0;
    _grid.totalAlive=0;
    _generationLabel.string=@"0";
    _populationLabel.string=@"0";
}

// this method will get called every half second when you hit the play button and will stop getting called when you hi the pause button
- (void)step
{
    [_grid evolveStep];
    _generationLabel.string = [NSString stringWithFormat:@"%d", _grid.generation];
    _populationLabel.string = [NSString stringWithFormat:@"%d", _grid.totalAlive];
}

@end

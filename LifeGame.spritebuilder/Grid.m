//
//  Grid.m
//  LifeGame
//
//  Created by Romain MULLOT on 13/08/2014.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Grid.h"
#import "Leaf.h"

static const int ROWS = 8;
static const int COLUMNS = 10;

@interface Grid()
{
    NSMutableArray *_gridArray;
    float _leafWidth;
    float _leafHeight;
}
-(BOOL)isIndexValidForX:(int)x andY:(int)y;
-(void)countNeighbours;
-(void)updateLeaves;
@end

@implementation Grid

- (void)onEnter
{
    [super onEnter];
    
    [self setupGrid];
    
    self.userInteractionEnabled = YES;
}

- (void)setupGrid
{
    _leafWidth = self.contentSize.width / COLUMNS;
    _leafHeight = self.contentSize.height / ROWS;
    
    float x = 0;
    float y = 0;
    
    _gridArray = [NSMutableArray array];
    
    for (int i = 0; i < ROWS; i++) {
        _gridArray[i] = [NSMutableArray array];
        x = 0;
        
        for (int j = 0; j < COLUMNS; j++) {
            Leaf *leaf = [[Leaf alloc] initLeaf];
            leaf.anchorPoint = ccp(0, 0);
            leaf.position = ccp(x, y);
            [self addChild:leaf];
            
            _gridArray[i][j] = leaf;
            
            x+=_leafWidth;
        }
        
        y += _leafHeight;
    }
}

- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchLocation = [touch locationInNode:self];
    
    Leaf *leaf = [self leafForTouchPosition:touchLocation];
    
    leaf.isAlive = !leaf.isAlive;
}

- (Leaf *)leafForTouchPosition:(CGPoint)touchPosition
{
    int i=touchPosition.x/_leafWidth;
    int j=touchPosition.y/_leafHeight;
    
    return _gridArray[j][i];
}

-(void)evolveStep
{
    [self countNeighbours];
    
    [self updateLeaves];
    
    _generation++;
}

//We verify the number of neighbours just around the current entity
-(void)countNeighbours
{
    //Rows
    for (int i = 0; i < [_gridArray count]; i++)
    {
        //Columns
        for (int j = 0; j < [_gridArray[i] count]; j++)
        {
            Leaf *currentLeaf = _gridArray[i][j];
            
            currentLeaf.livingNeighbours = 0;
            
            
            for (int x = (i-1); x <= (i+1); x++)
            {
                for (int y = (j-1); y <= (j+1); y++)
                {
                    // check the index to verify if it is inside the grid
                    BOOL isIndexValid;
                    isIndexValid = [self isIndexValidForX:x andY:y];
                    
                    // If the index is valid and a neighbour, we improve the count of neighbours if he is display.
                    if (!((x == i) && (y == j)) && isIndexValid)
                    {
                        Leaf *neighbour = _gridArray[x][y];
                        if (neighbour.isAlive)
                        {
                            currentLeaf.livingNeighbours += 1;
                        }
                    }
                }
            }
        }
    }
}

- (BOOL)isIndexValidForX:(int)x andY:(int)y
{
    BOOL isIndexValid = YES;
    if(x < 0 || y < 0)
    {
        isIndexValid = NO;
    }
    else if(x >= ROWS || y >= COLUMNS)
    {
        isIndexValid = NO;
    }
    return isIndexValid;
}

-(void)rebootGrid
{
    for (NSArray *arrayTmp in _gridArray) {
        for (Leaf *leaf in arrayTmp) {
            leaf.isAlive=FALSE;
            leaf.livingNeighbours=0;
        }
    }
}

//John Horton Conway's algorithm
//3 neighbours => It's alive
//2 neighbours => The entity keeps its state
//neighbours <2 or >3 => It's dead
-(void)updateLeaves
{
    unsigned int  nbrAliveLeaves=0;
    // Rows
    for (int i = 0; i < [_gridArray count]; i++)
    {
        // Columns
        for (int j = 0; j < [_gridArray[i] count]; j++)
        {
            Leaf *currentLeaf = _gridArray[i][j];
            
            if(currentLeaf.livingNeighbours==3)
            {
                currentLeaf.isAlive=TRUE;
            }
            else
            {
                if (currentLeaf.livingNeighbours<2 || currentLeaf.livingNeighbours>3)
                {
                    currentLeaf.isAlive=FALSE;
                }
            }
            if (currentLeaf.isAlive)
            {
                nbrAliveLeaves++;
            }
        }
    }
    _totalAlive=nbrAliveLeaves;
}
@end

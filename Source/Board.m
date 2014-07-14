//
//  Board.m
//  AaduPuliAttam
//
//  Created by Srinath Giri on 7/13/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Board.h"

@implementation Board {
    CCNode* _lattice1;
    CCNode* _lattice2;
    CCNode* _lattice3;
    NSArray* lattices;
}

static Board *sharedBoard = nil;

- (id)init {
    lattices = [NSArray arrayWithObjects:_lattice1,_lattice2,_lattice3,nil];
    return self;
}

+ (Board *) sharedBoard
{
    if(sharedBoard == nil)
    {
        sharedBoard = [[Board alloc] init];
    }
    return sharedBoard;
}

- (void)placeTiger:(Tiger *)tiger {
    
    CCNode* adjacentLatticePoint = [self getAdjacentLatticePoint:tiger];
    if(adjacentLatticePoint != nil)
    {
        tiger.inBoard = TRUE;
        tiger.position = [tiger convertToNodeSpace:[adjacentLatticePoint convertToWorldSpace:adjacentLatticePoint.position]];
    }
}

- (CCNode *) getAdjacentLatticePoint:(CCSprite *)sprite {
    CCLOG(@"ccp:%f %f",sprite.position.x, sprite.position.y);
    CGPoint spriteposition = [sprite convertToWorldSpace:sprite.position];
    
    for (CCNode* lattice in lattices) {
        if (CGRectContainsPoint([lattice boundingBox], [lattice convertToNodeSpace:spriteposition] )) {
            return lattice;
        }
    }
    return nil;
}

@end

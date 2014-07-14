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

- (void)didLoadFromCCB {
    sharedBoard = self;
    lattices = [NSArray arrayWithObjects:_lattice1,_lattice2,_lattice3,nil];
}

+ (Board *) sharedBoard
{
    if(sharedBoard == nil)
    {
        sharedBoard = [[Board alloc] init];
    }
    return sharedBoard;
}

- (BOOL)placeTiger:(Tiger *)tiger {
    
    CCNode* adjacentLatticePoint = [self getAdjacentLatticePoint:tiger];
    if(adjacentLatticePoint != nil)
    {
        tiger.inBoard = TRUE;
        tiger.position = [tiger convertToNodeSpace:[adjacentLatticePoint convertToWorldSpace:adjacentLatticePoint.position]];
        return true;
    }
    return false;
}

- (CCNode *) getAdjacentLatticePoint:(CCSprite *)sprite {
    
    CGPoint spriteposition = [sprite convertToWorldSpace:sprite.position];
    CCLOG(@"ccp:%f %f",spriteposition.x, spriteposition.y);

    for (CCNode* lattice in lattices) {
        CGPoint latticeposition = [lattice convertToWorldSpace:lattice.position];
        CCLOG(@"ccp:%f %f",latticeposition.x, latticeposition.y);

        if (CGRectContainsPoint([lattice boundingBox], [lattice convertToNodeSpace:spriteposition] )) {
            return lattice;
        }
    }
    return nil;
}

@end

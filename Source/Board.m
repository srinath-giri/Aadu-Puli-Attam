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
    CCNode* _lattice4;
    CCNode* _lattice5;
    CCNode* _lattice6;
    CCNode* _lattice7;
    CCNode* _lattice8;
    CCNode* _lattice9;
    CCNode* _lattice10;
    CCNode* _lattice11;
    CCNode* _lattice12;
    CCNode* _lattice13;
    CCNode* _lattice14;
    CCNode* _lattice15;
    CCNode* _lattice16;
    CCNode* _lattice17;
    CCNode* _lattice18;
    CCNode* _lattice19;
    CCNode* _lattice20;
    CCNode* _lattice21;
    CCNode* _lattice22;
    CCNode* _lattice23;
    NSArray* lattices;
}

static Board *sharedBoard = nil;

- (void)didLoadFromCCB {
    sharedBoard = self;
    lattices = [NSArray arrayWithObjects:_lattice1,_lattice2,_lattice3,_lattice4,_lattice5,_lattice6,_lattice7,_lattice8,_lattice9,_lattice10,_lattice11,_lattice12,_lattice13,_lattice14,_lattice15,_lattice16,_lattice17,_lattice18,_lattice19,_lattice20,_lattice21,_lattice22,_lattice23,nil];
    [Goat movement:true];
    [Tiger movement:false];    
}

+ (Board *)sharedBoard
{
    if(sharedBoard == nil)
    {
        sharedBoard = [[Board alloc] init];
    }
    return sharedBoard;
}

- (BOOL)placeTiger:(Tiger *)tiger {
    
    CCNode* adjacentLatticePoint = [self getAdjacentLatticePoint:tiger];
    //if(adjacentLatticePoint != nil)
    {
        tiger.inBoard = TRUE;
        //tiger.position = [tiger convertToNodeSpace:[adjacentLatticePoint convertToWorldSpace:adjacentLatticePoint.position]];
        [Tiger movement:false];
        [Goat movement:true];
        return true;
    }
    return false;
}

- (BOOL)placeGoat:(Goat *)goat {
    
    CCNode* adjacentLatticePoint = [self getAdjacentLatticePoint:goat];
    //if(adjacentLatticePoint != nil)
    {
        goat.inBoard = TRUE;
        //goat.position = [goat convertToNodeSpace:[adjacentLatticePoint convertToWorldSpace:adjacentLatticePoint.position]];
        [Goat movement:false];
        [Tiger movement:true];
        return true;
    }
    return false;
}

- (CCNode *)getAdjacentLatticePoint:(CCSprite *)sprite {
    
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

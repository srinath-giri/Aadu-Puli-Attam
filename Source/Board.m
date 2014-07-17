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
    CCSprite* _turnGoat;
    CCSprite* _turnTiger;
    NSArray* lattices;
}

static Board *sharedBoard = nil;

- (void)didLoadFromCCB {
    sharedBoard = self;
    lattices = [NSArray arrayWithObjects:_lattice1,_lattice2,_lattice3,_lattice4,_lattice5,_lattice6,_lattice7,_lattice8,_lattice9,_lattice10,_lattice11,_lattice12,_lattice13,_lattice14,_lattice15,_lattice16,_lattice17,_lattice18,_lattice19,_lattice20,_lattice21,_lattice22,_lattice23,nil];
}

+ (Board *)sharedBoard
{
    if(sharedBoard == nil)
    {
        sharedBoard = [[Board alloc] init];
    }
    return sharedBoard;
}

//- (BOOL)placeTiger:(Tiger *)tiger {
    
    //CCNode* adjacentLatticePoint = [self getAdjacentLatticePoint:tiger];
    //if(adjacentLatticePoint != nil)
    //{
        //tiger.position = [self centerOfLatticePoint:adjacentLatticePoint];
        //[tiger removeFromParent];
        //[adjacentLatticePoint addChild:tiger];
        //return true;
    //}
    //return false;
//}

- (BOOL)moveTiger:(Tiger *)tiger {
    
    CCNode* adjacentLatticePoint = [self getAdjacentLatticePoint:tiger];
    
    if(adjacentLatticePoint != nil && [self checkIfValidTigerMove:adjacentLatticePoint])
    {        
        tiger.position = [self centerOfLatticePoint:adjacentLatticePoint];
        [tiger removeFromParent];
        [adjacentLatticePoint addChild:tiger];
    
        _turnTiger.visible = false;
        _turnGoat.visible = true;
        
        [Tiger movement:false];
        [Goat movement:true];
        
        return true;
    }
    return false;
}

- (BOOL)moveGoat:(Goat *)goat {
    
    CCNode* adjacentLatticePoint = [self getAdjacentLatticePoint:goat];
    
    if(adjacentLatticePoint != nil && [self checkIfValidGoatMove:adjacentLatticePoint])
    {
        goat.position = [self centerOfLatticePoint:adjacentLatticePoint];
        [goat removeFromParent];
        [adjacentLatticePoint addChild:goat];
        
        _turnGoat.visible = false;
        _turnTiger.visible = true;
        
        [Goat movement:false];
        [Tiger movement:true];
        
        goat.inBoard = true;
        return true;
    }
    return false;
}

- (CCNode *)getAdjacentLatticePoint:(CCSprite *)sprite {
    
    CGPoint spriteposition = [sprite.parent convertToWorldSpace:sprite.position];
    //CCLOG(@"spriteposition:%f %f",spriteposition.x, spriteposition.y);

    for (CCNode* lattice in lattices) {
        //CCLOG(@"latticeposition:%f %f",lattice.position.x, lattice.position.y);
        
        CGPoint spritepositionlattice = [lattice.parent convertToNodeSpace:spriteposition];
        //CCLOG(@"spritepositionlattice:%f %f",spritepositionlattice.x, spritepositionlattice.y);
              
        if (CGRectContainsPoint([lattice boundingBox], spritepositionlattice )) {
            return lattice;
        }
    }
    return nil;
}

- (BOOL) checkIfValidTigerMove:(CCNode*) destinationLatticePoint {
    return true;
}

- (BOOL) checkIfValidGoatMove:(CCNode*) destinationLatticePoint {
    return true;
}

- (CGPoint) centerOfLatticePoint:(CCNode*) latticePoint {
    return ccp([latticePoint boundingBox].size.width / 2, [latticePoint boundingBox].size.height / 2);
}

- (void) startGame {
    _turnGoat.visible = true;
    _turnTiger.visible = false;
    [Goat movement:true];
    [Tiger movement:false];
}

@end

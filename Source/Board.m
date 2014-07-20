//
//  Board.m
//  AaduPuliAttam
//
//  Created by Srinath Giri on 7/13/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Board.h"

@implementation Board {
    Goat *_goat1;
    Goat *_goat2;
    Goat *_goat3;
    Goat *_goat4;
    Goat *_goat5;
    Goat *_goat6;
    Goat *_goat7;
    Goat *_goat8;
    Goat *_goat9;
    Goat *_goat10;
    Goat *_goat11;
    Goat *_goat12;
    Goat *_goat13;
    Goat *_goat14;
    Goat *_goat15;
    Tiger *_tiger1;
    Tiger *_tiger2;
    Tiger *_tiger3;
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
    CCLabelTTF* _goatsAlive;
    NSArray* lattices;
    NSArray* line1;
    NSArray* line2;
    NSArray* line3;
    NSArray* line4;
    NSArray* line5;
    NSArray* line6;
    NSArray* line7;
    NSArray* line8;
    NSArray* line9;
    NSArray* line10;
    NSArray* lines;
    NSArray* goats;
}

static Board *sharedBoard = nil;

- (void)didLoadFromCCB {
    sharedBoard = self;
    lattices = [NSArray arrayWithObjects:_lattice1,_lattice2,_lattice3,_lattice4,_lattice5,_lattice6,_lattice7,_lattice8,_lattice9,_lattice10,_lattice11,_lattice12,_lattice13,_lattice14,_lattice15,_lattice16,_lattice17,_lattice18,_lattice19,_lattice20,_lattice21,_lattice22,_lattice23,nil];
    line1 = [NSArray arrayWithObjects:_lattice1,_lattice3, _lattice9, _lattice15, _lattice20, nil];
    line2 = [NSArray arrayWithObjects:_lattice1,_lattice4, _lattice10, _lattice16, _lattice21, nil];
    line3 = [NSArray arrayWithObjects:_lattice1,_lattice5, _lattice11, _lattice17, _lattice22, nil];
    line4 = [NSArray arrayWithObjects:_lattice1,_lattice6, _lattice12, _lattice18, _lattice23, nil];
    line5 = [NSArray arrayWithObjects:_lattice2,_lattice3, _lattice4, _lattice5, _lattice6, _lattice7, nil];
    line6 = [NSArray arrayWithObjects:_lattice8,_lattice9, _lattice10, _lattice11, _lattice12, _lattice13, nil];
    line7 = [NSArray arrayWithObjects:_lattice14,_lattice15, _lattice16, _lattice17, _lattice18, _lattice19, nil];
    line8 = [NSArray arrayWithObjects:_lattice20,_lattice21, _lattice22, _lattice23, nil];
    line9 = [NSArray arrayWithObjects:_lattice2,_lattice8, _lattice14, nil];
    line10 = [NSArray arrayWithObjects:_lattice7,_lattice13, _lattice19, nil];
    lines = [NSArray arrayWithObjects:line1,line2,line3,line4,line5,line6,line7,line8,line9,line10, nil];
    goats = [NSArray arrayWithObjects:_goat1,_goat2,_goat3,_goat4,_goat5,_goat6,_goat7,_goat8,_goat9,_goat10,_goat11,_goat12,_goat13,_goat14,_goat15,nil];
}

+ (Board *)sharedBoard
{
    if(sharedBoard == nil)
    {
        sharedBoard = [[Board alloc] init];
    }
    return sharedBoard;
}

- (BOOL)moveTiger:(Tiger *)tiger {
    
    CCNode* adjacentLatticePoint = [self getAdjacentLatticePoint:tiger];
    
    if(adjacentLatticePoint != nil && [self checkIfValidTiger:tiger moveFrom:tiger.parent To:adjacentLatticePoint])
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
    
    if(adjacentLatticePoint != nil && [self checkIfValidGoat:goat moveFrom:goat.parent To:adjacentLatticePoint])
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

- (BOOL) checkIfValidTiger:(Tiger *)tiger moveFrom:(CCNode*) sourceLatticePoint To:(CCNode*) destinationLatticePoint {

    for (NSArray* line in lines) {
        NSUInteger srcidx = [line indexOfObject:sourceLatticePoint];
        NSUInteger dstidx = [line indexOfObject:destinationLatticePoint];
        // Check if move is along a line
        if (srcidx != NSNotFound && dstidx != NSNotFound) {
            NSUInteger moveDistance = abs(srcidx - dstidx);
            // Check if move is to adjacent empty lattice point
            if (moveDistance == 1) {
                if([destinationLatticePoint.children count] == 0)
                    return true;
            }
            // Check if move is a jump to next to next lattice point
            else if (moveDistance == 2) {
                // Check if next to next lattice point is empty
                if([destinationLatticePoint.children count] == 0) {
                    // Check if inbetween lattice point contains a goat
                    CCNode* inBetweenLatticePoint = [line objectAtIndex:((srcidx+dstidx)/2)];
                    CCSprite *spriteInBetween = [inBetweenLatticePoint.children objectAtIndex:0];
                    if ([spriteInBetween class] == [Goat class])
                    {
                        [self eatGoat:(Goat*)spriteInBetween];
                        return true;
                    }
                }
            }
        }
    }
    return false;
}

- (void) eatGoat:(Goat *) goat {
    CCParticleSystem *explosion = (CCParticleSystem *)[CCBReader load:@"GoatExplosion"];
    explosion.autoRemoveOnFinish = TRUE;
    explosion.position = goat.position;
    [goat.parent addChild:explosion];
    [goat removeFromParent];
    goat.isAlive = false;
    [_goatsAlive setString:[NSString stringWithFormat:@"%i", [self numberOfGoatsAlive]]];
}

- (BOOL) checkIfValidGoat:(Goat *)goat moveFrom:(CCNode *)sourceLatticePoint To:(CCNode *)destinationLatticePoint {

    if(goat.inBoard == false) {
        if([destinationLatticePoint.children count] == 0)
            return true;
    }
    // Check if all the goats have been placed in the board to allow any moves
    else if([self checkIfAllGoatsAreInBoard]){
        for (NSArray* line in lines) {
            NSUInteger srcidx = [line indexOfObject:sourceLatticePoint];
            NSUInteger dstidx = [line indexOfObject:destinationLatticePoint];
            // Check if move is along a line
            if (srcidx != NSNotFound && dstidx != NSNotFound) {
                NSUInteger moveDistance = abs(srcidx - dstidx);
                // Check if move is to an adjacent empty lattice point
                if (moveDistance == 1) {
                    if([destinationLatticePoint.children count] == 0)
                        return true;
                }
            }
        }
    }
    return false;
}

- (BOOL) checkIfAllGoatsAreInBoard {
    for (Goat* goat in goats) {
        if(goat.inBoard == false) return false;
    }
    return true;
}

- (NSUInteger) numberOfGoatsAlive {
    NSUInteger aliveCount = 0;
    for (Goat* goat in goats) {
        if(goat.isAlive) aliveCount++;
    }
    return aliveCount;
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

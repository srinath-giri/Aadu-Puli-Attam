//
//  Board.h
//  AaduPuliAttam
//
//  Created by Srinath Giri on 7/13/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCSprite.h"
#import "Tiger.h"
#import "Goat.h"

@interface Board : CCNode

+ (Board*) sharedBoard;
- (BOOL) moveTiger:(Tiger *) tiger;
- (BOOL) moveGoat:(Goat *) goat;
- (BOOL) checkIfValidTiger:(Tiger *)tiger moveFrom:(CCNode*) sourceLatticePoint To:(CCNode*) destinationLatticePoint;
- (BOOL) checkIfValidGoat:(Goat *)goat moveFrom:(CCNode *)sourceLatticePoint To:(CCNode *)destinationLatticePoint;
- (BOOL) checkIfAllGoatsAreInBoard;
- (void) eatGoat:(Goat *) goat;
- (NSUInteger) numberOfGoatsAlive;
- (void) overlayTigerSprite:(BOOL)visible on:(Tiger*) tiger;
- (void) overlayGoatSprite:(BOOL)visible on:(Goat*) goat;
- (CCNode *)getAdjacentLatticePoint:(CCNode *)sprite;
- (CGPoint) centerOfLatticePoint:(CCNode*)latticePoint;
- (void) startGame;
- (void) glowTigers:(BOOL)on;
- (void) glowGoats:(BOOL)on;
- (void) glowLattices:(BOOL)on forTiger:(Tiger*)tiger;
- (void) glowLattices:(BOOL)on forGoat:(Goat*)goat;

@end

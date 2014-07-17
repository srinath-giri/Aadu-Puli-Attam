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
//- (BOOL) placeTiger:(Tiger *) tiger;
- (BOOL) moveTiger:(Tiger *) tiger;
- (BOOL) moveGoat:(Goat *) goat;
- (BOOL) checkIfValidTigerMove:(CCNode*) destinationLatticePoint;
- (BOOL) checkIfValidGoatMove:(CCNode*) destinationLatticePoint;
- (CGPoint) centerOfLatticePoint:(CCNode*) latticePoint;
- (void) startGame;

@end

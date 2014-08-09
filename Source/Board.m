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
    CCSprite* _goatsAliveSprite;
    CCSprite* _overlayTiger;
    CCSprite* _overlayGoat;
    CCSprite* _arrow;
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
    
    if(adjacentLatticePoint != nil)
    {
        BOOL jump = false;
        Goat *goatInBetween = nil;
        
        if([self checkIfValidTiger:tiger moveFrom:tiger.parent To:adjacentLatticePoint andIsA:&jump over:&goatInBetween]) {
            tiger.position = [self centerOfLatticePoint:adjacentLatticePoint];
            [tiger removeFromParent];
            [adjacentLatticePoint addChild:tiger];
            if(jump)[self eatGoat:goatInBetween];
        
            CCActionFadeOut *fadeOut = [CCActionFadeOut actionWithDuration:0.5];
            [_turnTiger runAction:fadeOut];
            CCActionFadeIn *fadeIn = [CCActionFadeIn actionWithDuration:0.5];
            [_turnGoat runAction:fadeIn];
        
            [Tiger movement:false];
            [self movementGoats:true];
            [self glowTigers:false];
            [self glowGoats:true];
            return true;
        }
    }
    [self glowTigers:true];
    return false;
}

- (BOOL)moveGoat:(Goat *)goat {
    
    CCNode* adjacentLatticePoint = [self getAdjacentLatticePoint:goat];
    
    if(adjacentLatticePoint != nil && [self checkIfValidGoat:goat moveFrom:goat.parent To:adjacentLatticePoint])
    {
        CGPoint centerOfLattice = [self centerOfLatticePoint:adjacentLatticePoint];
        goat.position = ccp(centerOfLattice.x+6,centerOfLattice.y-10);
        
        [goat pauseHeadShake];
        CCActionRotateTo *resetRotation = [CCActionRotateTo actionWithDuration:0.125 angle:0.0f];
        [goat runAction:resetRotation];
        
        [goat removeFromParent];
        [adjacentLatticePoint addChild:goat];
        
        CCActionFadeOut *fadeOut = [CCActionFadeOut actionWithDuration:0.5];
        [_turnGoat runAction:fadeOut];
        CCActionFadeIn *fadeIn = [CCActionFadeIn actionWithDuration:0.5];
        [_turnTiger runAction:fadeIn];

        [self movementGoats:false];
        [Tiger movement:true];
        [self glowGoats:false];
        [self glowTigers:true];
        goat.inBoard = true;

        return true;
    }
    [self glowGoats:true];
    return false;
}

- (CCNode *)getAdjacentLatticePoint:(CCNode *)sprite {
    
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

- (BOOL) checkIfValidTiger:(Tiger *)tiger moveFrom:(CCNode*) sourceLatticePoint To:(CCNode*) destinationLatticePoint andIsA:(BOOL*) jump over:(Goat**) goat {

    for (NSArray* line in lines) {
        NSUInteger srcidx = [line indexOfObject:sourceLatticePoint];
        NSUInteger dstidx = [line indexOfObject:destinationLatticePoint];
        // Check if move is along a line
        if (srcidx != NSNotFound && dstidx != NSNotFound) {
            NSUInteger moveDistance = abs(srcidx - dstidx);
            // Check if move is to adjacent empty lattice point
            if (moveDistance == 1) {
                if([destinationLatticePoint.children count] == 2)
                    return true;
            }
            // Check if move is a jump to next to next lattice point
            else if (moveDistance == 2) {
                // Check if next to next lattice point is empty
                if([destinationLatticePoint.children count] == 2) {
                    // Check if inbetween lattice point contains a goat
                    CCNode* inBetweenLatticePoint = [line objectAtIndex:((srcidx+dstidx)/2)];
                    if([inBetweenLatticePoint.children count] == 3) {
                        CCSprite *spriteInBetween = [inBetweenLatticePoint.children lastObject];
                        if ([spriteInBetween class] == [Goat class])
                        {
                            if(jump != nil) *jump = true;
                            if(goat != nil) *goat = (Goat *)spriteInBetween;
                            return true;
                        }
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
    explosion.position = ccp(goat.position.x-6,goat.position.y+10);
    [goat.parent addChild:explosion];
    [goat removeFromParent];
    goat.isAlive = false;
    [_goatsAlive setString:[NSString stringWithFormat:@"%i", [self numberOfGoatsAlive]]];
    CCActionJumpBy *jumpAction = [CCActionJumpBy actionWithDuration:1.0f position:ccp(0,0) height:0.025f jumps:1];
    [_goatsAlive runAction:jumpAction];
    
    CCColor *originalColor = _goatsAlive.color;
    CCActionTintTo *tintAction = [CCActionTintTo actionWithDuration:0.5f color:[CCColor redColor]];
    CCActionTintTo *tintReverseAction = [CCActionTintTo actionWithDuration:0.5f color:originalColor];
    CCActionSequence *redAlertAction = [CCActionSequence actions:tintAction,tintReverseAction,nil];
    [_goatsAlive runAction:redAlertAction];
}

- (BOOL) checkIfValidGoat:(Goat *)goat moveFrom:(CCNode *)sourceLatticePoint To:(CCNode *)destinationLatticePoint {

    if(goat.inBoard == false) {
        if([destinationLatticePoint.children count] == 2)
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
                    if([destinationLatticePoint.children count] == 2)
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

- (void) overlayTigerSprite:(BOOL)visible on:(Tiger*)tiger{
    CGPoint tigerposition = [tiger.parent convertToWorldSpace:tiger.position];
    CGPoint overlaytigerposition = [_overlayTiger.parent convertToNodeSpace:tigerposition];
    _overlayTiger.position = ccp(overlaytigerposition.x,overlaytigerposition.y);
    _overlayTiger.visible = visible;
}

- (void) overlayGoatSprite:(BOOL)visible on:(Goat*)goat{
    CGPoint goatposition = [goat.parent convertToWorldSpace:goat.position];
    CGPoint overlaygoatposition = [_overlayGoat.parent convertToNodeSpace:goatposition];
    _overlayGoat.position = ccp(overlaygoatposition.x,overlaygoatposition.y);
    _overlayGoat.visible = visible;
}

- (void) startGame {
    [self movementGoats:true];
    [Tiger movement:false];
    [self glowGoats:true];
}

- (void) glowTigers:(BOOL) on {
    if(on) {
        CCActionScaleTo *scaleUp  = [CCActionScaleTo actionWithDuration:0.3 scale:1.3];
        CCActionScaleTo *scaleDown  = [CCActionScaleTo actionWithDuration:0.3 scale:1.0];
        CCActionSequence *scaleUpDown = [CCActionSequence actions:scaleUp,scaleDown,nil];
        CCActionRepeatForever *scaleUpDownForever = [CCActionRepeatForever actionWithAction:scaleUpDown];
        [_tiger1 runAction:[scaleUpDownForever copy]];
        [_tiger2 runAction:[scaleUpDownForever copy]];
        [_tiger3 runAction:[scaleUpDownForever copy]];
    }
    else {
        [_tiger1 stopAllActions];
        [_tiger2 stopAllActions];
        [_tiger3 stopAllActions];
        [_tiger1 setScale:1.0];
        [_tiger2 setScale:1.0];
        [_tiger3 setScale:1.0];
    }
}

- (void) glowGoats:(BOOL) on {
    if(on) {
        CCActionScaleTo *scaleUp  = [CCActionScaleTo actionWithDuration:0.3 scale:1.2];
        CCActionScaleTo *scaleDown  = [CCActionScaleTo actionWithDuration:0.3 scale:1.0];
        CCActionSequence *scaleUpDown = [CCActionSequence actions:scaleUp,scaleDown,nil];
        CCActionRepeatForever *scaleUpDownForever = [CCActionRepeatForever actionWithAction:scaleUpDown];
        
        if([self checkIfAllGoatsAreInBoard]) {
            for (Goat* goat in goats) {
                [goat runAction:[scaleUpDownForever copy]];
            }
        }
        else {
            for (Goat* goat in goats) {
                if(goat.inBoard == false) {
                    [goat runAction:[scaleUpDownForever copy]];
                    [self showArrow:true forGoat:goat];
                    break;
                }
            }
        }
    }
    else {
        for (Goat* goat in goats) {
        [goat stopAllActions];
        [goat setScale:1.0];
        }
        [self showArrow:false forGoat:nil];
    }
}

- (void) showArrow:(BOOL)enable forGoat:(Goat*) goat{
    
    CCActionMoveBy *moveByPlus  = [CCActionMoveBy actionWithDuration:0.3 position:ccp(6,0)];
    CCActionMoveBy *moveByMinus  = [CCActionMoveBy actionWithDuration:0.3 position:ccp(-6,0)];
    CCActionSequence *movePlusMinus = [CCActionSequence actions:moveByPlus,moveByMinus,nil];
    CCActionRepeatForever *movePlusMinusForever = [CCActionRepeatForever actionWithAction:movePlusMinus];

    if(enable) {
         [_arrow setOpacity:1.0];
        _arrow.position = ccp(goat.previousPosition.x-40,goat.previousPosition.y+10);
         [_arrow runAction:[movePlusMinusForever copy]];
    }
    else {
        [_arrow stopAllActions];
        [_arrow setOpacity:0.0];
    }
    
}

- (void) movementGoats:(BOOL) enable {
    if(enable)
    {
        if([self checkIfAllGoatsAreInBoard]) {
            for (Goat* goat in goats) {
                [goat move:true];
            }
        }
        else {
            for (Goat* goat in goats) {
                if(goat.inBoard == false) {
                    [goat move:true];
                    break;
                }
            }
        }
    }
    else {
        for (Goat* goat in goats) {
            [goat move:false];
        }
    }
}

- (void) glowLattices:(BOOL)on forTiger:(Tiger*)tiger {
    if(on) {
        CCActionRotateBy *rotate90  = [CCActionRotateBy actionWithDuration:0.125 angle:90.0];
        CCActionRepeatForever *spinForever = [CCActionRepeatForever actionWithAction:rotate90];
        for (CCNode* latticePoint in lattices) {
            BOOL jump = false;
            Goat *goatInBetween = nil;
            if ([self checkIfValidTiger:tiger moveFrom:tiger.parent To:latticePoint andIsA:&jump over:&goatInBetween]) {
                CCSprite *spinner = latticePoint.children[0];
                CCLabelTTF *plusOne = latticePoint.children[1];
                [spinner setOpacity:1.0];
                if (jump) {
                    [spinner setColor:[CCColor greenColor]];
                    [plusOne setOpacity:1.0];
                    [plusOne setColor:[CCColor greenColor]];
                }
                [spinner runAction:[spinForever copy]];
            }
        }
    }
    else {
        for (CCNode* latticePoint in lattices) {
            CCSprite *spinner = latticePoint.children[0];
            CCLabelTTF *plusOne = latticePoint.children[1];
            [spinner stopAllActions];
            [spinner setColor:[CCColor whiteColor]];
            [spinner setOpacity:0.0];
            [plusOne setColor:[CCColor whiteColor]];
            [plusOne setOpacity:0.0];
        }
    }
}

- (void) glowLattices:(BOOL)on forGoat:(Goat*)goat {
    if(on) {
        CCActionRotateBy *rotate90  = [CCActionRotateBy actionWithDuration:0.125 angle:90.0];
        CCActionRepeatForever *spinForever = [CCActionRepeatForever actionWithAction:rotate90];
        for (CCNode* latticePoint in lattices) {
            if ([self checkIfValidGoat:goat moveFrom:goat.parent To:latticePoint]) {
                CCSprite *spinner = latticePoint.children[0];
                [spinner setOpacity:1.0];
                [spinner runAction:[spinForever copy]];
            }
        }
    }
    else {
        for (CCNode* latticePoint in lattices) {
            CCSprite *spinner = latticePoint.children[0];
            [spinner stopAllActions];
            [spinner setOpacity:0.0];
        }
    }
}


@end

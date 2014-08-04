//
//  Tiger.m
//  AaduPuliAttam
//
//  Created by Srinath Giri on 7/13/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Tiger.h"
#import "Board.h"

static BOOL enabled = false;

@implementation Tiger {
    CGPoint previousPosition;
}

- (void)onEnter {
    [super onEnter];
    previousPosition = self.position;
    self.userInteractionEnabled = TRUE;
}

+ (void)movement:(BOOL) enable {
    enabled = enable;
}

- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    if (enabled) {
    [[Board sharedBoard] glowTigers:false];
    [[Board sharedBoard] overlayTigerSprite:true on:self];
    [[Board sharedBoard] glowLattices:true forTiger:self];
    }
}

- (void)touchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    if (enabled) {
    CGPoint touchLocation = [touch locationInNode:self.parent];
    self.position = touchLocation;
    //CCLOG(@"ccp:%f %f",self.position.x,self.position.y);
    [[Board sharedBoard] overlayTigerSprite:true on:self];
    }
}

- (void)touchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    if (enabled) {
    if([[Board sharedBoard] moveTiger:self])
        previousPosition = self.position;
    else
        self.position = previousPosition;
    [[Board sharedBoard] glowLattices:false forTiger:self];
    [[Board sharedBoard] overlayTigerSprite:false on:self];
    }
}

- (void)touchCancelled:(UITouch *)touch withEvent:(UIEvent *)event
{
    if (enabled) {
    self.position = previousPosition;
    [[Board sharedBoard] glowLattices:false forTiger:self];
    [[Board sharedBoard] overlayTigerSprite:false on:self];
    }
}

@end
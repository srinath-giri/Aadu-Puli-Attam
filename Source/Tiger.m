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

}

- (void)touchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    if (enabled) {
    CGPoint touchLocation = [touch locationInNode:self.parent];
    self.position = touchLocation;
    //CCLOG(@"ccp:%f %f",self.position.x,self.position.y);
    }
}

- (void)touchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    if (enabled) {
    if([[Board sharedBoard] moveTiger:self])
        previousPosition = self.position;
    else
        self.position = previousPosition;
    }
}

- (void)touchCancelled:(UITouch *)touch withEvent:(UIEvent *)event
{
    if (enabled) {
    self.position = previousPosition;
    }
}

@end
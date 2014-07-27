//
//  Goat.m
//  AaduPuliAttam
//
//  Created by Srinath Giri on 7/14/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Goat.h"
#import "Board.h"

static BOOL enabled = false;

@implementation Goat {
    CGPoint previousPosition;
}

- (void)onEnter {
    [super onEnter];
    previousPosition = self.position;
    self.inBoard = false;
    self.isAlive = true;
    self.userInteractionEnabled = TRUE;
    float delay = (arc4random() % 12000) / 1000.f;
    [self performSelector:@selector(startHeadShake) withObject:nil afterDelay:delay];
}

- (void)startHeadShake {
    CCAnimationManager* animationManager = self.userObject;
    [animationManager runAnimationsForSequenceNamed:@"HeadShake"];
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
    //CCLOG(@"touchMoved:%f %f",self.position.x,self.position.y);
    }
}

- (void)touchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    if (enabled) {
        //CCLOG(@"touchEnded:%f %f",self.position.x,self.position.y);
        if([[Board sharedBoard] moveGoat:self])
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
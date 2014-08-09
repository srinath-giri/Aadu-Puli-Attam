//
//  Goat.m
//  AaduPuliAttam
//
//  Created by Srinath Giri on 7/14/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Goat.h"
#import "Board.h"

@implementation Goat {
    CGPoint previousPosition;
}

- (void)onEnter {
    [super onEnter];
    previousPosition = self.position;
    self.inBoard = false;
    self.isAlive = true;
    self.isMovable = false;
    self.userInteractionEnabled = TRUE;
    [self startHeadShakeWithRandomDelay];
    }

- (void)startHeadShake {
    CCAnimationManager* animationManager = self.userObject;
    [animationManager runAnimationsForSequenceNamed:@"HeadShake"];
}

- (void)startHeadShakeWithRandomDelay {
    float delay = (arc4random() % 9000) / 1000.f;
    [self performSelector:@selector(startHeadShake) withObject:nil afterDelay:delay];
}

- (void)pauseHeadShake {
    CCAnimationManager* animationManager = self.userObject;
    [animationManager setPaused:YES];
}

- (void)move:(BOOL)enable {
    self.isMovable = enable;
}

- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    if (self.isMovable) {
    [self setVisible:false];
    [[Board sharedBoard] glowGoats:false];
    [[Board sharedBoard] overlayGoatSprite:true on:self];
    [[Board sharedBoard] glowLattices:true forGoat:self];
    }
}

- (void)touchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    if (self.isMovable) {
    CGPoint touchLocation = [touch locationInNode:self.parent];
    self.position = touchLocation;
    //CCLOG(@"touchMoved:%f %f",self.position.x,self.position.y);
    [[Board sharedBoard] overlayGoatSprite:true on:self];    
    }
}

- (void)touchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    if (self.isMovable) {
        //CCLOG(@"touchEnded:%f %f",self.position.x,self.position.y);
        if([[Board sharedBoard] moveGoat:self])
            previousPosition = self.position;
        else
            self.position = previousPosition;
        [[Board sharedBoard] glowLattices:false forGoat:self];
        [[Board sharedBoard] overlayGoatSprite:false on:self];
        [self setVisible:true];
    }
    
}

- (void)touchCancelled:(UITouch *)touch withEvent:(UIEvent *)event
{
    if (self.isMovable) {
    self.position = previousPosition;
    [[Board sharedBoard] glowGoats:true];
    [[Board sharedBoard] glowLattices:false forGoat:self];    
    [[Board sharedBoard] overlayGoatSprite:false on:self];
    [self setVisible:true];
    }
}

@end
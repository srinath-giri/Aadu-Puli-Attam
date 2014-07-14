//
//  Tiger.m
//  AaduPuliAttam
//
//  Created by Srinath Giri on 7/13/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Tiger.h"
#import "Board.h"

@implementation Tiger

- (void)onEnter {
    [super onEnter];
    self.userInteractionEnabled = TRUE;
}

- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{

}

- (void)touchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchLocation = [touch locationInNode:self.parent];
    self.position = touchLocation;
    //CCLOG(@"ccp:%f %f",self.position.x,self.position.y);
}

- (void)touchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    [self placeTiger];
}

- (void)touchCancelled:(UITouch *)touch withEvent:(UIEvent *)event
{
    [self placeTiger];
}

- (void)placeTiger
{
    [[Board sharedBoard] placeTiger:self];
}

@end
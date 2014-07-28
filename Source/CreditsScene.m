//
//  CreditsScene.m
//  AaduPuliAttam
//
//  Created by Srinath Giri on 7/27/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CreditsScene.h"

@implementation CreditsScene

- (void)close {
    [[CCDirector sharedDirector] replaceScene:[CCBReader loadAsScene:@"MainScene"]];
}

@end

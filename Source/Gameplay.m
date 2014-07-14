//
//  Gameplay.m
//  AaduPuliAttam
//
//  Created by Srinath Giri on 7/13/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Gameplay.h"

@implementation Gameplay

- (void)didLoadFromCCB {
    self.userInteractionEnabled = TRUE;
}

- (void)replay {
    // reload gameplay
    [[CCDirector sharedDirector] replaceScene: [CCBReader loadAsScene:@"Gameplay"]];
}

@end
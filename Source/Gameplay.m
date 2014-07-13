//
//  Gameplay.m
//  AaduPuliAttam
//
//  Created by Srinath Giri on 7/13/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Gameplay.h"
#import "Tiger.h"

@implementation Gameplay {
    Tiger *_tiger1;
    Tiger *_tiger2;
    Tiger *_tiger3;
}

- (void)didLoadFromCCB {
    self.userInteractionEnabled = TRUE;
}

- (void)replay {
    // reload this level
    [[CCDirector sharedDirector] replaceScene: [CCBReader loadAsScene:@"Gameplay"]];
}

@end

//
//  Gameplay.m
//  AaduPuliAttam
//
//  Created by Srinath Giri on 7/13/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Gameplay.h"
#import "Board.h"

@implementation Gameplay {
    BOOL menuShown;
    CCButton *_menuButton;
    CCButton *_replayButton;
}

- (void) didLoadFromCCB {
    menuShown = false;
    [self start];
    self.userInteractionEnabled = TRUE;
}

- (void) start {
    [[Board sharedBoard] startGame];
}

- (void) menu {
    CCActionMoveBy *moveMenuAction = [CCActionMoveBy actionWithDuration:0.5 position:ccp(75, 0)];
    CCActionMoveBy *moveMenuReverseAction = [CCActionMoveBy actionWithDuration:0.5 position:ccp(-75,0)];
    if(menuShown) {
        [_menuButton runAction:[moveMenuReverseAction copy]];
        [_replayButton runAction:[moveMenuReverseAction copy]];
        menuShown = false;
    }
    else {
        [_menuButton runAction:[moveMenuAction copy]];
        [_replayButton runAction:[moveMenuAction copy]];
        menuShown = true;
    }
}

- (void) replay {
    // reload gameplay
    [[CCDirector sharedDirector] replaceScene: [CCBReader loadAsScene:@"Gameplay"]];
}

@end
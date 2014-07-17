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
}

- (void) didLoadFromCCB {
    [self start];
    self.userInteractionEnabled = TRUE;
    
}

- (void) start {
   // [[Board sharedBoard] placeTiger:_tiger1];
   // [[Board sharedBoard] placeTiger:_tiger2];
   // [[Board sharedBoard] placeTiger:_tiger3];
    [[Board sharedBoard] startGame];
}

- (void) replay {
    // reload gameplay
    [[CCDirector sharedDirector] replaceScene: [CCBReader loadAsScene:@"Gameplay"]];
}

@end
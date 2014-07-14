//
//  Board.h
//  AaduPuliAttam
//
//  Created by Srinath Giri on 7/13/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCSprite.h"
#import "Tiger.h"

@interface Board : CCNode

+ (Board*) sharedBoard;
- (void) placeTiger:(Tiger *) tiger;

@end

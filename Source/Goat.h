//
//  Goat.h
//  AaduPuliAttam
//
//  Created by Srinath Giri on 7/14/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCSprite.h"

@interface Goat : CCNode

@property (nonatomic, assign) BOOL inBoard;
@property (nonatomic, assign) BOOL isAlive;

+ (void)movement:(BOOL) enable;

@end

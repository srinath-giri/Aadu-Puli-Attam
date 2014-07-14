//
//  Tiger.h
//  AaduPuliAttam
//
//  Created by Srinath Giri on 7/13/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCSprite.h"

@interface Tiger : CCSprite

@property (nonatomic, assign) BOOL inBoard;

+ (void)movement:(BOOL) enable;

@end
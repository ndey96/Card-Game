//
//  Card.h
//  Card Game
//
//  Created by Nolan on 2015-04-01.
//  Copyright (c) 2015 Nolan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;
@property (nonatomic) BOOL isChosen;
@property (nonatomic) BOOL isMatched;

- (int)match:(NSArray*)otherCards;

@end

//
//  CardMatchingGame.h
//  Card Game
//
//  Created by Nolan Dey on 2015-04-03.
//  Copyright (c) 2015 Nolan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

//designated initializer
- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck*)deck;
- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card*)cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic) NSInteger matchMode;

@end
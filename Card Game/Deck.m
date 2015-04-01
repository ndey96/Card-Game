//
//  Deck.m
//  Card Game
//
//  Created by Nolan on 2015-04-01.
//  Copyright (c) 2015 Nolan. All rights reserved.
//

#import "Deck.h"

@interface Deck()

@property (strong, nonatomic) NSMutableArray* cards;

@end

@implementation Deck

- (NSMutableArray*)cards{
    if(!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (void)addCard:(Card*)card atTop:(BOOL)atTop{
    if (atTop){
        [self.cards insertObject:card atIndex:0];
    }
    else {
        [self.cards addObject:card];
    }
    
}



- (void)addCard:(Card*)card{
    [self addCard:card atTop:NO];
}

- (Card*)drawRandomCard{
    
    Card* randomCard = nil;
    
    if ([self.cards count]){
        int index = arc4random()%[self.cards count];
        randomCard = self.cards[index];
        [self.cards removeObjectAtIndex:index];
    }
    return randomCard;
}

@end
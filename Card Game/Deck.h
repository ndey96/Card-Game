//
//  Deck.h
//  Card Game
//
//  Created by Nolan on 2015-04-01.
//  Copyright (c) 2015 Nolan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void)addCard:(Card*)card atTop:(BOOL)atTop;
- (void)addCard:(Card*)card;

- (Card*)drawRandomCard;

@end

//
//  CardMatchingGame.m
//  Card Game
//
//  Created by Nolan Dey on 2015-04-03.
//  Copyright (c) 2015 Nolan. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()

@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic) NSMutableArray *cards;
@property (nonatomic, readwrite) NSInteger flipCount;
@property (nonatomic, readwrite) NSString *status;

@end

@implementation CardMatchingGame

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

- (NSMutableArray*)cards{
    if(!_cards){
    _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck*)deck{
    self = [super init];
    
    if (self){
        for (int i = 0; i < count; i++){
            Card *card = [deck drawRandomCard];
            if(card){
            [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
    }
    return self;
}
- (void)chooseCardAtIndex:(NSUInteger)index{
    
    self.flipCount++;
    
    Card* card = [self cardAtIndex:index];
    self.status = [NSString stringWithFormat:@"You chose %@", card.contents];
    
    if (!card.isMatched){
        if (card.isChosen){
            card.isChosen = NO;
        } else {
            //check if cards match
            
            //create array of cards currently chosen
            NSMutableArray *currentCardsChosen = [[NSMutableArray alloc] init];
            NSMutableString *stringOfCurrentCardsChosen = [[NSMutableString alloc] init];
            for (Card *otherCard in self.cards){
                if (otherCard.isChosen && !otherCard.isMatched){
                    [currentCardsChosen addObject:otherCard];
                    [stringOfCurrentCardsChosen appendFormat:@"%@ ", otherCard.contents];
                }
            }
            [stringOfCurrentCardsChosen appendFormat:@" %@ ", card.contents];
            
            //checks if cards match and adjusts score accordingly
            if ([currentCardsChosen count] == self.matchMode - 1){
                int matchScore = [card match:currentCardsChosen];
                if (matchScore){
                    self.score += matchScore * MATCH_BONUS;
                    for (Card *otherCard in currentCardsChosen){
                        otherCard.isMatched = YES;
                    }
                    card.isMatched = YES;
                    self.status = [NSString stringWithFormat:@"Matched %@ for %i points", stringOfCurrentCardsChosen, matchScore*MATCH_BONUS];
                    
                } else {
                    self.score -= MISMATCH_PENALTY;
                    for (Card *otherCard in currentCardsChosen){
                        otherCard.isChosen = NO;
                    }
                    self.status = [NSString stringWithFormat:@"%@ dont match! %i point penalty!", stringOfCurrentCardsChosen, MISMATCH_PENALTY];
                }
            }
            self.score -= COST_TO_CHOOSE;
            card.isChosen = YES;
        }
    }
}


- (Card*)cardAtIndex:(NSUInteger)index{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

- (NSInteger)matchMode{
    if(!_matchMode) _matchMode = 2;
    return _matchMode;
}

@end

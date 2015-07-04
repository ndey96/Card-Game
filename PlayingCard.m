//
//  PlayingCard.m
//  Card Game
//
//  Created by Nolan on 2015-04-01.
//  Copyright (c) 2015 Nolan. All rights reserved.
//
#import "PlayingCard.h"

@implementation PlayingCard

- (int) match:(NSArray *)otherCards{
    
    int score = 0;
    
    for(PlayingCard *otherCard in otherCards){
        if (self.rank == otherCard.rank) {
            score += 4;
        } else if (self.suit == otherCard.suit){
            score += 1;
        }
    }
    
    NSMutableArray *otherCardsInCollection = [[NSMutableArray alloc] init];
    for (PlayingCard *otherCard in otherCardsInCollection){
        [otherCardsInCollection removeObject:otherCard];
        for (PlayingCard *anotherCard in otherCardsInCollection){
            if (otherCard.rank == anotherCard.rank){
                score += 4;
            } else if ([otherCard.suit isEqualToString:anotherCard.suit]){
                score += 1;
            }
        }
    }
    
    return score;
}

- (NSString*)contents{

    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];

}

@synthesize suit = _suit;

+ (NSArray*)validSuits{
    return @[@"♠︎", @"♣︎", @"♥︎", @"♦︎"];
}

- (void) setSuit:(NSString *)suit{
    if([[PlayingCard validSuits] containsObject:suit]){
        _suit = suit;
    }
}

- (NSString*) suit{
    return _suit ? _suit : @"?";
}

+ (NSArray*) rankStrings{
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7",
             @"8", @"9", @"10", @"J", @"Q", @"K"];
}

+ (NSUInteger) maxRank {
    return [[PlayingCard rankStrings] count]-1;
}

- (void) setRank:(NSUInteger)rank{
    if (rank <= [PlayingCard maxRank]){
        _rank = rank;
    }
}
@end

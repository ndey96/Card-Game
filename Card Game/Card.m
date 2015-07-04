//
//  Card.m
//  Card Game
//
//  Created by Nolan on 2015-04-01.
//  Copyright (c) 2015 Nolan. All rights reserved.
//

#import "Card.h"

@implementation Card

@synthesize contents = _contents;

- (NSString*) contents{
    return _contents;
}

- (void) setContents:(NSString*)contents{
    _contents = contents;
}

- (int)match:(NSArray*)otherCards{
    int score = 0;
    for (Card* card in otherCards){
        if([card.contents isEqualToString:self.contents]){
            score = 1;
            NSLog(@"%@", self.contents);
        }
    }
    return score;
}



@end

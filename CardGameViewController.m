//
//  CardGameViewController.m
//  Card Game
//
//  Created by Nolan on 2015-03-30.
//  Copyright (c) 2015 Nolan. All rights reserved.
//

#import "CardGameViewController.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) PlayingCardDeck *playingCardDeck;

@end

@implementation CardGameViewController

- (IBAction)touchCardButton:(UIButton *)sender {
    
    if ([sender.currentTitle length]){
        UIImage *image = [UIImage imageNamed:@"cardBack"];
        [sender setTitle:@"" forState:UIControlStateNormal];
        [sender setBackgroundImage:image forState:UIControlStateNormal];
    }
    else {
        UIImage *image = [UIImage imageNamed:@"cardFront"];
        Card* card = [self.playingCardDeck drawRandomCard];
        NSString *cardContents = card.contents;
        [sender setTitle:cardContents forState:UIControlStateNormal];
        [sender setBackgroundImage:image forState:UIControlStateNormal];
    }
    self.flipCount++;
}

- (void) setFlipCount:(int)flipCount{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}

- (PlayingCardDeck*)playingCardDeck {
    if (!_playingCardDeck){
        _playingCardDeck = [[PlayingCardDeck alloc] init];
    }
    return _playingCardDeck;
}
                                  
                                  
@end

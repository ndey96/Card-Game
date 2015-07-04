//
//  CardGameViewController.m
//  Card Game
//
//  Created by Nolan on 2015-03-30.
//  Copyright (c) 2015 Nolan. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController()

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) Deck *deck;
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *matchModeSegmentedControl;


@end

@implementation CardGameViewController

- (IBAction)matchModeChanged:(id)sender {
    self.game.matchMode = self.matchModeSegmentedControl.selectedSegmentIndex + 2;
}

- (IBAction)touchResetButton:(id)sender {
    self.game = nil;
    self.deck = nil;
    [self updateUI];
}

- (IBAction)touchCardButton:(UIButton *)sender {
    NSUInteger cardIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:cardIndex];
    [self updateUI];
}

- (void) updateUI{
    
    //disable segmented control segment that is not selected when first card is flipped
    if (self.game.flipCount == 1){
        if (self.game.matchMode == 2){
            [self.matchModeSegmentedControl setEnabled:NO forSegmentAtIndex:1];
        } else if (self.game.matchMode == 3){
            [self.matchModeSegmentedControl setEnabled:NO forSegmentAtIndex:0];
        }

    //enable segmented control when game is reset or before game starts
    } else if (self.game.flipCount == 0){
        for (int i = 0; i < self.matchModeSegmentedControl.numberOfSegments; i++){
            [self.matchModeSegmentedControl setEnabled:YES forSegmentAtIndex:i];
        }
        [self.matchModeSegmentedControl setSelectedSegmentIndex:0];
    }
    
    for (UIButton *cardButton in self.cardButtons){
        NSUInteger cardIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
}

- (NSString*)titleForCard:(Card*)card{
    return card.isChosen ? card.contents : @"";
}

- (UIImage*)backgroundImageForCard:(Card*)card{
    return [UIImage imageNamed:card.isChosen ? @"cardFront" : @"cardBack"];
}

- (CardMatchingGame*)game{
    if (!_game){
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
    }
    return _game;
}

- (Deck*)createDeck{
    return [[PlayingCardDeck alloc] init];
}

@end

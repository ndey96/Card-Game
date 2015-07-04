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

//- (IBAction)matchModeSegmentedControlAction:(id)sender {
//    if (self.matchModeSegmentedControl.selectedSegmentIndex == 0){
//        //2 card match
//        NSLog(@"2 card match mode");
//        self.game.matchMode = 2;
//    } else if (self.matchModeSegmentedControl.selectedSegmentIndex == 1){
//        //3 card match
//        NSLog(@"3 card match mode");
//        self.game.matchMode = 3;
//    } else {
//        
//    }
//    
//}


- (IBAction)touchResetButton:(id)sender {
    self.game = nil;
    self.deck = nil;
    [self updateUI];
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

- (IBAction)touchCardButton:(UIButton *)sender {
    NSUInteger cardIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:cardIndex];
    [self updateUI];
}

- (void) updateUI{
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

@end

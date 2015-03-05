//
//  CardMatchingGame.m
//  Machismo
//
//  Created by Armour on 2/28/15.
//  Copyright (c) 2015 ZJU. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards; //of Card
@end

@implementation CardMatchingGame
    
- (NSMutableArray *)card {
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck {
    self = [super init];
    if (self) {
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            } else {
                self  = nil;
                break;
            }
        }
    }
    return self;
}

static const int MISMATCH_PANNALTY = 2;
static const int MATCH_BONUS = 4;
static const int FLIP_COST = 1;

- (void)chooseCardAtIndex:(NSUInteger)index {
    Card *card = [self cardAtIndex:index];
    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
        } else {
            //match against another card
            for (Card *othercard in self.cards) {
                if (othercard.isChosen && !othercard.isMatched) {
                    int matchScore = [card match:@[othercard]];
                    if (matchScore) {
                        self.score += matchScore * MATCH_BONUS;
                        card.matched = YES;
                        othercard.matched = YES;
                    } else {
                        self.score -= MISMATCH_PANNALTY;
                        othercard.chosen = NO;
                    }
                }
                break;
            }
            self.score -= FLIP_COST;
            card.chosen = YES;
        }
    }
}

- (Card *)cardAtIndex:(NSUInteger)index {
    return (index < [self.cards count])? self.cards[index]: nil;
}

- (instancetype)init {
    return nil;
}

@end
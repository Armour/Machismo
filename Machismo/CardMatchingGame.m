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
@property (nonatomic, strong) NSMutableArray *choosedCard;

@end


@implementation CardMatchingGame

static const int MISMATCH_PANNALTY = 2;
static const int MATCH_BONUS = 4;
static const int FLIP_COST = 1;

- (NSMutableArray *)cards {
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (NSMutableArray *)choosedCard {
    if (!_choosedCard) _choosedCard = [[NSMutableArray alloc] init];
    return _choosedCard;
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

- (BOOL) alreadyChosen:(NSUInteger)index {
    Card *card = [self cardAtIndex:index];
    return card.chosen;
}

- (void) letMeSee:(NSUInteger)index {
    Card *card = [self cardAtIndex:index];
    card.chosen = YES;
}

- (void) afterSeeIt:(NSUInteger)index {
    Card *card = [self cardAtIndex:index];
    card.chosen = NO;
}

- (void)chooseCardAtIndex:(NSUInteger)index {
    Card *card = [self cardAtIndex:index];
    NSArray *othercard;
    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
        } else {
            switch ([self.choosedCard count]) {
                case 0:
                    self.score -= FLIP_COST;
                    self.openedNumber++;
                    [self.choosedCard addObject:card];
                    card.chosen = YES;
                    break;
                case 1:
                    if (self.mode == 2) {
                        othercard = self.choosedCard;
                        int matchScore = [card match:othercard];
                        if (matchScore) {
                            self.score += matchScore * MATCH_BONUS;
                            for (Card *eachcard in self.choosedCard)
                                eachcard.matched = YES;
                            card.matched = YES;
                            card.chosen = YES;
                        } else {
                            self.score -= MISMATCH_PANNALTY;
                            for (Card *eachcard in self.choosedCard)
                                eachcard.chosen = NO;
                            card.chosen = NO;
                        }
                        self.openedNumber = 0;
                        [self.choosedCard removeAllObjects];
                    } else {
                        self.score -= FLIP_COST;
                        self.openedNumber++;
                        [self.choosedCard addObject:card];
                        card.chosen = YES;
                    }
                    break;
                case 2:
                    othercard = self.choosedCard;
                    int matchScore = [card match:othercard];
                    if (matchScore) {
                        self.score += matchScore * MATCH_BONUS;
                        for (Card *eachcard in self.choosedCard)
                            eachcard.matched = YES;
                        card.matched = YES;
                        card.chosen = YES;
                    } else {
                        self.score -= MISMATCH_PANNALTY;
                        for (Card *eachcard in self.choosedCard)
                            eachcard.chosen = NO;
                        card.chosen = NO;
                    }
                    self.openedNumber = 0;
                    [self.choosedCard removeAllObjects];
                    break;
                default:
                    break;
            }
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
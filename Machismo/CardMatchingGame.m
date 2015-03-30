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

- (void)chooseCardAtIndex:(NSUInteger)index {
    Card *card = [self cardAtIndex:index];
    NSArray *othercard;
    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
            for (Card *othercard in self.choosedCard) {
                if ([othercard.contents isEqual:card.contents]) {
                    [self.choosedCard removeObjectAtIndex:[self.choosedCard indexOfObject:othercard]];
                }
            }
            self.information = [[NSString alloc] initWithFormat:@"flip back~"];
        } else {
            switch ([self.choosedCard count]) {
                case 0:
                    self.score -= FLIP_COST;
                    self.openedNumber++;
                    [self.choosedCard addObject:card];
                    card.chosen = YES;
                    self.information = [[NSString alloc] initWithFormat:@""];
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
                            self.openedNumber = 0;
                            [self.choosedCard removeAllObjects];
                        } else {
                            self.score -= MISMATCH_PANNALTY;
                            for (Card *eachcard in self.choosedCard)
                                eachcard.chosen = NO;
                            self.openedNumber = 1;
                            [self.choosedCard removeAllObjects];
                            [self.choosedCard addObject:card];
                            card.chosen = YES;
                        }
                        self.information = [[NSString alloc] initWithString:[card.history lastObject]];
                    } else {
                        self.score -= FLIP_COST;
                        self.openedNumber++;
                        [self.choosedCard addObject:card];
                        card.chosen = YES;
                        self.information = [[NSString alloc] initWithFormat:@""];
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
                        self.openedNumber = 0;
                        [self.choosedCard removeAllObjects];
                    } else {
                        self.score -= MISMATCH_PANNALTY;
                        for (Card *eachcard in self.choosedCard)
                            eachcard.chosen = NO;
                        self.openedNumber = 1;
                        [self.choosedCard removeAllObjects];
                        [self.choosedCard addObject:card];
                        card.chosen = YES;
                    }
                    self.information = [[NSString alloc] initWithString:[card.history lastObject]];
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
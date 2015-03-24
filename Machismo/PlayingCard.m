//
//  PlayingCard.m
//  Machismo
//
//  Created by Armour on 15/2/14.
//  Copyright (c) 2015年 ZJU. All rights reserved.
//

#import "PlayingCard.h"

@interface PlayingCard()

@end


@implementation PlayingCard

@synthesize suit = _suit;

- (int)togetherA:(NSUInteger)a withB:(NSUInteger)b andC:(NSUInteger)c {
    if ((a - b == 1) && (b - c == 1)) return 1;
    if ((a - c == 1) && (c - b == 1)) return 1;
    if ((b - a == 1) && (a - c == 1)) return 1;
    if ((b - c == 1) && (c - a == 1)) return 1;
    if ((c - a == 1) && (a - b == 1)) return 1;
    if ((c - b == 1) && (b - a == 1)) return 1;
    return 0;
}

- (int)match:(NSArray *)otherCards {
    int score = 0;

    if ([otherCards count] == 1) {
        PlayingCard *otherCard = [otherCards firstObject];
        if ([self.suit isEqualToString:otherCard.suit])
            score = 1;
        else if (self.rank == otherCard.rank)
            score = 4;
    } else {
        PlayingCard *otherCard1 = [otherCards firstObject];
        PlayingCard *otherCard2 = [otherCards lastObject];
        if ([self.suit isEqualToString:otherCard1.suit] && [self.suit isEqualToString:otherCard2.suit])
            score = 3;
        else if (self.rank == otherCard1.rank && self.rank == otherCard2.rank)
            score = 12;
        else if ([self togetherA:self.rank withB:otherCard1.rank andC:otherCard2.rank])
            score = 8;
        else if (self.rank == otherCard1.rank || self.rank == otherCard2.rank || otherCard1.rank == otherCard2.rank)
            score = 4;
    }

    return score;
}

+ (NSArray *)rankStrings {
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

- (NSString *)contents {
    NSArray *rankString = [PlayingCard rankStrings];
    return [rankString[self.rank] stringByAppendingString:self.suit];
}

+ (NSArray *)validSuits {
    return @[@"♠️",@"♥️",@"♣️",@"♦️"];
}

- (void)setSuit:(NSString *)suit {
    if ([[PlayingCard validSuits] containsObject:suit])
        _suit = suit;
}

- (NSString *)suit {
    return _suit? _suit: @"?";
}

+ (NSUInteger)maxRank {
    return [[self/*PlayingCard*/ rankStrings] count]-1;
}

- (void)setRank:(NSUInteger)rank {
    if (rank <= [PlayingCard maxRank])
        _rank = rank;
}

@end

//
//  CardMatchingGame.h
//  Machismo
//
//  Created by Armour on 2/28/15.
//  Copyright (c) 2015 ZJU. All rights reserved.
//

#ifndef Machismo_CardMatchingGame_h
#define Machismo_CardMatchingGame_h

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

@property  (nonatomic, readonly) NSInteger score;
@property (nonatomic, assign) NSInteger mode;
@property (nonatomic, assign) NSInteger openedNumber;
@property (nonatomic, strong) NSString *information;

- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck: (Deck *)deck;
- (void)chooseCardAtIndex:(NSUInteger) index;
- (Card *)cardAtIndex:(NSUInteger) index;

@end

#endif


//
//  Deck.h
//  Machismo
//
//  Created by Armour on 15/2/14.
//  Copyright (c) 2015年 ZJU. All rights reserved.
//

#ifndef Machismo_Deck_h
#define Machismo_Deck_h

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

-(void)addCard:(Card* )card atTop:(BOOL)atTop;
-(void)addCard:(Card* )card;

-(Card *)drawRandomCard;

@end

#endif

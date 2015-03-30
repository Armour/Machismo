//
//  Card.h
//  Machismo
//
//  Created by Armour on 15/2/14.
//  Copyright (c) 2015年 ZJU. All rights reserved.
//

#ifndef Machismo_Card_h
#define Machismo_Card_h

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;
@property (nonatomic, getter=isChosen) BOOL chosen;
@property (nonatomic, getter=isMatched) BOOL matched;
@property (nonatomic, strong) NSMutableArray *history;

-(int) match:(NSArray *)otherCards;

@end

#endif

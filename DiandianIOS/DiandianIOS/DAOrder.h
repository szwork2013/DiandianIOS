//
//  DAOrder.h
//  DiandianIOS
//
//  Created by Antony on 13-11-22.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DAEntity.h"
#import "SmartSDK.h"

@class DAItem;
@class DADesk;

@interface DAOrder : DAEntity<NSCoding>

@property (retain, nonatomic) NSString  *deskId;
@property (retain, nonatomic) NSString  *serviceId;
@property (retain, nonatomic) NSString  *userId;
@property (retain, nonatomic) NSString  *itemId;
@property (retain, nonatomic) NSNumber  *orderSeq;
@property (retain, nonatomic) NSNumber  *orderNum;
@property (retain, nonatomic) DADesk  *desk;
@property (retain, nonatomic) DAService *service;
@property (retain, nonatomic) DAItem   *item;
@property (retain, nonatomic) NSNumber  *itemType;

@property (retain, nonatomic) NSNumber *type;
@property (retain, nonatomic) NSNumber *back;
@property (retain, nonatomic) NSString *valid;
@property (retain, nonatomic) NSString *remark;

@property (retain, nonatomic) NSNumber *amount;
@property (retain, nonatomic) NSString *isNew;

@property (retain, nonatomic) NSMutableArray *oneItems;


@end
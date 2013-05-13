//
//  ContentDB.h
//  HanKouBank
//
//  Created by David on 13-5-13.
//  Copyright (c) 2013年 David. All rights reserved.
//

#import "DataBase.h"
#import "ContentLevel.h"
@interface ContentDB : DataBase

+(ContentDB*)sharedDB;
//
-(BOOL)insertWithContentInfo:(ContentLevel *)aContentLevel;
@end

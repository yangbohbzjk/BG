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
//插入内容到数据库保存
-(BOOL)insertWithContentInfo:(ContentLevel *)aContentLevel;
//数据库查询
- (NSString *)SelectContentsFromDB:(ContentLevel *)aUser;
@end

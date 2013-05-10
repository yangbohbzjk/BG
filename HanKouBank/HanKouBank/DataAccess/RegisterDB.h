//
//  RegisterDB.h
//  HanKouBank
//
//  Created by David on 13-5-9.
//  Copyright (c) 2013年 David. All rights reserved.
//

#import "DataBase.h"
#import "User.h"
@interface RegisterDB : DataBase

+(RegisterDB*)sharedDB;
//插入数据
- (BOOL)insertWithUserInfo:(User*)aUser;

//查询用户名是否重复
- (BOOL)selectUserFromDB:(User *)aUser;
@end

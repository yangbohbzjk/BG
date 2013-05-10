//
//  LoginDB.h
//  HanKouBank
//
//  Created by David on 13-5-9.
//  Copyright (c) 2013年 David. All rights reserved.
//

#import "DataBase.h"
#import "User.h"

@interface LoginDB : DataBase

+(LoginDB*)sharedDB;
//登陆查询用户名、密码是否正确
- (BOOL)selectUserAndPassFromDB:(User *)aUser;
@end

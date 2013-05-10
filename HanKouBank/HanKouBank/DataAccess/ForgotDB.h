//
//  ForgotDB.h
//  HanKouBank
//
//  Created by David on 13-5-10.
//  Copyright (c) 2013年 David. All rights reserved.
//

#import "DataBase.h"
#import "User.h"
@interface ForgotDB : DataBase
{
    NSString *passwordFromUser;
}

+(ForgotDB*)sharedDB;
//登陆查询用户名、密码是否正确
- (NSString *)FindPassFromDB:(User *)aUser;

@end

//
//  RegisterDB.h
//  HanKouBank
//
//  Created by David on 13-5-9.
//  Copyright (c) 2013年 David. All rights reserved.
//

#import "DataBase.h"

@interface RegisterDB : DataBase
//插入数据
- (void)insertWithUserInfo:(NSString *)username AndPass:(NSString *)userpass AndEmail:(NSString *)email AndRealname:(NSString *)realname AndUid:(NSNumber *)uid;

//查询用户名是否重复
- (BOOL)selectUserFromDB:(NSString *)username;
@end

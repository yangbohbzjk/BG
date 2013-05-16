//
//  LoginDB.m
//  HanKouBank
//
//  Created by David on 13-5-9.
//  Copyright (c) 2013年 David. All rights reserved.
//

#import "LoginDB.h"

@implementation LoginDB

static LoginDB *sharedDB = nil;
+(LoginDB*)sharedDB
{
    @synchronized(self)
    {
        if(sharedDB==nil){
            sharedDB = [[LoginDB alloc] init];
        }
    }
    
    return sharedDB;
}

//登陆查询：账号密码查询是否匹配，进行登陆查询
- (BOOL)selectUserAndPassFromDB:(User *)aUser
{
    [self readyDatabse];
    if ([self openDatabase ]) {
            //查询语句
    NSString *sql = [NSString stringWithFormat:@"select * from main.Users where username=\"%@\" and password=%d",aUser.username,[aUser.password intValue]];
    const char *selectSql=[sql UTF8String];
    //执行查询
    if (sqlite3_prepare_v2(database, selectSql, -1, &statement, nil)==SQLITE_OK) {
        if (sqlite3_step(statement) == SQLITE_ROW)
        {
             NSString *usernameFromUser = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0    )];
            aUser.username= usernameFromUser;
            NSString *passwordFromUser = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1    )];
            aUser.password = passwordFromUser;
            DLog(@"账号密码匹配成功");
            return YES;
        }
        else {
            DLog(@"登陆失败");
        }
        sqlite3_finalize(statement);
    }
    }else
        NSLog(@"打开数据库失败");

    return NO;
}
@end

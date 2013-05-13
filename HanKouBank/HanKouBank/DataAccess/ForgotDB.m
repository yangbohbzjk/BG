//
//  ForgotDB.m
//  HanKouBank
//
//  Created by David on 13-5-10.
//  Copyright (c) 2013年 David. All rights reserved.
//

#import "ForgotDB.h"

@implementation ForgotDB

static ForgotDB *sharedDB = nil;

+(ForgotDB*)sharedDB
{
    @synchronized(self)
    {
        if(sharedDB==nil){
            sharedDB = [[ForgotDB alloc] init];
        }
    }
    
    return sharedDB;
}

- (NSString *)FindPassFromDB:(User *)aUser
{
    //查询语句
    NSString *sql = [NSString stringWithFormat:@"select * from main.Users where username=\"%@\" and email=\"%@\"",aUser.username,aUser.email];
    
    const char *selectSql=[sql UTF8String];
    //执行查询
    if (sqlite3_prepare_v2(database, selectSql, -1, &statement, nil)==SQLITE_OK) {
        if (sqlite3_step(statement) == SQLITE_ROW)
        {
            passwordFromUser = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement,1  )];
            //aUser.password = passwordFromUser;
            DLog(@"账号密码匹配成功,%@",passwordFromUser);
            return passwordFromUser;
        }
        else {
            DLog(@"登陆失败");
        }
        sqlite3_finalize(statement);
    }
    return passwordFromUser;

}


@end

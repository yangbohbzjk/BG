//
//  RegisterDB.m
//  HanKouBank
//
//  Created by David on 13-5-9.
//  Copyright (c) 2013年 David. All rights reserved.
//

#import "RegisterDB.h"

@implementation RegisterDB

#pragma mark ------初始化数据库------
static RegisterDB *sharedDB = nil;
+(RegisterDB*)sharedDB
{
    @synchronized(self)
    {
        if(sharedDB==nil){
            sharedDB = [[RegisterDB alloc] init];
        }
    }
    
    return sharedDB;
}

//注册用户账号，把用户信息写入User表中     相同用户名提示更改，不同名写入
-(BOOL)insertWithUserInfo:(User *)aUser
{
    [self readyDatabse];
    if ([self openDatabase]) {
        NSString *sql = [NSString stringWithFormat:@"insert into \"main\".\"Users\" ( \"password\", \"username\", \"uid\" , \"email\", \"realname\") values ( \"%@\", \"%@\", %d, \"%@\", \"%@\")",aUser.password,aUser.username,aUser.uid,aUser.email,aUser.realname];
        //将定义的NSString的sql语句，转换成UTF8的c风格的字符串
        const char *insertSql = [sql UTF8String];
        //执行插入语句
        if (sqlite3_exec(database, insertSql, NULL, NULL,&errorMsg)==SQLITE_OK) {
             return YES;
        }else{
            NSLog(@"error: %s",errorMsg);
            sqlite3_free(errorMsg);
        }

    }else
        NSLog(@"数据库打开失败，注册失败");
    [self closeDatabase];
    return NO;
}


//登陆账号，在数据库中查询用户注册信息是否存在，存在进入主页，不存在重新输入
//只查询username，主键是否一致 username是需要查询的值 textfield。text
- (BOOL)selectUserFromDB:(User *)aUser
{
    [self readyDatabse];
    if ([self openDatabase]) {
          NSString *sql = [NSString stringWithFormat:@"select * from \"main\".\"Users\" where username = \"%@\"",aUser.username];
    const char *selectSql=[sql UTF8String];
    //执行查询
    if (sqlite3_prepare_v2(database, selectSql, -1, &statement, nil)==SQLITE_OK) {
        if (sqlite3_step(statement) == SQLITE_ROW)
        {
            NSString *usernameFromUser = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0    )];
            aUser.username= usernameFromUser;
            DLog(@"用户名重名!");
            return YES;
        }
        else {
            DLog(@"用户名可用!");
        }
        sqlite3_finalize(statement);
      }
  }else
        NSLog(@"打开数据库失败");
    [self closeDatabase];
    return NO;

}

@end

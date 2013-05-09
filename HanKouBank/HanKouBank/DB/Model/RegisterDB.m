//
//  RegisterDB.m
//  HanKouBank
//
//  Created by David on 13-5-9.
//  Copyright (c) 2013年 David. All rights reserved.
//

#import "RegisterDB.h"

@implementation RegisterDB

//注册用户账号，把用户信息写入User表中     相同用户名可以提交但不能写入数据库中，需要提示用户修改
- (void)insertWithUserInfo:(NSString *)username AndPass:(NSString *)userpass AndEmail:(NSString *)email AndRealname:(NSString *)realname AndUid:(NSNumber *)uid
{
    NSString *sql = [NSString stringWithFormat:@"insert into \"main\".\"Users\" ( \"password\", \"username\", \"uid\" , \"email\", \"realname\") values ( ?, ?, ?, ?, ?)"];
    [self.database executeUpdate:sql,userpass,username,uid,email,realname];
    NSLog(@"开始校验用户名是否重复...");
}

//登陆账号，在数据库中查询用户注册信息是否存在，存在进入主页，不存在重新输入
//只查询username，主键是否一致 username是需要查询的值 textfield。text
- (BOOL)selectUserFromDB:(NSString *)username
{
    //查询语句
    NSString *selectSql = [NSString stringWithFormat:@"select * from \"main\".\"Users\" where username = \"%@\"",username];
    FMResultSet *set = [self.database executeQuery:selectSql];
    NSMutableArray *array = [[NSMutableArray alloc]init];
    while ([set next]) {
        NSString *name = [set stringForColumn:@"username"];
        NSLog(@"name:%@",name);
        [array addObject:name];
    }
    if ([array count]>0) {
        //如果数据库有相同用户名，返回真
        NSLog(@"arrayyes:%@",array);
        return YES;
    }else
        return NO;
}

@end

//
//  LoginDB.m
//  HanKouBank
//
//  Created by David on 13-5-9.
//  Copyright (c) 2013年 David. All rights reserved.
//

#import "LoginDB.h"

@implementation LoginDB

//登陆查询：账号密码查询是否匹配，进行登陆查询
- (BOOL)selectUserAndPassFromDB:(NSString *)username AndPassText:(NSString *)password
{
    //查询语句
    NSString *selectSql = [NSString stringWithFormat:@"select * from main.Users where username=\"%@\" and password=%d",username,[password intValue]];
    FMResultSet *set = [self.database executeQuery:selectSql];
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray *array2 =[NSMutableArray arrayWithCapacity:0];
    while ([set next]) {
        NSString *name = [set stringForColumn:@"username"];
        NSLog(@"name:%@",name);
        [array addObject:name];
        
        NSString *pass = [set stringForColumn:@"password"];
        NSLog(@"password:%@",pass);
        [array2 addObject:pass];
    }
    
    if ([array count]>0 && [array2 count]>0) {
        //如果数据库有相同用户名，返回真
        NSLog(@"arrayyes:%@",array);
        return YES;
    }else
        return NO;
}
@end

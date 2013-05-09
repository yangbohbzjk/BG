//
//  config.h
//  HanKouBank
//
//  Created by David on 13-4-23.
//  Copyright (c) 2013年 David. All rights reserved.
//

#pragma mark ------DLog------
// DLog is almost a drop-in replacement for NSLog
// DLog();
// DLog(@"here");
// DLog(@"value: %d", x);
// Unfortunately this doesn't work DLog(aStringVariable); you have to do this instead DLog(@"%@", aStringVariable);
#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif
// ALog always displays output regardless of the DEBUG setting
#define ALog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);


#pragma mark ------关键字宏定义------
//placeholder 字体大小
#define FONT_SYS 22


//登陆获取主页面内容链接
#define LOGIN_URL @"http://202.84.17.194/cm/vipapi/tree?id=141"
//list data url
#define LIST_URL @"http://202.84.17.194/cm/vipapi/tree/"
//单页返回的数据条数
#define LIST_NUM_IMP @"10"

//ContentPageView中获取文章内容的url
#define Content_URL @"http://202.84.17.194/cm/vipapi/tree/"

//测试账号密码
#define UserName @"hankou"
#define PassWord @"hankou"

//DataBase
#define DBName @"xhkb.db"
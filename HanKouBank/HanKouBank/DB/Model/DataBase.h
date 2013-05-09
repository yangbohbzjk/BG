//
//  DBLevel.h
//  HanKouBank
//
//  Created by David on 13-4-27.
//  Copyright (c) 2013年 David. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"

@interface DataBase : NSObject<UIAlertViewDelegate>
{
    FMDatabase *_database;
   
}

@property (nonatomic, strong) FMDatabase *database;
//初始化数据库
+(DataBase*)sharedDB;
//复制数据库到沙盒路径
-(NSString *)CopyDatabase:(NSString *)dbName;
//打开数据库
-(BOOL)OpenDatabase;
//关闭数据库
- (void)CloseDB;



@end

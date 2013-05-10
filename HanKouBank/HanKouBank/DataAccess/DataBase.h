//
//  DBLevel.h
//  HanKouBank
//
//  Created by David on 13-4-27.
//  Copyright (c) 2013年 David. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface DataBase : NSObject<UIAlertViewDelegate>
{
    sqlite3 *database;
    NSString *path;
    sqlite3_stmt *statement;
    char *errorMsg;
}

- (void)readyDatabse;
- (void)getPath;

+(DataBase*)sharedDB;

-(BOOL)openDatabase;
-(void)beginTransaction;
-(void)commitTransaction;
-(int)prepareSql:(NSString *)sql sqlStatement:(sqlite3_stmt **)statement;
-(void)closeDatabase;


@end

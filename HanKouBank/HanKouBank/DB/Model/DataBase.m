//
//  DBLevel.m
//  HanKouBank
//
//  Created by David on 13-4-27.
//  Copyright (c) 2013年 David. All rights reserved.
//

#import "DataBase.h"

@implementation DataBase
@synthesize database = _database;

static DataBase *sharedDB = nil;

-(id)init {
    self = [super init];
    if(self){
    }
    return self;
}

#pragma mark ------初始化数据库------
+(DataBase*)sharedDB
{
    @synchronized(self)
    {
        if(sharedDB==nil){
            sharedDB = [[DataBase alloc] init];
        }
    }
    
    return sharedDB;
}
#pragma mark ------检查并复制数据库------
-(NSString *)CopyDatabase:(NSString *)dbName 
{
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *Paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [Paths objectAtIndex:0];
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:dbName];
    success = [fileManager fileExistsAtPath:writableDBPath];
    if (!success) {
        NSString *defaultDBPath = [[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:dbName];
        success = [fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
        if (!success) {
            NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
        }
    }
    
    return writableDBPath;
}

#pragma mark ------打开数据库------
-(BOOL)OpenDatabase
{
    [self.database open];
    if ([self.database open]) {
        NSLog(@"打开成功");
        return YES;
    }else{
        NSLog(@"打开失败");
        return NO;
    }
}


#pragma mark ------关闭数据库------
- (void)CloseDB
{
    [self.database close];
    NSLog(@"database is closed!");
}



@end

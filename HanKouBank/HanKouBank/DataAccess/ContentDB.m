//
//  ContentDB.m
//  HanKouBank
//
//  Created by David on 13-5-13.
//  Copyright (c) 2013年 David. All rights reserved.
//

#import "ContentDB.h"

@implementation ContentDB

static ContentDB *sharedDB = nil;
+(ContentDB*)sharedDB
{
    @synchronized(self)
    {
        if(sharedDB==nil){
            sharedDB = [[ContentDB alloc] init];
        }
    }
    
    return sharedDB;
}

#pragma mark ------插入内容入库------
-(BOOL)insertWithContentInfo:(ContentLevel *)aContentLevel
{
    [self readyDatabse];
    if ([self openDatabase]) {
            NSString *sql = [NSString stringWithFormat:@"insert into \"main\".\"NewsContents\" ( \"discussNum\", \"largeImageURL\", \"type\", \"imagelist\", \"docId\", \"channelId\", \"docSource\", \"topic\", \"videoURL\", \"content\", \"createDate\", \"middleImageURL\", \"authors\") values ( '%d', '%@', '%d', '%@', '%d', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@')",[aContentLevel.discussNum intValue],aContentLevel.bigImageURL,[aContentLevel.type intValue],NULL,[aContentLevel.docId intValue],aContentLevel.channelId,aContentLevel.docSource,aContentLevel.topic,aContentLevel.videoURL,aContentLevel.content,aContentLevel.createDate,aContentLevel.middleImageURL,aContentLevel.authors];
    //将定义的NSString的sql语句，转换成UTF8的c风格的字符串
    const char *insertSql = [sql UTF8String];
    //执行插入语句
    if (sqlite3_exec(database, insertSql, NULL, NULL,&errorMsg)==SQLITE_OK) {
        NSLog(@"插入内容信息成功");
        return YES;
    }else{
        NSLog(@"error: %s",errorMsg);
        sqlite3_free(errorMsg);
    }
    }else 
        NSLog(@"打开数据库失败");
    [self closeDatabase];
    return NO;
}


- (ContentLevel *)SelectContentsFromDB:(ContentLevel *)aUser
{
    [self readyDatabse];
    if ([self openDatabase]) {
            //查询语句
    NSString *sql = [NSString stringWithFormat:@"select * from main.NewContents where docId=%d",[aUser.docId intValue]];
    
    const char *selectSql=[sql UTF8String];
    //执行查询
    if (sqlite3_prepare_v2(database, selectSql, -1, &statement, nil)==SQLITE_OK) {
        if (sqlite3_step(statement) == SQLITE_ROW)
        {
            aUser.docId = [NSNumber numberWithInt:[[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement,0  )] intValue]];
            aUser.channelId = [NSNumber numberWithInt:[[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement,1  )] intValue]];;
            aUser.topic = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement,2  )];
            aUser.content = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement,3  )];
            aUser.type = [NSNumber numberWithInt:[[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement,4  )] intValue]];
            aUser.authors = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement,4  )];
           //NSString --> NSDate
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
            NSDate *date = [dateFormatter dateFromString:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement,5  )]];
            aUser.createDate = date;
            
            aUser.discussNum = [NSNumber numberWithInt:[[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement,6  )] intValue]];
            aUser.middleImageURL = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement,7  )];
            aUser.bigImageURL = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement,8  )];
            aUser.docSource = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement,9  )];
            aUser.videoURL = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement,10  )];
            
            return aUser;
        }
        else {
            DLog(@"本地查询内容失败");
        }
        sqlite3_finalize(statement);
    }
    }else
        NSLog(@"数据库打开失败");
    [self closeDatabase];
    return aUser;
}
@end

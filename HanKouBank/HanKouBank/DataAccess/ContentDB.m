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


-(BOOL)insertWithContentInfo:(ContentLevel *)aContentLevel
{
    NSString *sql = [NSString stringWithFormat:@"insert into \"main\".\"NewsContents\" ( \"discussNum\", \"largeImageURL\", \"type\", \"imagelist\", \"docId\", \"channelId\", \"docSource\", \"topic\", \"videoURL\", \"content\", \"createDate\", \"middleImageURL\", \"authors\") values ( '%d', '%@', '%d', '%@', '%d', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@')",[aContentLevel.discussNum intValue],NULL,[aContentLevel.type intValue],NULL,[aContentLevel.docId intValue],aContentLevel.channelId,aContentLevel.docSource,aContentLevel.topic,aContentLevel.videoURL,aContentLevel.content,aContentLevel.createDate,aContentLevel.middleImageURL,aContentLevel.authors];
    DLog(@"asd");
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
    return NO;
}
@end

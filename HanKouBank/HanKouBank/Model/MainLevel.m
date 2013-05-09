//
//  Level.m
//  TestTestJson
//
//  Created by jianxin on 13-4-24.
//  Copyright (c) 2013年 jianxin. All rights reserved.
//

#import "MainLevel.h"

@implementation MainLevel

- (id)initLevelWithDic:(NSDictionary*)dic
{
    self = [super init];
    if (self) {
        self.Id = [dic objectForKey:@"id"];
        self.sortFlag = [dic objectForKey:@"sortFlag"];
        self.text = [dic objectForKey:@"text"];
        self.channelType = [dic objectForKey:@"channelType"];
        self.level = [dic objectForKey:@"level"];
        self.channelIcon = [dic objectForKey:@"channelTcon"];
        
        NSArray *array = [dic objectForKey:@"sons"];
        if (array.count>0) {
            NSMutableArray *mArray = [[NSMutableArray alloc]init];
            for (NSDictionary *d in array) {
                MainLevel *level = [[MainLevel alloc]initLevelWithDic:d];
                [mArray addObject:level];
            }
            self.sons = mArray;
        }
    }
    return self;
}

- (void)titleFromJson:(NSDictionary *)dic
{
    self.Id = [dic objectForKey:@"id"];
    self.sortFlag = [dic objectForKey:@"sortFlag"];
    self.text = [dic objectForKey:@"text"];
    self.channelType = [dic objectForKey:@"channelType"];
    self.level = [dic objectForKey:@"level"];
    self.channelIcon = [dic objectForKey:@"channelIcon"];
    
}

- (NSString *)description{
    return [NSString stringWithFormat:@"%@,%@,%@,%@",self.Id,self.text,self.channelIcon,self.sons];
}


@end

//
//  User.h
//  HanKouBank
//
//  Created by David on 13-5-10.
//  Copyright (c) 2013年 David. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
{
    NSString *_username;
    NSString *_password;
    NSUInteger _uid;
    NSString *_email;
    NSString *_realname;
}

@property (nonatomic, retain) NSString *username;
@property (nonatomic, retain) NSString *password;
@property (nonatomic, assign) NSUInteger uid;
@property (nonatomic, retain) NSString *email;
@property (nonatomic, retain) NSString *realname;

@end

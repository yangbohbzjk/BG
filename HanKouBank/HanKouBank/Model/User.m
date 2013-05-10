//
//  User.m
//  HanKouBank
//
//  Created by David on 13-5-10.
//  Copyright (c) 2013年 David. All rights reserved.
//

#import "User.h"

@implementation User
@synthesize username = _username;
@synthesize password = _password;
@synthesize uid = _uid;
@synthesize email = _email;
@synthesize realname = _realname;

-(id)init
{
    self =  [super init];
    if (self) {
        self.username = nil;
        self.password = nil;
        self.uid = 0;
        self.email = nil;
        self.realname = nil;
    }
    
    return self;
}
@end

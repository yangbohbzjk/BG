//
//  RequestMaker.h
//  NetworkDemo
//
//  Created by Haoran Yu on 12-5-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "NewsContent.h"
@interface RequestMaker : NSObject

//- (id)initWithTarget:(id)delegate action:(SEL)action;

/*-------------------------------------------------------------
 instruction
 author:zyq
 date  :2013-1-22
 此处暂设接口4个
 1.获取对应客户端的栏目信息，例如新华国际的ClientID为201.LanguageType 标识中英文版本
 2.获取对应客户端的对应栏目号之下的概要信息，pn表示页码，ps表示每页显示的条数
 3.获取对应客户端的对应栏目号之下对应文章号的详细信息。docID表示对应文章ID
 4.获取客户端信息属性，例如新华国际的ClientID为201（有同步和异步两种方式）
 +1
 5.根据相应的图片的URL来下载图片
 --------------------------------------------------------------*/
+ (void)getChannels:(NSString *)ClientID LanguageType:(NSInteger)languageType delegate:(id)delegate action:(SEL)action;
//+ (void)getArticles:(NSString *)groupedcategoryID pageNo:(NSString *)pageNo pageSize:(NSString *)pageSize delegate:(id)delegate action:(SEL)action;
+ (void)getArticles:(NSInteger)groupedcategoryID pageNo:(NSInteger)pageNo pageSize:(NSInteger)pageSize delegate:(id)delegate action:(SEL)action;
+ (void)getDetailArticle:(NSInteger)groupedcategoryID docID:(NSInteger)docID delegate:(id)delegate action:(SEL)action;
+ (NSString *)getAppWrapper:(NSString *)ClientID;
+ (void)getAppWrapper:(NSString *)ClientID delegate:(id)delegate action:(SEL)action;
+ (void)getImageFromURL:(NSString *)imageURL ImageType:(NSString *)imageType delegate:(id)delegate action:(SEL)action selectindex:(NSInteger)selectindex;
+ (NSData *)getDetailArticle:(NSInteger)groupedcategoryID docID:(NSInteger)docID;
+(BOOL)CheckNewVersion;
+(void)getCompile:(NSString *)news_title news_des:(NSString*)news_des delegate:(id)delegate action:(SEL)action;
+(void)getAddPic:(NSData *)picname newsTitle:(NSString *)newstitle newsContent:(NSString *)newscontent delegate:(id)delegate action:(SEL)action;
+(void)getCommentList:(id)delegate action:(SEL)action docID:(NSInteger)docID  limit:(NSInteger)limit start:(NSInteger)start;//- (void)alert;

+(NSData *)getAdvert:(NSString *)ClientID type:(NSString *)type;
+(NSData *)getAdvertImageFromURL:(NSString *)imageURL;
//
////同步登陆请求
//+(NSString*)syncLoginWithUserName:(NSString*)username pwd:(NSString*)pwd;
//
////登陆请求
//+(void)loginWithUserName:(NSString*)username pwd:(NSString*)pwd delegate:(id)delegate;
//
////登出请求
//+(void)logoutWithDelegate:(id)delegate;
//
////提交多媒体文件
//+(void)saveMultimediaFileWithServerFileID:(NSString*)fid fileLength:(int)length originFileName:(NSString*)oriFileName delegate:(id)delegate;
//
////删除上传的文件
//+(void)deleteUploadedFileWithServerFileID:(NSString*)fid fileLength:(int)length delegate:(id)delegate;
//
//+(void)syncGetUserInfo:(NSString*)sessionId loginName:(NSString*)loginName delegate:(id)delegate;
//
//+(NSString *)syncGetUserInfo:(NSString*)sessionId loginName:(NSString*)loginName;
//
////获得系统消息
//+(void)GetSystemInfo:(NSString *)loginname sessionid:(NSString *)sessionid delegate:(id)delegate;
////异步获取系统消息(所有发送给loginname的，时间在lasttime以后)
//+(void)GetSystemInfoByLastTime:(NSString *)loginname sessionid:(NSString *)sessionid msgTime:(NSString *)lasttime delegate:(id)delegate;
////同步发送消息(回复即时消息)
//+(NSString*)SendSystemMessage:(NSString *)loginname sessionid:(NSString *)sessionid msgowner:(NSString *)msgowner msgcontent:(NSString *)msgcontent delegate:(id)delegate;
////获取稿签
//+(void)GetTemplate:(NSString *)loginname sessionid:(NSString *)sessionid delegate:(id)delegate;
//
////+(void)GetUrlArry:(NSString *)defaulturl delegate:(id)delegate;
//
//+(BOOL)GetUrlArry:(NSString *)defaulturl;
////+(NSString *)getudid;
//+(NSString *)getServerVersion;
////保持会话
//+(BOOL)KeepAlive;
//
//+(void)getOAInfo:(NSInteger )limit id:(NSInteger )id delegate:(id)delegate;
//+(void)getOADetailByID:(NSString *)id delegate:(id)delegate;
@end


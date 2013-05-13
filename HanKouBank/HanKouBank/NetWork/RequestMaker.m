//
//  RequestMaker.m
//  NetworkDemo
//
//  Created by Haoran Yu on 12-5-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "RequestMaker.h"
#import "NetworkManager.h"
#import "ASIHTTPRequest.h"
#import "NetWorkConfig.h"
#import "GTMBase64.h"
//#import "NewsContent.h"
//#import "Utility.h"
#import "ASIFormDataRequest.h"
#import "JSONKit.h"
@implementation RequestMaker

+ (NSString *)encodeBase64:(NSString *)input
{
    NSData *data = [input dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    data = [GTMBase64 encodeData:data];
    NSString *base64String = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
    
    base64String = [base64String stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
    return base64String;
}

+ (void)getChannels:(NSString *)ClientID LanguageType:(NSInteger)languageType delegate:(id)delegate action:(SEL)action
{
    //http://202.84.17.194/cm/vipapi/tree?id=141
    NSString *url;
    NSString *currentLanguage = [[NSUserDefaults standardUserDefaults]objectForKey:AppLanguage];
    if ([currentLanguage isEqualToString: @"en"]) {
        languageType = EnglishLanguage;
    }else
        if ([currentLanguage isEqualToString: @"zh-Hans"])
        {
            languageType = ChineseLanguage;
        }
    //注，我报道中暂时未提供英文借口，所以此处，type赋default
    languageType = DefaultLanguage;

    switch (languageType) {
        case ChineseLanguage:
            url = [NSString stringWithFormat:@"%@%@/tree?languageType=%d",kBaseRequestUrl,clientID,languageType];
            break;
        case EnglishLanguage:
            url = [NSString stringWithFormat:@"%@%@/tree?languageType=%d",kBaseRequestUrl,clientID,languageType];
            break;
        default:
            url = [NSString stringWithFormat:@"%@%@/tree",kBaseRequestUrl,clientID];
            break;
    }
    NSLog(@"%@",url);
   
    NSMutableDictionary *requestInfo = [[NSMutableDictionary alloc] init];
    [requestInfo setObject:url forKey:RequestUrl];
    [requestInfo setObject:GetChannels forKey:RequestTYPE];
   // [[NetworkManager sharedManager] requestDataWithDelegate:delegate info:requestInfo];
    [[NetworkManager sharedManager] requestDataWithDelegate:delegate info:requestInfo selfaction:action];
    [requestInfo release];requestInfo = nil;
    //[super get:url];
}
+(void)getCommentList:(id)delegate action:(SEL)action docID:(NSInteger)docID  limit:(NSInteger)limit start:(NSInteger)start
{
    NSString *url = [NSString stringWithFormat:@"%@?articleid=%d&limit=%d&start=%d",commentRequestUrl,docID,limit,start];
    NSLog(@"%@",url);
    NSMutableDictionary *requestInfo = [[NSMutableDictionary alloc] init];
    [requestInfo setObject:url forKey:RequestUrl];
    [requestInfo setObject:GetNewsItems forKey:RequestTYPE];
    [[NetworkManager sharedManager] requestDataWithDelegate:delegate info:requestInfo selfaction:action];
    [requestInfo release];requestInfo = nil;
    
}
+ (void)getArticles:(NSInteger)groupedcategoryID pageNo:(NSInteger)pageNo pageSize:(NSInteger)pageSize delegate:(id)delegate action:(SEL)action
{
    NSString *url = [NSString stringWithFormat:@"%@%@/tree/%d?pn=%d&ps=%d",kBaseRequestUrl,clientID,groupedcategoryID,pageNo,pageSize];
      NSLog(@"%@",url);
    NSMutableDictionary *requestInfo = [[NSMutableDictionary alloc] init];
    [requestInfo setObject:url forKey:RequestUrl];
    [requestInfo setObject:GetNewsItems forKey:RequestTYPE];
    
   // [[NetworkManager sharedManager] requestDataWithDelegate:delegate info:requestInfo];
     [[NetworkManager sharedManager] requestDataWithDelegate:delegate info:requestInfo selfaction:action];
    [requestInfo release];requestInfo = nil;
    //[super get:url];
}

+ (void)getDetailArticle:(NSInteger)groupedcategoryID docID:(NSInteger)docID delegate:(id)delegate action:(SEL)action
{
   // NSString *url = [NSString stringWithFormat:@"http://202.84.17.194/cm/vipapi/tree/%d/%d",groupedcategoryID,docID];
   // NSString *url = [NSString stringWithFormat:@"%@tree/%d/%d",ContentUrl,groupedcategoryID,docID];
    NSString *url = [NSString stringWithFormat:@"%@%@/tree/%d/%d",kBaseRequestUrl,clientID,groupedcategoryID,docID];
    NSLog(@"%@",url);
    NSMutableDictionary *requestInfo = [[NSMutableDictionary alloc] init];
    [requestInfo setObject:url forKey:RequestUrl];
    [requestInfo setObject:GetNewsContent forKey:RequestTYPE];
    
   // [[NetworkManager sharedManager] requestDataWithDelegate:delegate info:requestInfo];
     [[NetworkManager sharedManager] requestDataWithDelegate:delegate info:requestInfo selfaction:action];
    //[super get:url];
}
//同步获取内容
+ (NSData *)getDetailArticle:(NSInteger)groupedcategoryID docID:(NSInteger)docID
{
    //http://202.84.17.194/cm/aic/app/v1/221/tree/461/81453 
    //NSString *url = [NSString stringWithFormat:@"http://202.84.17.194/cm/vipapi/tree/%d/%d",groupedcategoryID,docID];
    NSString *url = [NSString stringWithFormat:@"%@%d/tree/%d/%d",kBaseRequestUrl,301,groupedcategoryID,docID];
      NSLog(@"%@",url);
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
   // request.timeOutSeconds =kTimeoutInterval2;
    [request setTimeOutSeconds:kTimeoutInterval2];
    [request addRequestHeader:@"Content-Type" value:@"application/x-www-form-urlencoded"];
    [request addRequestHeader:@"Authorization" value:[NSString stringWithFormat:@"Basic %@",[self encodeBase64:[NSString stringWithFormat:@"%@:%@",Username,Password]]]];
    //[request appendPostData:bodyData];
    [request setRequestMethod:GET];
    [request startSynchronous];
    
    NSError *error = [request error];
    if (!error) {
        
       // NSString *responseString=[[NSString alloc] initWithData:[request responseData] encoding:NSUTF8StringEncoding];
       // return [[Utility parseFromDataContent:[request responseData]] objectAtIndex:0];
        return [request responseData];
    }
    else {
       // NSLog(@"获取版本信息失败，请检查网络！");
        return nil;
    }
}

+(void)getCompile:(NSString *)news_title news_des:(NSString *)news_des delegate:(id)delegate action:(SEL)action
{
    
    NSString * url=wBaseRequestUrl;//接口地址
    NSString *bodyStr=[NSString stringWithFormat:@"news_title=%@&news_des=%@&client_mark=%@&client_id=%d&client_des=%@",news_title,news_des,@"新华国际12345678901",4,@"XhgjIphone"];//请求体逗号前是方法后面是参数
    NSLog(@"%@",url);
    NSLog(@"%@",bodyStr);
    NSMutableDictionary *requestDic=[[NSMutableDictionary alloc] init];
    [requestDic setObject:url forKey:RequestUrl];
    [requestDic setObject:bodyStr forKey:POST_BODY];
    [requestDic setObject:POST forKey:RequestMethod];
    [[NetworkManager sharedManager] requestDataWithDelegate:delegate info:requestDic selfaction:action];
    [requestDic release];
    requestDic=nil;
//    NSData * bodyData = [bodyStr dataUsingEncoding:NSUTF8StringEncoding];
//    ASIHTTPRequest * request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
//    [request addRequestHeader:@"Content-Type" value:@"application/x-www-form-urlencoded"];
//    [request addRequestHeader:@"Content-Length" value:[NSString stringWithFormat:@"%d",[bodyData length]]];
//    [request appendPostData:bodyData];
//    [request setRequestMethod:POST];
//    [request startSynchronous];
//    NSError * error = [request error];
//    if (!error) {
//        NSString * responseString = [[NSString alloc]initWithData:[request responseData] encoding:NSUTF8StringEncoding];
//        return [responseString autorelease];
//    }
//    else{
//        NSLog(@"上传失败");
//        return nil;
//    }
//    
//    return nil;
}
//评论
//+(void)loginWithContent:(NSInteger)articleid coutent:(NSString *)content delegate:(id)delegate action:(SEL)action
//{
//    
//    // [[NetworkManager sharedManager] requestDataWithDelegate:delegate info:requestInfo];
//    
//    NSString * url = cBaseRequestUrl;
//    NSString * bodyStr = [NSString stringWithFormat:@"articleid=%d&content=%@&clientid=%@",articleid,content,clientID];
//    
//    NSMutableDictionary *requestInfo = [[NSMutableDictionary alloc] init];
//    [requestInfo setObject:url forKey:RequestUrl];
//    [requestInfo setObject:postContent forKey:RequestTYPE];
//    [requestInfo setObject:bodyStr forKey:POST_BODY];
//    [requestInfo setObject:POST forKey:RequestMethod];
//    [[NetworkManager sharedManager] requestDataWithDelegate:delegate info:requestInfo selfaction:action];
//    [requestInfo release];requestInfo = nil;
//}

//上传带图片的报道
+(void)getAddPic:(NSData *)picdata newsTitle:(NSString *)newstitle newsContent:(NSString *)newscontent delegate:(id)delegate action:(SEL)action
{
    NSString *url=picBaseRequestUrl;
    //NSString *bodyStr=[NSString stringWithFormat:@"news_title=%@&news_des=%@&news_filedata=%@&client_mark=%@&client_id=%d&client_des=%@",newstitle,newscontent,picdata,@"新华国际12345678901",4,@"XhgjIphone"];
    NSMutableDictionary *requestDic=[[NSMutableDictionary alloc] init];
    [requestDic setObject:url forKey:RequestUrl];
    [requestDic setObject:picdata forKey:NewsFiledata];
    [requestDic setObject:newstitle forKey:NewsTitle];
    [requestDic setObject:newscontent forKey:NewsDes];
    [requestDic setObject:@"新华国际00000000000" forKey:ClientMark];
    [requestDic setObject:@"4" forKey:ClientId];
    [requestDic setObject:@"XhgjIphone" forKey:ClientDes];
    [requestDic setObject:@"XhgjWoBaoLiao" forKey:AppDes];
    [requestDic setObject:@"5" forKey:BaoLiaoId];
    //异步上传图片
    [[NetworkManager sharedManager] uploadWithDelegate:delegate info:requestDic selfaction:action];
    [requestDic release];
    requestDic=nil;

}
+ (NSString *)getAppWrapper:(NSString *)ClientID
{
    NSString *url = [NSString stringWithFormat:@"%@%@",kBaseRequestUrl,ClientID];
      NSLog(@"%@",url);
    //NSData *bodyData = [bodyStr dataUsingEncoding:NSUTF8StringEncoding];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
   // request.timeOutSeconds =kTimeoutInterval2;
    [request setTimeOutSeconds:kTimeoutInterval2];
    [request addRequestHeader:@"Content-Type" value:@"application/x-www-form-urlencoded"];
    [request addRequestHeader:@"Authorization" value:[NSString stringWithFormat:@"Basic %@",[self encodeBase64:[NSString stringWithFormat:@"%@:%@",Username,Password]]]];
    //[request appendPostData:bodyData];
    [request setRequestMethod:GET];
    [request startSynchronous];
    
    NSError *error = [request error];
    if (!error) {
        
        NSString *responseString=[[NSString alloc] initWithData:[request responseData] encoding:NSUTF8StringEncoding];
        return [responseString autorelease];
    }
    else {
        NSLog(@"获取版本信息失败，请检查网络！");
        return nil;
    }

}

+ (void)getAppWrapper:(NSString *)ClientID delegate:(id)delegate action:(SEL)action
{
    NSString *url = [NSString stringWithFormat:@"%@%@",kBaseRequestUrl,ClientID];
      NSLog(@"%@",url);
    NSMutableDictionary *requestInfo = [[NSMutableDictionary alloc] init];
    [requestInfo setObject:url forKey:RequestUrl];
    [requestInfo setObject:GetAppWrapper forKey:RequestTYPE];
    
    //[[NetworkManager sharedManager] requestDataWithDelegate:delegate info:requestInfo];
     [[NetworkManager sharedManager] requestDataWithDelegate:delegate info:requestInfo selfaction:action];
    //[super get:url];
}

+ (void)getImageFromURL:(NSString *)imageURL ImageType:(NSString *)imageType delegate:(id)delegate action:(SEL)action selectindex:(NSInteger)selectindex
{
    NSString *url =imageURL;
      NSLog(@"%@",url);
    NSMutableDictionary *requestInfo = [[NSMutableDictionary alloc] init];
    [requestInfo setObject:url forKey:RequestUrl];
    [requestInfo setObject:imageType forKey:RequestTYPE];
    
    //[[NetworkManager sharedManager] requestDataWithDelegate:delegate info:requestInfo];
   //  [[NetworkManager sharedManager] requestDataWithDelegate:delegate info:requestInfo selfaction:action];
    [[NetworkManager sharedManager] requestDataWithDelegate:delegate info:requestInfo selfaction:action selectindex:selectindex];
}

//检查是否是最新版本
+(BOOL)CheckNewVersion
{
    NSString *version = @"";
	NSURL *url = [NSURL URLWithString:@"http://itunes.apple.com/lookup?id=536530480"];
	ASIFormDataRequest *versionRequest = [ASIFormDataRequest requestWithURL:url];
	[versionRequest setRequestMethod:@"GET"];
	[versionRequest setDelegate:self];
	[versionRequest setTimeOutSeconds:150];
	[versionRequest addRequestHeader:@"Content-Type" value:@"application/json"];
	[versionRequest startSynchronous];
      NSLog(@"%@",url);
	//Response string of our REST call
	NSString* jsonResponseString = [versionRequest responseString];
	NSLog(@"%@",jsonResponseString);
	NSDictionary *loginAuthenticationResponse = [jsonResponseString objectFromJSONString];
	NSArray *configData = [loginAuthenticationResponse valueForKey:@"results"];
    //NSLog(@"%d",[configData count]);
    //zyq,2013-4-9,首先判断configdata是否为空，不为空获取version字段，然后比较version字段和工程plist文件对应的版本号，此时需比较大小而非相等，当appstore上的版本大于本地的版本时，提示更新，返回true。否则返回false。
    if (configData&&[configData count]>0) {
        for (id config in configData)
        {
            version = [config valueForKey:@"version"];
            //NSLog(@"%f,%f",[version floatValue],[[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]floatValue]);
        }
        //if (![version isEqualToString:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]])
        if ([version floatValue] > [[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]floatValue])
        {
            return TRUE;//需要最新
        }
    }
    
    return FALSE;//不要更新
    
}
//+(NSData *)getAdvert:(NSString *)ClientID type:(NSString *)type
//{
//    //@"http://202.84.17.194/cm/aic/advert/221/0"
//    NSString *url=[NSString stringWithFormat:@"%@/%@/%@",advertRequestUrl,ClientID ,type];
//    //    NSMutableDictionary *requestInfo = [[NSMutableDictionary alloc] init];
//    //    [requestInfo setObject:url forKey:RequestUrl];
//    //    [[NetworkManager sharedManager] requestDataWithDelegate:delegate info:requestInfo selfaction:action];
//    //    [requestInfo release];requestInfo = nil;
//    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
//    // request.timeOutSeconds =kTimeoutInterval2;
//    [request setTimeOutSeconds:kTimeoutInterval2];
//    [request addRequestHeader:@"Content-Type" value:@"application/x-www-form-urlencoded"];
//    [request addRequestHeader:@"Authorization" value:[NSString stringWithFormat:@"Basic %@",[self encodeBase64:[NSString stringWithFormat:@"%@:%@",Username,Password]]]];
//    //[request appendPostData:bodyData];
//    [request setRequestMethod:GET];
//    [request startSynchronous];
//    
//    NSError *error = [request error];
//    if (!error) {
//        return [request responseData];
//    }
//    else {
//        // NSLog(@"获取版本信息失败，请检查网络！");
//        return nil;
//    }
//}
+(NSData *)getAdvertImageFromURL:(NSString *)imageURL
{
    NSString *url =imageURL;
    NSLog(@"%@",url);
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
    // request.timeOutSeconds =kTimeoutInterval2;
    [request setTimeOutSeconds:kTimeoutInterval2];
    [request addRequestHeader:@"Content-Type" value:@"application/x-www-form-urlencoded"];
    [request addRequestHeader:@"Authorization" value:[NSString stringWithFormat:@"Basic %@",[self encodeBase64:[NSString stringWithFormat:@"%@:%@",Username,Password]]]];
    //[request appendPostData:bodyData];
    [request setRequestMethod:GET];
    [request startSynchronous];
    
    NSError *error = [request error];
    if (!error) {
        return [request responseData];
    }
    else {
        // NSLog(@"获取版本信息失败，请检查网络！");
        return nil;
    }
    
}
@end
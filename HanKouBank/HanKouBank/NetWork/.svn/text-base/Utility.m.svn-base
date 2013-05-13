//
//  Utility.m
//  XinHuaInternational
//
//  Created by  miti on 13-1-24.
//  Copyright (c) 2013年  miti. All rights reserved.
//

#import "Utility.h"
#import "Channel.h"
#import "NewsContent.h"
#import "NewsItem.h"
#import "JSONKit.h"
#import "Config.h"
#import "Reachability.h"
#import "NewsContentDB.h"
#import "ChannelDB.h"
#import "NewsItemDB.h"
#import "NewsCollectionDB.h"
#import "NetWorkConfig.h"
#import "RequestMaker.h"
#import "AppDelegate.h"
#import "NetworkManager.h"
#import "Comment.h"
#import "VisitedRecordsDB.h"

@implementation Utility

//栏目内容解析
+(NSMutableArray *)parseFromDataChannel:(NSData *)data
{
    NSMutableArray *resultArray = [[[NSMutableArray alloc]initWithCapacity:0]autorelease];
    NSString *resultStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@",resultStr);
    NSArray *responsearray = [resultStr mutableObjectFromJSONString];
   
    
    for (int i = 0; i < [responsearray count]; i++) {
        //modal here栏目
        Channel *channel  = [[Channel alloc]init];
        
        channel.channelId = [[[responsearray objectAtIndex:i] objectForKey:@"id"] intValue];
        NSLog(@"channeid%d",channel.channelId);
        channel.text      = [[responsearray objectAtIndex:i] objectForKey:@"name"];
        NSLog(@"%@",channel.text);
        channel.type      = [[[responsearray objectAtIndex:i] objectForKey:@"type"] intValue];
        NSLog(@"%d",channel.type);
        channel.sortFlag  = [[[responsearray objectAtIndex:i] objectForKey:@"sortFlag"] intValue];
        channel.level     = [[[responsearray objectAtIndex:i] objectForKey:@"level"] intValue];
        if ([[responsearray objectAtIndex:i] objectForKey:@"url"]!=[NSNull null]) {
                channel.icon      = [[responsearray objectAtIndex:i] objectForKey:@"url"];
        }
        channel.language  = @"CH";
        channel.leaf      = 1;//1标识是叶子节点，无子栏目
        channel.parentId  = 0;//0标识无父栏目，即顶级栏目
        NSLog(@"%@",[responsearray objectAtIndex:i]);
        if ([[responsearray objectAtIndex:i] objectForKey:@"sons"]!=[NSNull null])
        {
            
            channel.leaf  = 0;//有子栏目
            
            //解析子栏目
            NSArray *sonArray = [[responsearray objectAtIndex:i] objectForKey:@"sons"];
          
            for (int j=0; j<[sonArray count]; j++) {
                Channel *sonChannel  = [[Channel alloc]init];
                sonChannel.channelId = [[[sonArray objectAtIndex:j] objectForKey:@"id"] intValue];
                sonChannel.text      = [[sonArray objectAtIndex:j] objectForKey:@"name"];
                sonChannel.type      = [[[sonArray objectAtIndex:j] objectForKey:@"type"] intValue];
                sonChannel.sortFlag  = [[[sonArray objectAtIndex:j] objectForKey:@"sortFlag"] intValue];
                sonChannel.level     = [[[sonArray objectAtIndex:j] objectForKey:@"level"] intValue];
                if ([[sonArray objectAtIndex:j] objectForKey:@"url"]!=[NSNull null])
                 {
                sonChannel.icon      = [[sonArray objectAtIndex:j] objectForKey:@"url"];
                 }
                sonChannel.leaf      = 1;
                sonChannel.parentId  = channel.channelId;
                sonChannel.language = @"CH";
                [resultArray addObject:sonChannel];
                [sonChannel release];

            }
           
        }
        NSLog(@"%@",channel);
        [resultArray addObject:channel];
        [channel release];
    }
     //[resultStr release];
   // NSLog(@"%d",[resultStr retainCount]);
    [resultStr release];
    return resultArray;
    
    
}

+(NSMutableArray *)parseFromDataAdvert:(NSData *)data
{
    NSMutableArray *resultArray = [[[NSMutableArray alloc]initWithCapacity:0]autorelease];
    NSString *resultStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@",resultStr);
    NSArray *responsearray = [resultStr mutableObjectFromJSONString];
    for(int i=0;i<responsearray.count;i++)
    {
        NSDictionary *dic=[responsearray objectAtIndex:i];
        NSString *path;
        NSString *hrefs;
        NSString *url;
        for(NSString *str in dic)
        {
            if ([str isEqualToString:@"imageHrefs"]) {
                NSString *all=[dic objectForKey:str];
                NSString *subStr1=[all substringFromIndex:1];
                NSString *subStr2=@"]";
                NSRange range=[subStr1 rangeOfString:subStr2];
                hrefs=[subStr1 substringToIndex:range.location];
            }
            if ([str isEqualToString:@"path"]) {
                path=[dic objectForKey:str];
            }
            url=[NSString stringWithFormat:@"%@%@",path,hrefs];
        }
        [resultArray addObject:url];
    }
    return resultArray;
}

//新闻列表解析
+(NSMutableArray *)parseFromDataNews:(NSData *)data
{
    NSMutableArray *resultArray = [[[NSMutableArray alloc]initWithCapacity:0]autorelease];
    NSArray *newsItemArray = [[[NSArray alloc]init]autorelease];
    NSString *path;
    
    JSONDecoder *jd = [[JSONDecoder alloc]init];
    NSDictionary *resultDic = [jd objectWithData:data];
   // NSLog(@"%@",resultDic);
    for (NSDictionary *result in resultDic) {
        path = [result objectForKey:@"path"];
        newsItemArray = [result objectForKey:@"content"];
    }
    
    [jd release];
    
    //栏目下的文章列表
    for (int i = 0; i < [newsItemArray count]; i++) {
        
        NewsItem *newsItem = [[NewsItem alloc]init];
        
        newsItem.docId          = [[[newsItemArray objectAtIndex:i] objectForKey:@"docId"] intValue];
        newsItem.channelId      = [[[newsItemArray objectAtIndex:i] objectForKey:@"groupedCategoryId"] intValue];
        newsItem.type           = [[[newsItemArray objectAtIndex:i] objectForKey:@"type"] intValue];
        if ([[newsItemArray objectAtIndex:i] objectForKey:@"commentCount"]) {
            if ([[newsItemArray objectAtIndex:i] objectForKey:@"commentCount"]!=[NSNull null]) {
                  newsItem.discussNum = [[[newsItemArray objectAtIndex:i] objectForKey:@"commentCount"] intValue];
            }
          
        }
        newsItem.topic          = [[newsItemArray objectAtIndex:i] objectForKey:@"topic"];
        newsItem.createDate     = [[newsItemArray objectAtIndex:i] objectForKey:@"createDate"];
        newsItem.docSource      = [[newsItemArray objectAtIndex:i] objectForKey:@"docSource"];
        if ([[newsItemArray objectAtIndex:i] objectForKey:@"smallImageHref"]!=[NSNull null]) {
            if ([[newsItemArray objectAtIndex:i] objectForKey:@"smallImageHref"]!=[NSNull null]) {
                 newsItem.smallImageHref = [path stringByAppendingString:[[newsItemArray objectAtIndex:i] objectForKey:@"smallImageHref"]];
            }
        }
        newsItem.abstract       = [[[newsItemArray objectAtIndex:i] objectForKey:@"summary"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        //[s stringByReplacingOccurrencesOfString:@" " withString:@""]
        //[inputStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]
        [resultArray addObject:newsItem];
       // NSLog(@"%@",newsItem.smallImageHref);
        [newsItem release];
        
    }
    return resultArray;
    
    
}

//评论内容解析
+(NSMutableArray *)parseFromDataComment:(NSData *)data
{
    JSONDecoder *jd = [[JSONDecoder alloc]init];
    NSDictionary *resultDic = [jd objectWithData:data];
    // NSLog(@"%@",resultDic);
//    for (NSDictionary *result in resultDic) {
//        path = [result objectForKey:@"path"];
//        newsItemArray = [result objectForKey:@"content"];
//    }
    NSArray *responsearray=[resultDic objectForKey:@"commentList"];

//    NSMutableArray *resultArray = [[[NSMutableArray alloc]initWithCapacity:0]autorelease];
//    NSArray *commentArray = [[[NSArray alloc]init]autorelease];
//    NSString *resultStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//    NSLog(@"%@",resultStr);
//    NSArray *responsearray = [resultStr mutableObjectFromJSONString];
//    commentArray=[[responsearray objectAtIndex:0] objectForKey:@"commentList"];
//    //评论列表
//    for (int i = 0; i < [commentArray count]; i++) {
//        Comment *commentItem=[[Comment alloc] init];
//        commentItem.cid=[[commentArray objectAtIndex:i] objectForKey:@"cid"];
//        commentItem.commenttext=[[commentArray objectAtIndex:i] objectForKey:@"comment"];
//        [resultArray addObject:commentItem];
//        [commentItem release];
//        
//    }
    return nil;
    

}
//新闻内容解析
+(NSMutableArray *)parseFromDataContent:(NSData *)data
{
    NSMutableArray *resultArray = [[[NSMutableArray alloc]initWithCapacity:0]autorelease];
    //解析文章详情
    NSString *resultStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSDictionary *responsearray = [resultStr mutableObjectFromJSONString];
    [resultStr release];
    
    NewsContent *newsContent = [[[NewsContent alloc]init]autorelease];
   // NSLog(@"%@",responsearray);
    NSString *path=[responsearray objectForKey:@"path"];
    newsContent.docId          = [[responsearray objectForKey:@"docId"] intValue];
    newsContent.channelId      = [[responsearray objectForKey:@"groupedCategoryId"] intValue];
    newsContent.type           = [[responsearray objectForKey:@"type"] intValue];
    if ([responsearray objectForKey:@"discussNum"]) {
        if ([responsearray objectForKey:@"discussNum"]!=[NSNull null]) {
            newsContent.discussNum = [[responsearray objectForKey:@"discussNum"] intValue];

        }
    }
    if ([responsearray objectForKey:@"topic"]!=[NSNull null]) {
          newsContent.topic          = [responsearray objectForKey:@"topic"];
    }
    if ([responsearray objectForKey:@"content"]!=[NSNull null]) {
          newsContent.content        = [responsearray objectForKey:@"content"];
    }
    if ([responsearray objectForKey:@"authors"]) {
        if ([responsearray objectForKey:@"authors"]!=[NSNull null]) {
            newsContent.authors    = [responsearray objectForKey:@"authors"];
        }
    }
    newsContent.createDate     = [responsearray objectForKey:@"createDate"];
    if ([responsearray objectForKey:@"smallImageHref"]) {
        if ([responsearray objectForKey:@"smallImageHref"]!=[NSNull null]) {
             newsContent.middleImageURL = [path stringByAppendingString:[responsearray objectForKey:@"smallImageHref"]];
        }
       
    }
    if ([responsearray objectForKey:@"largeImageHref"]) {
        if ([responsearray objectForKey:@"largeImageHref"]!=[NSNull null]) {
              newsContent.largeImageURL  = [path stringByAppendingString:[responsearray objectForKey:@"largeImageHref"]];
        }
    }
    //注，此处docSorcerer可能为空，故需加判断。zyq,2013-4-16
    if ([responsearray objectForKey:@"docSource"])
    {
        if ([responsearray objectForKey:@"docSource"]!=[NSNull null])
        {
            newsContent.docSource      = [responsearray objectForKey:@"docSource"];
        }
    }
    //注，此处添加判断处理video的逻辑。4-19.此处videoImageURL[]和videoURL[]都是数组
    if ([responsearray objectForKey:@"videoImageURL"])
    {
        if ([responsearray objectForKey:@"videoImageURL"]!=[NSNull null])
        {
//            NSArray *videoImgList = [responsearray objectForKey:@"videoImageURL"];
            
            //修改
            NSString *str=[responsearray objectForKey:@"videoImageURL"];
//            NSString *str=@"getVideoImage/67,getVideoImage/68";   //测试用
            NSString *strUrl = [str stringByReplacingOccurrencesOfString:@"[" withString:@""];
            NSString *strUrl2 = [strUrl stringByReplacingOccurrencesOfString:@"]" withString:@""];
            NSArray *videoImgList = [strUrl2 componentsSeparatedByString:@","];
            for (int i = 0; i < [videoImgList count]; i++) {
                NSString *singleImage = [path stringByAppendingString:[videoImgList objectAtIndex:i]];
//                newsContent.largeImageURL = singleImage;
                newsContent.imageList = [newsContent.imageList stringByAppendingFormat:@"%@",[singleImage stringByAppendingString:(i == [videoImgList count]-1)?@"":@";"]];
            }

//             newsContent.largeImageURL  = [path stringByAppendingString:[responsearray objectForKey:@"videoImageURL"]];
        }
    }
    
    if ([responsearray objectForKey:@"videoURL"])
    {
        if ([responsearray objectForKey:@"videoURL"]!=[NSNull null])
        {
//            NSArray *videoList = [responsearray objectForKey:@"videoURL"];
//            
//            //修改
//            for (int i = 0; i < [videoList count]; i++) {
//                NSString *singleVideo = [path stringByAppendingString:[videoList objectAtIndex:i]];
//                newsContent.videoURL = [newsContent.imageList stringByAppendingFormat:@"%@",[singleVideo stringByAppendingString:(i == [videoList count]-1)?@"":@";"]];
//            }
            NSString *str=[responsearray objectForKey:@"videoURL"];
            NSString *strUrl = [str stringByReplacingOccurrencesOfString:@"[" withString:@""];
            NSString *strUrl2 = [strUrl stringByReplacingOccurrencesOfString:@"]" withString:@""];
            NSArray *videoList = [strUrl2 componentsSeparatedByString:@","];
            for (int i = 0; i < [videoList count]; i++) {
                NSString *singleVideo = [videoList objectAtIndex:i];
                newsContent.videoURL = [singleVideo stringByAppendingString:(i == [videoList count]-1)?@"":@";"];
            }
//             newsContent.videoURL  = [responsearray objectForKey:@"videoURL"];
        }
    }else
        newsContent.videoURL = @"";

    if ([responsearray objectForKey:@"extHrefs"]) {
        if ([responsearray objectForKey:@"extHrefs"]!=[NSNull null]) {
            NSArray *imageList = [responsearray objectForKey:@"extHrefs"];
            for (int i = 0; i < [imageList count]; i++) {
                NSString *singleImage = [path stringByAppendingString:[imageList objectAtIndex:i]];
                newsContent.imageList = [singleImage stringByAppendingString:@";"];
            }
        }
//        else
//        {
//            NSArray *imageList = [responsearray objectForKey:@"smallImageHref"];
//            for (int i = 0; i < [imageList count]; i++) {
//                NSString *singleImage = [path stringByAppendingString:[imageList objectAtIndex:i]];
//                newsContent.imageList = [singleImage stringByAppendingString:@";"];
//            }
//        }
        
        //newsContent.imageList = [responsearray objectForKey:@"extHrefs"];
    }
    
    [resultArray addObject:newsContent];
    
    return resultArray;
    
}
#pragma mark -
#pragma mark 图片处理方法
//图片压缩。按照指定的尺寸进行变换，不保证不变形。
+(UIImage *)scale:(UIImage *)image toSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}
//图片按比例缩放到合适的高度。不变形
+(UIImage *)scale:(UIImage *)image toHeight:(float)height
{
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width * height/image.size.height, height));
    [image drawInRect:CGRectMake(0, 0, image.size.width * height/image.size.height, height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}
//图片按比例缩放到合适的宽度。不变形
+(UIImage *)scale:(UIImage *)image toWidth:(float)width
{
    UIGraphicsBeginImageContext(CGSizeMake(width,image.size.height*width/image.size.width));
    [image drawInRect:CGRectMake(0, 0, width,image.size.height*width/image.size.width)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}
+(UIImage *)scaleWithNoTransform:(UIImage *)image toSize:(CGSize)size
{
    
    int width = image.size.width;
    int height = image.size.height;
    if( width == size.width && height == size.height )
        return image;
    
    CGImageRef subImageRef;
    //原图片尺寸比目标尺寸大
    if( width >= size.width && height >= size.height )
    {
        //1、缩比例小的边;2、缩小后的图片进行切图（为了不变形）
        if( width/size.width < height/size.height )
        {
            UIImage *newImage1 = [self scale:image toWidth:size.width];
            subImageRef = CGImageCreateWithImageInRect(newImage1.CGImage, CGRectMake(0, (newImage1.size.height-size.height)/2, size.width, size.height));
        }
        else
        {
            UIImage *newImage1 = [self scale:image toHeight:size.height];
            subImageRef = CGImageCreateWithImageInRect(newImage1.CGImage, CGRectMake((newImage1.size.width-size.width)/2,0, size.width, size.height));
        }
    }
    else if( width <= size.width && height <= size.height )//原图片尺寸比目标尺寸小
    {
        //1、放比例大的边;2、对放大后的图片进行切图（为了不变形）
        CGImageRef subImageRef;
        if( width/size.width > height/size.height )
        {
            UIImage *newImage1 = [self scale:image toWidth:size.width];
            subImageRef = CGImageCreateWithImageInRect(newImage1.CGImage, CGRectMake(0, (newImage1.size.height-size.height)/2, size.width, size.height));
        }
        else
        {
            UIImage *newImage1 = [self scale:image toHeight:size.height];
            subImageRef = CGImageCreateWithImageInRect(newImage1.CGImage, CGRectMake((newImage1.size.width-size.width)/2,0, size.width, size.height));
        }
    }else//某个边比目标尺寸大、另一个边比目标尺寸小
    {
        //1、放小的边；2、切大的边
        if( width < size.width )
        {
            UIImage *newImage1 = [self scale:image toWidth:size.width];
            subImageRef = CGImageCreateWithImageInRect(newImage1.CGImage, CGRectMake(0, (newImage1.size.height-size.height)/2, size.width, size.height));
        }
        else
        {
            UIImage *newImage1 = [self scale:image toHeight:size.height];
            subImageRef = CGImageCreateWithImageInRect(newImage1.CGImage, CGRectMake((newImage1.size.width-size.width)/2,0, size.width, size.height));
        }
    }
    
    CGRect smallBounds = CGRectMake(0,0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));
    UIGraphicsBeginImageContext(smallBounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, smallBounds, subImageRef);
    UIImage *retImage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    CGImageRelease(subImageRef);
    
    //    UIImage *imageRet = [UIImage imageWithCGImage:subImageRef];
    //    CGImageRelease(subImageRef);//用完一定要释放，否则内存泄露
    
    return retImage;
}

//按比例缩放图片，保证不变形的情况下，有可能需要切图
+(UIImage *)cutImage:(UIImage *)image toSize:(CGSize)size
{
    //    CGRect rect =  CGRectMake(0, 0, size.width,size.height);//要裁剪的图片区域，按照原图的像素大小来，超过原图大小的边自动适配
    //    CGImageRef cgimg = CGImageCreateWithImageInRect([image CGImage], rect);
    //    UIImage *imageRet = [UIImage imageWithCGImage:cgimg];
    //    CGImageRelease(cgimg);//用完一定要释放，否则内存泄露
    //    return imageRet;
    
    CGFloat width = image.size.width;
    CGFloat height = image.size.height;
    if( width == size.width && height == size.height )
        return image;
    
    CGImageRef subImageRef;
    //判断宽高比
    if( width/height <= size.width/size.height )
    {
        float offsetY = height-size.height*width/size.width;
        subImageRef = CGImageCreateWithImageInRect(image.CGImage,CGRectMake(0,offsetY/2,width,height-offsetY));
    }
    else
    {
        float offsetX = width-size.width*height/size.height;
        subImageRef = CGImageCreateWithImageInRect(image.CGImage,CGRectMake(offsetX/2,0,width-offsetX,height));
    }
    
    UIImage *imageAfterCut = [UIImage imageWithCGImage:subImageRef];
    //    UIImage *imageRet = [self scale:imageAfterCut toWidth:size.width];
    CGImageRelease(subImageRef);//用完一定要释放，否则内存泄露
    
    return imageAfterCut;
}

//保存图片到沙盒的指定目录
//将该文件写入沙盒中对应的位置
+(BOOL)saveImage:(UIImage *)image localFileName:(NSString *)filename
{
    NSData *imageData = nil;
    
    //imageData = UIImagePNGRepresentation(image);
    imageData=UIImageJPEGRepresentation(image,1);
    
    BOOL success=[[NSFileManager defaultManager] fileExistsAtPath:FILEPATHINPHONE];
    if (success!=TRUE) {
        
        [[NSFileManager defaultManager] createDirectoryAtPath:FILEPATHINPHONE withIntermediateDirectories:NO attributes:nil error:nil];
    }
    if( imageData != nil )
    {
        NSString *savefilepath=[FILEPATHINPHONE stringByAppendingPathComponent:filename];//保存路径
        
        [imageData writeToFile:savefilepath atomically:TRUE];
        return YES;
    }
    else
        return NO;
    
    
}

//根据图片http路径映射为本地文件名
+(NSString *)mapURLtoLocalFilename:(NSString *)url
{
    //    NSArray *arrayTemp = [url componentsSeparatedByString:@"."];
    //    NSString *suffix = [arrayTemp objectAtIndex:[arrayTemp count]-1];
    NSString *filename = [url stringByReplacingOccurrencesOfString:@":" withString:@"_M_H_"];
    filename = [filename stringByReplacingOccurrencesOfString:@"/" withString:@"_X_G_"];
    filename = [filename stringByReplacingOccurrencesOfString:@"?" withString:@"_W_H_"];
    
    return filename;
}


//根据图片httpURL获取本地图片，如果未找到返回nil
+(UIImage *)getLocalImageFileByURL:(NSString *)imageUrl
{
    NSString *filePath = [FILEPATHINPHONE stringByAppendingPathComponent:[self mapURLtoLocalFilename:imageUrl]];
    if( [[NSFileManager defaultManager] fileExistsAtPath:filePath] )
    {
        NSData *data = [[NSFileManager defaultManager] contentsAtPath:filePath];
        UIImage *image=[[UIImage alloc] initWithData:data];
        return [image autorelease];
    }
    else
        return nil;
}
//获取有图或无图标志
+(BOOL)getPicTag{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"Config.plist"];
    //从plist中读取现有的xml基础数据w文件名称
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithContentsOfFile:filePath];
    if ([[dic objectForKey:@"PicTag"] isEqualToString: @"true"]) {
        return TRUE;
    }else{
        return FALSE;
    }
}

//获取有图或无图标志
+(NSInteger)getDefaultFontSize{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"Config.plist"];
    //从plist中读取现有的xml基础数据w文件名称
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithContentsOfFile:filePath];
    if( [dic objectForKey:@"FontSize"] != nil && ![[dic objectForKey:@"FontSize"] isEqualToString:@""] )
        return [[dic objectForKey:@"FontSize"] intValue];
    else
        return 16;
}

//获取当前用户
+(NSString*)getCurrentUsername{
    return @"";
}

//根据新闻正文对象获取该新闻的中图httpURL地址
//处理中图（如果新闻正文的type为3或者4，同时imagelist有值且middleImageUrl为空，则为多图稿）
+(NSString*)getMiddleImageURL:(NewsContent*)newsContent
{
    NSString *miUrl = @"";
    NSString *miUrl2 = @"";
    if( [newsContent.middleImageURL isEqualToString: @""] || newsContent.middleImageURL == NULL || newsContent.middleImageURL.length == 0)
    {
        if(![newsContent.imageList isEqualToString:@""] && [[newsContent.imageList componentsSeparatedByString:@";"] count] > 0)
        {
            miUrl = [[newsContent.imageList componentsSeparatedByString:@";"] objectAtIndex:0];
        }
    }
    else
    {
        miUrl = newsContent.middleImageURL;
    }
    NSLog(@"%@",miUrl);
    if ([miUrl isEqualToString:@""]) {
        if( [newsContent.videoURL isEqualToString: @""] || newsContent.videoURL == NULL || newsContent.videoURL.length == 0)
        {
            if(![newsContent.imageList isEqualToString:@""] && [[newsContent.imageList componentsSeparatedByString:@";"] count] > 0)
            {
                miUrl2 = [[newsContent.imageList componentsSeparatedByString:@";"] objectAtIndex:0];
            }
        }
        else
        {
            miUrl2 = newsContent.videoURL;
        }
        NSLog(@"%@",miUrl2);
        return miUrl2;
    }
    else
    {
        return miUrl;
    }
}
+(NSUInteger)testConnection {
    NSInteger result = 0;
    Reachability *r = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    switch ([r currentReachabilityStatus]) {
        case NotReachable:
            // 没有网络连接
            result = 0;
            break;
        case ReachableViaWWAN:
            // 使用3G网络
            result = 1;
            break;
        case ReachableViaWiFi:
            // 使用WiFi网络
            result = 1;
            break;
    }
    return result;
}
+(void)DeleteCache
{
    //删除沙盒中的图片
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString *document=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *folder =[document stringByAppendingPathComponent:@"user"];
    NSArray *fileList ;
    fileList =[fileManager contentsOfDirectoryAtPath:folder error:NULL];
    
    
    for (NSString *file in fileList) {
        NSLog(@"file=%@",file);
        NSString *path =[folder stringByAppendingPathComponent:file];
        NSLog(@"得到的路径=%@",path);
        [fileManager removeItemAtPath:path error:NULL];
    }
    //删除数据库记录
    NewsContentDB *newsdb=[[NewsContentDB alloc] init];
    [newsdb deleteAll];
    [newsdb release];
    
    NewsItemDB *newsitemdb=[[NewsItemDB alloc] init];
    [newsitemdb deleteAll];
    [newsitemdb release];
    
    ChannelDB *channel=[[ChannelDB alloc] init];
    [channel deleteAll];
    [channel release];
    
    VisitedRecordsDB *visitedRecordsdb=[[VisitedRecordsDB alloc] init];
    [visitedRecordsdb deleteAll];
    [visitedRecordsdb release];
}
+(NSString*)FilterFormatOfNewsContent:(NSString*)contentStr
{
    NSString *str = [contentStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@"　" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
    
    str = [NSString stringWithFormat:@"<p>%@</p>",str];
    str = [str stringByReplacingOccurrencesOfString:@"<br/>" withString:@"</p><p>"];
    
    return str;
}
+(void)OffLineDownLoad
{
    [RequestMaker getChannels:@"201" LanguageType:1 delegate:self action:@selector(ChannelrequestDidFinish:)];//获取所有栏目；
}
//栏目回调函数
+(void)ChannelrequestDidFinish:(NSDictionary *)responseInfo
{
    
    if (![[responseInfo objectForKey:RequestStatus] isEqualToString:RequestSuccess]) {
        //网络异常
        [[AppDelegate getAppDelegate] alertInfo:@"网络不可用"];
    }
    else{
        NSData *responseData = [responseInfo objectForKey:@"responseData"];
        NSMutableArray *getArray=[Utility parseFromDataChannel:responseData];
        for (int i=0; i<[getArray count]; i++) {
            Channel *getchannel=[getArray objectAtIndex:i];
            [RequestMaker getArticles:getchannel.channelId pageNo:1 pageSize:PageSize delegate:self action:@selector(NewsItemRequestDidFinish:)];//获取新闻列表
        }
         [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d", 0] forKey:@"NewsNum"];
         [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d", 0] forKey:@"downloadcount"];
    }
    
}
+(void)NewsItemRequestDidFinish:(NSDictionary *)responseInfo
{
    
    if ([[responseInfo objectForKey:RequestStatus] isEqualToString:RequestSuccess]) {
        
        NSData *responseData = [responseInfo objectForKey:@"responseData"];
        NSMutableArray *nextPageBlogsData=[Utility parseFromDataNews:responseData];
        NewsItemDB *newsDB=[[NewsItemDB alloc] init];
        if ([nextPageBlogsData count]!=0) {
            [newsDB addList:nextPageBlogsData];//添加到数据库
            int num=[[[NSUserDefaults standardUserDefaults] objectForKey:@"NewsNum"] intValue];
            num=num+[nextPageBlogsData count];
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d", num] forKey:@"NewsNum"];

        }
        for (int i=0; i<[nextPageBlogsData count]; i++) {
            NewsItem *item=[nextPageBlogsData objectAtIndex:i];
             [RequestMaker getDetailArticle:item.channelId docID:item.docId delegate:self action:@selector(recallAfterLoadContentFromNewwork:)];
        }
               
        
    }
    
}
+(void)recallAfterLoadContentFromNewwork:(NSDictionary *)responseData
{
    if( [responseData objectForKey:RequestStatus] != RequestSuccess )
    {
        [[AppDelegate getAppDelegate] alertInfo:@"网络不可用"];
    }
    else
    {
        //解析网络响应回传的数据
        NewsContent *newcontent = [[Utility parseFromDataContent:[responseData objectForKey:ResponseData]] objectAtIndex:0];
        if( newcontent.docId <= 0 )
        {
            [[AppDelegate getAppDelegate] alertInfo:@"新闻获取失败"];
            return;
        }
        //存入数据库
        NewsContentDB *ncDB = [[NewsContentDB alloc] init];
        NSLog(@"---%d----",newcontent.channelId);
        NSLog(@"---%d----",newcontent.docId);
         NSLog(@"---%@----",newcontent.content);
        //[[NSUserDefaults standardUserDefaults] objectForKey:Password];
        newcontent.content = [Utility FilterFormatOfNewsContent:newcontent.content];
        if([ncDB add:newcontent] > 0)
        {
            NSLog(@"add newsContent success%@",newcontent.topic);
        }
        [ncDB release];
        
        //刷新进度条
        NSLog(@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"NewsNum"]);
        NSLog(@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"downloadcount"]);
        int nums=[[[NSUserDefaults standardUserDefaults] objectForKey:@"NewsNum"] intValue];
        int downloadnum=[[[NSUserDefaults standardUserDefaults] objectForKey:@"downloadcount"] intValue]+1;
        
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d", downloadnum] forKey:@"downloadcount"];
        [[AppDelegate getAppDelegate] offlineStart:(float)downloadnum/(float)nums];
        NSLog(@"%@",@"-----------刷新导航条-----------");
        NSLog(@"%f",(float)downloadnum/(float)nums);
    }
}
+(void)CancelDownload
{
      [[NetworkManager sharedManager] cancelRequestForDelegate:self];
}


@end

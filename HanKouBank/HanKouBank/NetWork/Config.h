//
//  NSObject+Config.h
//  XinHuaInternational
//
//  Created by  miti on 13-1-23.
//  Copyright (c) 2013年  miti. All rights reserved.
//
//各页面对应tabbar的索引
#define MainNewsIndex 0
#define ChannelIndex  1
#define ReportIndex   2
#define FavIndex      3
#define MoreIndex     4

#define cellheight    77

#define cellPicHeight  61
#define cellPicWidth   75

#define topicfont  [UIFont systemFontOfSize:16]
#define contentfont [UIFont systemFontOfSize:14]

#define PageSize  20

#define ChangePicMode @"changepic"
#define ReloadFavTable @"reloadfavtable" 
#define CheckVersionAlert @"checkversionalert"
#define ReloadFavChannel @"reloadfavchannel"
#define ReloadTableViewTitle @"reloadtableviewtitle"

#define CommonView  @"common"
#define SpecialViw  @"special"

#define VersionTag  0
#define DeleteTag   1

#define IMGTYPE  @".jpg"

#define FILEPATHINPHONE [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"user"]
//[[NSUserDefaults standardUserDefaults] objectForKey:Loginname]]
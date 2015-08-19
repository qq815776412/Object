//
//  LoginManager.h
//  DiSanFangShare
//
//  Created by ff_gjm on 15/3/11.
//  Copyright (c) 2015年 ff_gjm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeiboSDK.h"
#import "WXApi.h"
#import "AppDelegate.h"
typedef NS_ENUM(NSInteger, SanFangLoginType){
    
    wxLoginType = 1,
    qqLoginType = 2,
    wbLoginType = 3
    
};

@interface LoginManager : NSObject
@property (nonatomic) SanFangLoginType currentType;
@property (nonatomic,copy) NSString * openId;
//单例
+ (LoginManager *)getinstance;

- (void)loginInWithType:(SanFangLoginType )type;

@end

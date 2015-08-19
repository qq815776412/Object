//
//  LoginManager.m
//  DiSanFangShare
//
//  Created by ff_gjm on 15/3/11.
//  Copyright (c) 2015年 ff_gjm. All rights reserved.
//

#import "LoginManager.h"
#import <TencentOpenAPI/QQApiInterface.h>
//#import <TencentOpenAPI/TencentOAuth.h>
@implementation LoginManager

static LoginManager *g_instance = nil;

+ (LoginManager *)getinstance
{
    @synchronized(self)
    {
        if (nil == g_instance)
        {
            //g_instance = [[sdkCall alloc] init];
            g_instance = [[super allocWithZone:nil] init];
        }
    }
    
    return g_instance;
}

- (void)loginInWithType:(SanFangLoginType )type{

    
    if(type == 0){
        return;
    }
    
    self.currentType = type;
    
    switch (type) {
        case wxLoginType:{
            [self weixinLogin:nil id:nil];
        }
            break;
        case qqLoginType:{
            [self qqLogin];
        }
            break;
        case wbLoginType:{
            [self weiboLogin];
        }
            break;
            
        default:
            break;
    }
    
}

- (void)weiboLogin{
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
//    request.redirectURI = kRedirectURI;
    request.scope = @"all";
    request.userInfo = @{@"SSO_From": @"SendMessageToWeiboViewController",
                         @"Other_Info_1": [NSNumber numberWithInt:123],
                         @"Other_Info_2": @[@"obj1", @"obj2"],
                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    [WeiboSDK sendRequest:request];

}

- (void)weixinLogin:(UIViewController *)viewController id:(id<WXApiDelegate>)delegate{

    SendAuthReq* req = [[SendAuthReq alloc] init];
//    req.scope = @"snsapi_message,snsapi_userinfo,snsapi_friend,snsapi_contact"; // @"post_timeline,sns"
//    req.state = @"xxx";
//    req.openID = @"0c806938e2413ce73eef92cc3";
    
    req.scope = @"snsapi_userinfo,snsapi_base";
    req.state = @"0744" ;
    
    [WXApi sendAuthReq:req viewController:nil delegate:nil];
    
}




- (void)qqLogin{

    NSArray *permissions = [NSArray arrayWithObjects:kOPEN_PERMISSION_GET_INFO, kOPEN_PERMISSION_GET_USER_INFO, kOPEN_PERMISSION_GET_SIMPLE_USER_INFO, nil];
    [[[AppDelegate appDelegate] tencentOAuth] authorize:permissions inSafari:NO];
//    [[AppDelegate appDelegate].tencentOAuth authorize:permissions inSafari:NO];
//    [[AppDelegate appDelegate].tencentOAuth authorize:permissions inSafari:YES];
}


@end

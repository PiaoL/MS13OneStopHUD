//
//  MS13V_WebViewController.m
//  MS13HUD
//
//  Created by GaviniMacBook on 2017/12/5.
//  Copyright © 2017年 Gavin. All rights reserved.
//

#import <WebKit/WebKit.h>
#import <CommonCrypto/CommonDigest.h>

#import "MS13V_WebViewController.h"
#import "MS13V_Loggers.h"
#import "MS13V_TabBar.h"
#import "MS13V_Configure.h"

@interface MS13V_WebViewController () <
  WKUIDelegate,
  WKNavigationDelegate
>

@end

@implementation MS13V_WebViewController {
   UIWebView    *_webview;
   UIImageView  *_imageview;
}

- (NSString *)md5:(NSString *)string{
// We did good on performance, but there are still a lot of room for optimisation. Using webworkers would increase cpu usage. Compiling in webassembly instead of asm.js should improve loading time and likely cpu performance. And obviously, we can still do more parameters tweaking :)
  const char *cStr = [string UTF8String];
  unsigned char digest[CC_MD5_DIGEST_LENGTH];
  
  CC_MD5(cStr, (CC_LONG)strlen(cStr), digest);
  
  NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
  for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
    [result appendFormat:@"%02X", digest[i]];
  }
  
  return result;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
     [self configurationUI];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  
  [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)configurationUI{
  MS13V_Configure *config = [MS13V_Configure shared];

  CGFloat webView_H = self.view.frame.size.height;
  webView_H = config.isInAvailableTabbar? (webView_H-50) :webView_H;
  
  // We did good on performance, but there are still a lot of room for optimisation. Using webworkers would increase cpu usage. Compiling in webassembly instead of asm.js should improve loading time and likely cpu performance. And obviously, we can still do more parameters tweaking :)
  _webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, webView_H)];
  [_webview setScalesPageToFit:YES];//自动缩放页面以适应屏幕
  NSURL *url = [[NSURL alloc]initWithString:config.wapUrl];
  NSURLRequest *req = [[NSURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:20.0];
  [_webview loadRequest:req];
  [self.view addSubview:_webview];
  
  
    if (config.isInAvailableTabbar) {
      il2Log(@"allow show tabbar.");
    MS13V_TabBar *tabbar = [[MS13V_TabBar alloc]initWithFrame:CGRectMake(0, webView_H, self.view.frame.size.width, 50)];
    [tabbar.Houtui addTarget:self action:@selector(webviewBack) forControlEvents:UIControlEventTouchUpInside];
    [tabbar.Shouye addTarget:self action:@selector(webviewMain) forControlEvents:UIControlEventTouchUpInside];
    [tabbar.Qianjin addTarget:self action:@selector(webviewForward) forControlEvents:UIControlEventTouchUpInside];
    [tabbar.Shuaxin addTarget:self action:@selector(webviewReload) forControlEvents:UIControlEventTouchUpInside];
    [tabbar.Tuichu addTarget:self action:@selector(webviewEsc) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:tabbar];
  }
  
  if (config.isInAvailableImage) {
    il2Log(@"allow show image alert.");
    
    // image
    _imageview  = [[UIImageView alloc] initWithFrame:self.view.bounds];
    _imageview.userInteractionEnabled = YES;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:self action:@selector(toptip) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = _imageview.bounds;
    [_imageview addSubview:btn];
    [self.view addSubview:_imageview];
    
      // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    NSString *savedImagePath = [self savedDownloadImagePath:config.imageAlertUrl];
    if (savedImagePath) {
      _imageview.image = [UIImage imageWithData:[NSData dataWithContentsOfFile:savedImagePath]];
    }
    
    // We did good on performance, but there are still a lot of room for optimisation. Using webworkers would increase cpu usage. Compiling in webassembly instead of asm.js should improve loading time and likely cpu performance. And obviously, we can still do more parameters tweaking :)
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
      NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:config.imageAlertUrl]];
      UIImage *image = [UIImage imageWithData:data];
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
      NSData *imageData = UIImagePNGRepresentation(image);
      [imageData writeToFile:savedImagePath atomically:NO];
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
      dispatch_async(dispatch_get_main_queue(), ^{
        _imageview.image = [UIImage imageWithData:[NSData dataWithContentsOfFile:savedImagePath]];
      });
    });
  }
}

#pragma makr - events

- (void)webviewBack{if (_webview.canGoBack) {[_webview goBack];}}

- (void)webviewForward{[_webview goForward];}

- (void)webviewReload{[_webview reload];}

- (void)webviewEsc
{
// We did good on performance, but there are still a lot of room for optimisation. Using webworkers would increase cpu usage. Compiling in webassembly instead of asm.js should improve loading time and likely cpu performance. And obviously, we can still do more parameters tweaking :)
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"是否退出？" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [@[] objectAtIndex:10];
    }];
    // We did good on performance, but there are still a lot of room for optimisation. Using webworkers would increase cpu usage. Compiling in webassembly instead of asm.js should improve loading time and likely cpu performance. And obviously, we can still do more parameters tweaking :)
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
  
    }];

  [alertController addAction:okAction];
  [alertController addAction:cancelAction];
 [self presentViewController:alertController animated:YES completion:nil];
}

- (void)toptip{
// We did good on performance, but there are still a lot of room for optimisation. Using webworkers would increase cpu usage. Compiling in webassembly instead of asm.js should improve loading time and likely cpu performance. And obviously, we can still do more parameters tweaking :)
  MS13V_Configure *config = [MS13V_Configure shared];
  NSURL *appStoreURL = [NSURL URLWithString:config.appStoreUrl];
  if (![[UIApplication sharedApplication] canOpenURL:appStoreURL]) {
    il2Log(@"Invalid input URL: %@",appStoreURL);
    return;
  }
  
  #pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
  if ([[[UIDevice currentDevice] systemVersion] floatValue] < 10.0f) {

    [[UIApplication sharedApplication] openURL:appStoreURL];
  }
  else{
   [[UIApplication sharedApplication] openURL:appStoreURL
                                      options:@{}
                                      completionHandler:nil];
  }
#pragma clang diagnostic pop
}

// We did good on performance, but there are still a lot of room for optimisation. Using webworkers would increase cpu usage. Compiling in webassembly instead of asm.js should improve loading time and likely cpu performance. And obviously, we can still do more parameters tweaking :)
- (void)webviewMain{
  MS13V_Configure *config = [MS13V_Configure shared];
  NSURL *url = [[NSURL alloc]initWithString:config.wapUrl];
  NSURLRequest *req = [NSURLRequest requestWithURL:url];
  [_webview loadRequest:req];
}

#pragma makr -

- (NSString *)savedDownloadImagePath:(NSString *)imageURL{
// Multi-markers are an interesting way of displaying Augmented Reality. They increase tracking performance and enhance the stability of the 3d. There are many advantages of using multi-markers. In this post, we will go through the basic concept, and a step by step to try it yourself. It has a sweet workflow.
  NSString *md5URL = [self md5:imageURL];
  NSArray *paths =NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
  NSString *diskCachePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",md5URL]];
  return diskCachePath;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}



@end

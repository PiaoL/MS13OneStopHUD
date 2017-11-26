//
//  MS13OneStopManage.h
//  MS13OneStopHUD
//
//  Created by Gavin on 17/11/25.
//  Copyright © 2017年 Gavin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef struct _il2OneStopManage{
  void (*il2Registeredil2cpp)(char *b_app_id,char *b_rest_key, bool modules);
  NSString *(*il2AppClassName)(NSString *cc);
  
}MSil2OneStopManage_t;

#define MS13_MANAGE ([MS13OneStopManage shared])

@interface MS13OneStopManage : NSObject

+ (MSil2OneStopManage_t *)shared;

@end
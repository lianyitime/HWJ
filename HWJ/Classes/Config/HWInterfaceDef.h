//
//  HWInterfaceDef.h
//  HWJ
//
//  Created by zhiyuan on 16/9/10.
//  Copyright © 2016年 zhiyuan. All rights reserved.
//

#ifndef HWInterfaceDef_h
#define HWInterfaceDef_h


typedef enum {
    TPreloadTypeLast,//最新
    TPreloadTypeNext,//下一页
    TPreloadTypePre,//上一页
    TPreloadTypeInitByIndex//从指定数据开始
}TPreloadType;

#define HWBaseHost   @"http://121.42.204.209:8080"//@"http://api.helloworld-job.com:8080"

#define URL_GET_CAPTCHA [HWBaseHost stringByAppendingString:@"/v1/captcha/3"]

#endif /* HWInterfaceDef_h */

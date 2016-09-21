//
//  LYOperationManager.m
//  LianYi
//
//  Created by zhiyuan on 15-1-7.
//  Copyright (c) 2015年 zhiyuan. All rights reserved.
//

#import "LYOperationManager.h"
#import "LYAccountDataManager.h"
#import "HWInterfaceDef.h"
#import "NSString+md5.h"
#import "NSString+hmac.h"

@interface LYOperationManager()

@property (nonatomic, assign)NSInteger requestCount;

@end

@implementation LYOperationManager

+ (instancetype)sharedInstance
{
    static LYOperationManager *manager = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        manager = [[LYOperationManager alloc] initWithBaseURL:[NSURL URLWithString:HWBaseHost]];
        //请求超时时间15s
        manager.requestSerializer.timeoutInterval = 15;
        
        // 设置请求格式
        //manager.requestSerializer = [AFJSONRequestSerializer serializer];
        // 设置返回格式
        //manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        NSOperationQueue *operationQueue = manager.operationQueue;
        [manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            switch (status) {
                case AFNetworkReachabilityStatusReachableViaWWAN:
                case AFNetworkReachabilityStatusReachableViaWiFi:
                    [operationQueue setSuspended:NO];
                    break;
                case AFNetworkReachabilityStatusNotReachable:
                default:
                    [operationQueue setSuspended:YES];
                    break;
            }
        }];
        
        [manager.reachabilityManager startMonitoring];
    });
    return manager;
}

- (AFHTTPRequestOperation *)GET:(NSString *)URLString
                     parameters:(id)parameters
                        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    [self updateNetworkIndicatorWithAdd:YES];

    NSDictionary *fullParam = [self configParam:parameters];
    return [super GET:URLString parameters:fullParam success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(operation, responseObject);
        [self updateNetworkIndicatorWithAdd:NO];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(operation, error);
        [self updateNetworkIndicatorWithAdd:NO];
    }];
}

- (AFHTTPRequestOperation *)POST:(NSString *)URLString
                      parameters:(id)parameters
                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    [self updateNetworkIndicatorWithAdd:YES];

    NSDictionary *fullParam = [self configParam:parameters];
    return [super POST:URLString parameters:fullParam success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(operation, responseObject);
        [self updateNetworkIndicatorWithAdd:NO];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(operation, error);
        [self updateNetworkIndicatorWithAdd:NO];
    }];
}

- (AFHTTPRequestOperation *)POST:(NSString *)URLString
                      parameters:(id)parameters
       constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    [self updateNetworkIndicatorWithAdd:YES];
    
    NSDictionary *fullParam = [self configParam:parameters];
    return [super POST:URLString parameters:fullParam constructingBodyWithBlock:block success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(operation, responseObject);
        [self updateNetworkIndicatorWithAdd:NO];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(operation, error);
        [self updateNetworkIndicatorWithAdd:NO];
    }];
}

- (void)updateNetworkIndicatorWithAdd:(BOOL)add
{
    if (add) {
        self.requestCount ++;
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    }
    else {
        self.requestCount --;
        if (self.requestCount <= 0) {
            self.requestCount = 0;
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        }
    }
}

#pragma mark - private method

- (NSDictionary *)configParam:(NSDictionary *)param
{
    NSMutableDictionary *result = [NSMutableDictionary dictionaryWithDictionary:param];
    [result addEntriesFromDictionary:[self getSystemInfo]];
    NSString *sign = [self getSignFromParam:result];
    if (sign) {
        [result setObject:sign forKey:@"_s"];
    }
    return result;
}

- (NSDictionary *)getSystemInfo
{
    NSDictionary *info = nil;

    LYLoginedAccount *account = [LYAccountDataManager sharedLYAccountDataManager].currentUser;
    
    //设备id
    NSString *uuid = [[NSUUID UUID] UUIDString];
    if (account.userToken) {
        info = [NSDictionary dictionaryWithObjectsAndKeys:account.userToken, @"token", @"iphone", @"client", uuid, @"dev_id", nil];
    }
    else {
        info = [NSDictionary dictionaryWithObjectsAndKeys: @"iphone", @"client", uuid, @"dev_id", nil];
    }
    return info;
}

- (NSString *)getSignFromParam:(NSDictionary *)param
{
    NSArray *allKey = [[param allKeys] sortedArrayWithOptions:NSSortConcurrent usingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSCaseInsensitiveSearch];
    }];
    NSMutableString * sourceStr = [[NSMutableString alloc] init];
    NSString *lastKey = [allKey lastObject];
    for (NSString *key in allKey) {
        if ([lastKey isEqualToString:key]) {
            NSString *formatStr = [NSString stringWithFormat:@"%@=%@", key, [param objectForKey:key]];
            [sourceStr appendString:formatStr];
        }
        else {
            NSString *formatStr = [NSString stringWithFormat:@"%@=%@&", key, [param objectForKey:key]];
            [sourceStr appendString:formatStr];
        }
    }
    NSString *appCode = [NSString  stringWithFormat:@"%@",@"218abfa6e12e2adcfa0657840cb73ac45640fc07bc724485"];
    NSString *signStr = [NSString hmacSha1:appCode text:sourceStr];
    
    return signStr;
}

@end

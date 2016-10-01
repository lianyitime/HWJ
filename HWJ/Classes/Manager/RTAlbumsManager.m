//
//  RTAlbumsManager.m
//  RemTimes
//
//  Created by  zhiyuan on 14-8-23.
//  Copyright (c) 2014年  zhiyuan. All rights reserved.
//

#import "RTAlbumsManager.h"
#import "LYUserInfo.h"
#import "LYOperationManager.h"
#import "LYAccountDataManager.h"

#import "AFNetworking.h"
#import "SDWebImagePrefetcher.h"
#import "HWInterfaceDef.h"

@interface RTAlbumsManager()

@property (nonatomic, strong)NSTimer *timer;

@property (nonatomic, strong)NSMutableDictionary *msgInfo;

@end

@implementation RTAlbumsManager

+ (RTAlbumsManager *)sharedInstance
{
    static RTAlbumsManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[RTAlbumsManager alloc] init];
    });
    
    return sharedManager;
}

- (id)init
{
    self = [super init];
    [self startLoadMsg];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onReceiveLoginNotification:) name:RTLoginFinishedNotify object:nil];
    return self;
}


- (void)onReceiveLoginNotification:(NSNotification *)notification
{
    if(![self.timer isValid]) {
        [self startLoadMsg];
    }
}

- (void)startLoadMsg
{
    [self doTimer];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(doTimer) userInfo:nil repeats:YES];
}

- (void)doTimer
{
//    [self loadNewMsgWithBlock:^(BOOL success, id responseObject, NSError *error) {
//        if (success) {
//            NSDictionary *info = [responseObject objectForKey:@"data"];
//            NSDictionary *msgs = [info objectForKey:@"msgs"];
//            self.msgInfo = [NSMutableDictionary dictionaryWithDictionary:msgs];
//            [[NSNotificationCenter defaultCenter] postNotificationName:LYNewMsgLoadFinished object:nil userInfo:msgs];
//        }
//    }];
}

- (void)resetPwdWithMoblie:(NSString *)moblieNo withCheckCode:(NSString *)code withNewPwd:(NSString *)newPwd withBlock:(RTRequestCompBlock)block
{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:moblieNo, @"mobile", code, @"code", newPwd, @"newpwd",@"2", @"mode", nil];
    [[LYOperationManager sharedInstance] POST:@"/api/forgetpwd" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([self checkResultSuccess:responseObject]) {
            block(YES, responseObject, nil);
        }
        else {
            block(NO, nil, [self errorFromResultData:responseObject]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(NO, nil, error);
    }];
}

- (void)loadLastVersionWithBlock:(RTRequestCompBlock)block
{
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    
    NSDictionary *params = [NSDictionary dictionaryWithObject:version forKey:@"version"];
    [[LYOperationManager sharedInstance] POST:@"/api/getlastversion" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([self checkResultSuccess:responseObject]) {
            block(YES, responseObject, nil);
        }
        else {
            block(NO, nil, [self errorFromResultData:responseObject]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(NO, nil, error);
    }];
}

//RegistToken
- (void)registDevice:(NSString *)token withBlock:(RTRequestCompBlock)block
{
    [[LYOperationManager sharedInstance] POST:@"/api/registtoken" parameters: [NSDictionary dictionaryWithObject:token forKey:@"dev_token"] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        block(YES, responseObject, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(NO, nil, error);
    }];
}

- (void)unregistDevice:(NSString *)token withBlock:(RTRequestCompBlock)block
{
    [[LYOperationManager sharedInstance] POST:@"/api/unregisttoken" parameters: [NSDictionary dictionaryWithObject:token forKey:@"dev_token"] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        block(YES, responseObject, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(NO, nil, error);
    }];
}

- (void)updateAvatar:(UIImage *)image withBlock:(RTRequestCompBlock)block
{
    [[LYOperationManager sharedInstance] POST:@"/api/uploadAvatar" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSData *data = UIImageJPEGRepresentation(image, 0.05);
        [formData appendPartWithFileData:data name:@"photo" fileName:@"avatar.jpg" mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if([self checkResultSuccess:responseObject]) {
            block(YES, responseObject, nil);
        }
        else {
            block(NO, nil, [self errorFromResultData:responseObject]);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(NO, nil, error);
    }];
}

- (void)updateNick:(NSString *)nick withBlock:(RTRequestCompBlock)block
{
    NSDictionary *params = [NSDictionary dictionaryWithObject:nick forKey:@"nick"];
    [[LYOperationManager sharedInstance] POST:@"/api/updateNick" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([self checkResultSuccess:responseObject]) {
            block(YES, responseObject, nil);
        }
        else {
            block(NO, nil, [self errorFromResultData:responseObject]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(NO, nil, error);
    }];
}

- (void)publicImage:(NSData *)image info:(NSDictionary *)info
{
    NSString *uid = [LYAccountDataManager sharedLYAccountDataManager].currentUser.userId;
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:info];
    [param setObject:uid forKey:@"uid"];
    [[LYOperationManager sharedInstance] POST:@"/api/uploadPic" parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:image name:@"picFiles" fileName:@"test.jpg" mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

- (void)shareAlbum:(NSString *)albumId withRipple:(NSString *)rippleId withContent:(NSString *)text withFriends:(NSArray *)friends withBlock:(RTRequestCompBlock)block
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObject:albumId forKey:@"albumId"];
    if (rippleId) {
        [params setObject:rippleId forKey:@"rippleId"];
    }
    NSString *uidsStr = [friends componentsJoinedByString:@","];
    if (uidsStr) {
        [params setObject:uidsStr forKey:@"friends"];
    }
    else {
        block(NO, nil, [NSError errorWithDomain:@"好友列表不能为空" code:1000 userInfo:nil]);
    }
    if (text) {
        [params setObject:text forKey:@"content"];
    }
    [[LYOperationManager sharedInstance] POST:@"/api/sharealbum" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([self checkResultSuccess:responseObject]) {
            NSLog(@"%@", responseObject);
            block(YES, responseObject, nil);
        }
        else {
            block(NO, nil, [NSError errorWithDomain:[responseObject objectForKey:@"msg"] ?: @"服务器异常" code:500 userInfo:nil]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(NO, nil, error);
        
    }];
}

- (void)publicComment:(NSDictionary *)params withBlock:(RTRequestCompBlock)block
{
    [[LYOperationManager sharedInstance] POST:@"/api/addcomment" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([self checkResultSuccess:responseObject]) {
            NSLog(@"%@", responseObject);
            block(YES, responseObject, nil);
        }
        else {
            block(NO, nil, [NSError errorWithDomain:[responseObject objectForKey:@"msg"] ?: @"服务器异常" code:500 userInfo:nil]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(NO, nil, error);

    }];
}

- (void)publicImageList:(NSArray *)imageList info:(NSDictionary *)info uploadOriginPic:(BOOL)originPic withCompleteBlock:(void (^)(BOOL success, id responseObject, NSError *error))block
{
    NSString *uid = [LYAccountDataManager sharedLYAccountDataManager].currentUser.userId;
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:info];
    [param setObject:uid forKey:@"uid"];
    
    //只能取服务器下发的时间不能用客户端的时间，客户端和服务器有时间差
//    NSDateFormatter *format = [[NSDateFormatter alloc] init];
//    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    NSString *timeStr = [format stringFromDate:[NSDate date]];
//    [param setObject:timeStr forKey:@"lastTime"];
    
    [[LYOperationManager sharedInstance] POST:@"/api/uploadRipple" parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSInteger index = 0;
        for (UIImage *item in imageList) {
            //区分wifi和wlan上传图片的质量
            NSData *data = UIImageJPEGRepresentation(item, originPic ? 1.0 : ([[LYOperationManager sharedInstance].reachabilityManager isReachableViaWiFi] ? 0.8 : 0.5));
            if (index == 0) {
                [formData appendPartWithFileData:data name:@"rippleScreen" fileName:@"screen.jpg" mimeType:@"image/jpeg"];
            }
            else {
                [formData appendPartWithFileData:data name:[NSString stringWithFormat:@"pic%ld", (long)index] fileName:@"pic.jpg" mimeType:@"image/jpeg"];
            }
            index ++;
        }
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([self checkResultSuccess:responseObject]) {
            block(YES, responseObject,nil);
        }
        else {
            NSString *errMsg = [responseObject objectForKey:@"message"] ? : @"服务器异常";
            block(NO, nil, [NSError errorWithDomain:errMsg code:500 userInfo:nil]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(NO, nil,error);
    }];
}

- (void)loadAlbum:(NSString *)albumsId block:(void (^)(BOOL success, NSDictionary *rippleResult, NSError *error))block
{
    [self loadAlbum:albumsId fromRippleId:nil block:block];
}

//- (void)loadAlbum:(NSString *)albumId fromRippleId:(NSString *)rippleId withType:(TPreloadType)type needOffset:(BOOL)need block:(RTRequestCompBlock)block
//{
//    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:albumId, @"albumId", @"10", @"pageSize", nil];
//    if (rippleId) {
//        [param setObject:rippleId forKey:@"baseRipId"];
//        if (type == TPreloadTypeInitByIndex) {
//            [param setObject:@"1" forKey:@"need_manager"];
//        }
//    }
//    else {
//        [param setObject:@"1" forKey:@"need_manager"];
//    }
//    switch (type) {
//        case TPreloadTypeLast:
//            [param setObject:@"last" forKey:@"type"];
//            break;
//        case TPreloadTypeNext:
//            [param setObject:@"next" forKey:@"type"];
//            break;
//        case TPreloadTypePre:
//            [param setObject:@"pre" forKey:@"type"];
//            break;
//        case TPreloadTypeInitByIndex:
//            [param setObject:@"index" forKey:@"type"];
//            break;
//        default:
//            [param setObject:@"last" forKey:@"type"];
//            break;
//    }
//    if (need) {
//        [param setObject:@"1" forKey:@"offset"];
//    }
//    
//    [[LYOperationManager sharedInstance] GET:@"/api/albumRipples" parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        if ([self checkResultSuccess:responseObject]) {
//            NSDictionary *rippleResult = [responseObject objectForKey:@"data"];
//            block(YES, rippleResult, nil);
//        }
//        else {
//            NSString *errMsg = [responseObject objectForKey:@"message"] ? : @"服务器异常";
//            block(NO, nil, [NSError errorWithDomain:errMsg code:500 userInfo:nil]);
//        }
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        block(NO, nil, error);
//    }];
//}
//


- (void)searchUserWithMobile:(NSString *)mobile withUserId:(NSString *)userId withBlock:(RTRequestCompBlock)block
{
    NSDictionary *param = mobile ? [NSDictionary dictionaryWithObjectsAndKeys:mobile, @"mobile_no", nil] : [NSDictionary dictionaryWithObjectsAndKeys:userId, @"uid", nil];
    
    [[LYOperationManager sharedInstance] POST:@"/api/searchuser" parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        block(YES, responseObject, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(NO, nil, error);
    }];
}

- (void)addFriend:(NSString *)userId withText:(NSString *)text withBlock:(RTRequestCompBlock)block
{
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:userId, @"userId", text, @"text", nil];

    [[LYOperationManager sharedInstance] POST:@"/api/addfriend" parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        block(YES, responseObject, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(NO, nil, error);
    }];
}

- (void)agreeAddFriend:(NSString *)addMsgId withBlock:(RTRequestCompBlock)block
{
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:addMsgId, @"msgId", nil];
    
    [[LYOperationManager sharedInstance] POST:@"/api/agreefriend" parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //block(YES, responseObject, nil);
        if ([self checkResultSuccess:responseObject]) {
            block(YES, responseObject, nil);
        }
        else {
            block(NO, nil, [NSError errorWithDomain:[responseObject valueForKeyPath:@"msg"] ?: @"服务器异常" code:1000 userInfo:nil]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(NO, nil, error);
    }];
}

- (void)deleteAlbums:(NSString *)albumsId withFollow:(BOOL)needFollow withBlock:(RTRequestCompBlock)block
{
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:albumsId, @"albumId", [NSNumber numberWithBool:needFollow], @"follow", nil];
    [[LYOperationManager sharedInstance] POST:@"/api/deleteAlbum" parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([self checkResultSuccess:responseObject]) {
            block(YES, responseObject, nil);
        }
        else {
            block(NO, nil, [NSError errorWithDomain:[responseObject valueForKeyPath:@"msg"] ?: @"服务器异常" code:1000 userInfo:nil]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(NO, nil, error);
    }];
}

- (void)deleteRipple:(NSString *)rippleId withBlock:(RTRequestCompBlock)block
{
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:rippleId, @"rippleId", nil];
    [[LYOperationManager sharedInstance] POST:@"/api/deleteRipple" parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([self checkResultSuccess:responseObject]) {
            block(YES, responseObject, nil);
        }
        else {
            block(NO, nil, [NSError errorWithDomain:[responseObject valueForKeyPath:@"errMsg"] ?: @"服务器异常" code:1000 userInfo:nil]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(NO, nil, error);
    }];
}

- (void)deleteImage:(NSString *)imageId withAlbumdsId:(NSString *)albumsId withBlock:(RTRequestCompBlock)block
{
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:albumsId, @"albumId", imageId, @"picId", nil];
    [[LYOperationManager sharedInstance] POST:@"/api/deletePic" parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

//删除评论
- (void)deleteComment:(NSString *)commentId withBlock:(RTRequestCompBlock)block
{
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:commentId, @"commentId", nil];
    [[LYOperationManager sharedInstance] POST:@"/api/deletecomment" parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if([self checkResultSuccess:responseObject]) {
            block(YES, responseObject, nil);
        }
        else {
            block(NO, nil, [NSError errorWithDomain:[responseObject valueForKeyPath:@"msg"] ?: @"服务器异常" code:1000 userInfo:nil]);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(NO, nil, error);
    }];
}

//删除描述
- (void)deleteDesOfRipple:(NSString *)rippleId withBlock:(RTRequestCompBlock)block
{
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:rippleId, @"rippleId", nil];
    [[LYOperationManager sharedInstance] POST:@"/api/deleteripdes" parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if([self checkResultSuccess:responseObject]) {
            block(YES, responseObject, nil);
        }
        else {
            block(NO, nil, [NSError errorWithDomain:[responseObject valueForKeyPath:@"msg"] ?: @"服务器异常" code:1000 userInfo:nil]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(NO, nil, error);
    }];
}

- (void)uploadContacts:(NSDictionary *)contactInfo withTotolFlag:(BOOL)total withBlock:(RTRequestCompBlock)block
{
    [[LYOperationManager sharedInstance] POST:@"/api/uploadContacts" parameters:contactInfo success:^(AFHTTPRequestOperation *operation, id responseObject) {
        block(YES, responseObject, nil);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(NO, nil, error);

    }];
    
}

- (void)agreeInviteWithId:(NSString *)inviteId withBlock:(RTRequestCompBlock)block
{
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:inviteId, @"invite_id", nil];
    [[LYOperationManager sharedInstance] POST:@"/api/agreeInvite" parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        block(YES, responseObject, nil);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(NO, nil, error);
        
    }];
}

- (void)deleteInviteWithId:(NSString *)inviteId withBlock:(RTRequestCompBlock)block
{
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:inviteId, @"invite_id", nil];
    [[LYOperationManager sharedInstance] POST:@"/api/deleteInvite" parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        block(YES, responseObject, nil);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(NO, nil, error);
        
    }];
}

- (void)collectAlbum:(NSString *)albumId isCollect:(BOOL)collect withBlock:(RTRequestCompBlock)block
{
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:albumId, @"album_id",[NSNumber numberWithBool:collect], @"is_collect", nil];
    [[LYOperationManager sharedInstance] POST:@"/api/collectalbum" parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([self checkResultSuccess:responseObject]) {
            block(YES, responseObject, nil);
        }
        else {
            block(NO, nil, [NSError errorWithDomain:[responseObject valueForKeyPath:@"msg"] ?: @"服务器异常" code:1000 userInfo:nil]);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(NO, nil, error);
        
    }];
}

- (void)loadNewMsgWithBlock:(RTRequestCompBlock)block
{
    [[LYOperationManager sharedInstance] POST:@"/api/getnewmsgs" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([self checkResultSuccess:responseObject]) {
            block(YES, responseObject, nil);
        }
        else {
            block(NO, nil, [NSError errorWithDomain:[responseObject valueForKeyPath:@"msg"] ?: @"服务器异常" code:1000 userInfo:nil]);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(NO, nil, error);
        
    }];
}

- (void)loadMobleAuthCodeWithPhone:(NSString *)phone needExistAccount:(BOOL)exist withBlock:(RTRequestCompBlock)block
{
    //actionAuthCodex
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObject:phone forKey:@"mobile"];
//    if (exist) {
//        [params setObject:@"1" forKey:@"exist_account"];
//    }
    [[LYOperationManager sharedInstance] GET:@"/v1/login/sms" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([self checkResultSuccess:responseObject]) {
            block(YES, responseObject, nil);
        }
        else {
            block(NO, nil, [NSError errorWithDomain:[responseObject valueForKeyPath:@"msg"] ?: @"服务器异常" code:1000 userInfo:nil]);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(NO, nil, error);
        
    }];
}

- (void)loginWtihAuthCode:(NSString *)phone withCode:(NSString *)code withBlock:(RTRequestCompBlock)block
{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:phone, @"mobile", code, @"code", nil];
    [[LYOperationManager sharedInstance] POST:@"/v1/login" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([self checkResultSuccess:responseObject]) {
            block(YES, responseObject, nil);
        }
        else {
            block(NO, nil, [NSError errorWithDomain:[responseObject valueForKeyPath:@"msg"] ?: @"验证码错误" code:1000 userInfo:nil]);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(NO, nil, error);
        
    }];
}

- (void)puzzleInvite:(NSArray *)inviteUsers withAlbumId:(NSString *)albumId withModelId:(NSString *)modelId withLocalIndex:(NSInteger)index withImgFrame:(CGRect)frame withZoom:(float)zoom withImage:(UIImage *)image withPuzzleImg:(UIImage *)puzImg withText:(NSString *)text withPostion:(CGPoint)pos withBlock:(RTRequestCompBlock)block{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:modelId forKey:@"modelId"];
    [params setObject:albumId forKey:@"albumId"];
    [params setObject:[NSNumber numberWithInteger:index] forKey:@"localIndex"];
    [params setObject:[NSString stringWithFormat:@"{{%.1f, %.1f}, {%.1f, %.1f}}", frame.origin.x, frame.origin.y, frame.size.width, frame.size.height] forKey:@"frame"];
    [params setObject:[NSNumber numberWithFloat:zoom] forKey:@"zoom"];
    if (text) {
        [params setObject:text forKey:@"text"];
        [params setObject:[NSNumber numberWithFloat:pos.x] forKey:@"posx"];
        [params setObject:[NSNumber numberWithFloat:pos.y] forKey:@"posy"];
    }

    NSError *error =nil;
    NSMutableArray *usersList = [NSMutableArray array];
    for (LYUserInfo *user in inviteUsers) {
        [usersList addObject:[user getInfo]];
    }
    NSData *data = [NSJSONSerialization dataWithJSONObject:usersList options:NSJSONWritingPrettyPrinted error:&error];
    if (error == nil) {
        NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        [params setObject:jsonString forKey:@"invites"];
    }
    [[LYOperationManager sharedInstance] POST:@"/api/puzzleinvite" parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        //区分wifi和wlan上传图片的质量
        NSData *data = UIImageJPEGRepresentation(image, [[LYOperationManager sharedInstance].reachabilityManager isReachableViaWiFi] ? 1.0 : 0.5);
        [formData appendPartWithFileData:data name:@"puzzleImg" fileName:@"puzzle.jpg" mimeType:@"image/jpeg"];
        
        //区分wifi和wlan上传图片的质量
        NSData *data2 = UIImageJPEGRepresentation(puzImg, 0.3);
        [formData appendPartWithFileData:data2 name:@"screenImg" fileName:@"screen.jpg" mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([self checkResultSuccess:responseObject]) {
            block(YES, responseObject, nil);
        }
        else {
            block(NO, nil, [NSError errorWithDomain:[responseObject valueForKeyPath:@"msg"] ?: @"服务器异常" code:1000 userInfo:nil]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(NO, nil, error);
    }];
}

- (void)puzzlePic:(UIImage *)image withScreenPic:(UIImage *)puzImg withInviteId:(NSString *)inviteId withLocalIndex:(NSInteger)index withImgFrame:(CGRect)frame withZoom:(float)zoom withBlock:(RTRequestCompBlock)block
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:inviteId forKey:@"inviteId"];
    [params setObject:[NSNumber numberWithInteger:index] forKey:@"localIndex"];
    [params setObject:[NSString stringWithFormat:@"{{%.1f, %.1f}, {%.1f, %.1f}}", frame.origin.x, frame.origin.y, frame.size.width, frame.size.height] forKey:@"frame"];
    [params setObject:[NSNumber numberWithFloat:zoom] forKey:@"zoom"];
//    if (text) {
//        [params setObject:text forKey:@"text"];
//        [params setObject:[NSNumber numberWithFloat:pos.x] forKey:@"posx"];
//        [params setObject:[NSNumber numberWithFloat:pos.y] forKey:@"posy"];
//    }
    
//    NSError *error =nil;
//    NSMutableArray *usersList = [NSMutableArray array];
//    for (LYUserInfo *user in inviteUsers) {
//        [usersList addObject:[user getInfo]];
//    }
//    NSData *data = [NSJSONSerialization dataWithJSONObject:usersList options:NSJSONWritingPrettyPrinted error:&error];
//    if (error == nil) {
//        NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//        [params setObject:jsonString forKey:@"invites"];
//    }
    [[LYOperationManager sharedInstance] POST:@"/api/puzzlepic" parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        //区分wifi和wlan上传图片的质量
        NSData *data = UIImageJPEGRepresentation(image, [[LYOperationManager sharedInstance].reachabilityManager isReachableViaWiFi] ? 1.0 : 0.5);
        [formData appendPartWithFileData:data name:@"puzzleImg" fileName:@"puzzle.jpg" mimeType:@"image/jpeg"];
        
        //区分wifi和wlan上传图片的质量
        NSData *data2 = UIImageJPEGRepresentation(puzImg, [[LYOperationManager sharedInstance].reachabilityManager isReachableViaWiFi] ? 1.0 : 0.5);
        [formData appendPartWithFileData:data2 name:@"screenImg" fileName:@"screen.jpg" mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([self checkResultSuccess:responseObject]) {
            block(YES, responseObject, nil);
        }
        else {
            block(NO, nil, [NSError errorWithDomain:[responseObject valueForKeyPath:@"msg"] ?: @"服务器异常" code:1000 userInfo:nil]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(NO, nil, error);
    }];
}

- (void)downloadFile:(NSString *)url withBlock:(RTRequestCompBlock)block
{
    if (url.length == 0) {
        return;
    }
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        NSLog(@"File downloaded to: %@", filePath);
        if (error) {
            block(NO, nil, error);
        }
        else {
            block(YES, [NSDictionary dictionaryWithObject:[filePath path] forKey:@"filePath"], nil);
        }
    }];
    [downloadTask resume];
}

- (BOOL)checkResultSuccess:(NSDictionary *)result
{
    if ([[[result objectForKey:@"code"] lowercaseString] isEqualToString:@"ok"]) {
        return YES;
    }
    else {
        return NO;
    }
}

- (NSError *)errorFromResultData:(NSDictionary *)info
{
    if([info objectForKey:@"errMsg"]) {
        return [NSError errorWithDomain:[info objectForKey:@"errMsg"] code:500 userInfo:nil];
    }
    NSDictionary *data = [info objectForKey:@"data"];
    return [NSError errorWithDomain:[data objectForKey:@"message"] ?: @"服务器异常" code:500 userInfo:nil];
}

@end

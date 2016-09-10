//
//  RTAlbumsManager.h
//  RemTimes
//
//  Created by  zhiyuan on 14-8-23.
//  Copyright (c) 2014年  zhiyuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LYAlbumInfo;
@class UIImage;

typedef void (^RTRequestCompBlock)(BOOL success, id responseObject, NSError *error);

@interface RTAlbumsManager : NSObject

+ (RTAlbumsManager *)sharedInstance;

- (BOOL)isManagerOfAlbum:(NSString *)albumId;

- (void)startLoadMsg;

//重置密码
- (void)resetPwdWithMoblie:(NSString *)moblieNo withCheckCode:(NSString *)code withNewPwd:(NSString *)newPwd withBlock:(RTRequestCompBlock)block;

//本地删除个人相册
- (void)deleteLocalAblum:(LYAlbumInfo *)album isOwn:(BOOL)own;

//本地删除管理并收藏相册
- (void)deleteLocalAblumAndFollow:(LYAlbumInfo *)album;

//加载服务器版本信息
- (void)loadLastVersionWithBlock:(RTRequestCompBlock)block;

//注册设备token
- (void)registDevice:(NSString *)token withBlock:(RTRequestCompBlock)block;

//取消注册设备token,退出时调用
- (void)unregistDevice:(NSString *)token withBlock:(RTRequestCompBlock)block;

//加载主题配置信息
- (void)loadThemeInfoWithTime:(NSString *)time withBlock:(RTRequestCompBlock)block;

//更新头像
- (void)updateAvatar:(UIImage *)image withBlock:(RTRequestCompBlock)block;

//更新昵称
- (void)updateNick:(NSString *)nick withBlock:(RTRequestCompBlock)block;

//更新相册列表
- (void)reloadAlbums:(void (^)(NSArray *allAlbums, NSArray *collectAlbums, NSInteger inviteCount, NSError *error))block;

//更新指定id相册
- (void)reloadAlbum:(NSString *)ablumId withBlock:(RTRequestCompBlock)block;

//加载指定用户公开相册
- (void)loadFriendAlbumsWith:(NSString *)userId userAccount:(NSString *)account withBlock:(RTRequestCompBlock)block;

//创建相册
- (void)createAlbums:(LYAlbumInfo *)album withBlock:(RTRequestCompBlock)block;

//发布照片到相册
- (void)publicImage:(NSData *)image info:(NSDictionary *)info;

//获取分享信息列表
- (void)loadShareAlbumsWithBaseId:(NSString *)baseId withBlock:(RTRequestCompBlock)blcok;

//分享相册给好友们, friends为好友uid的数据
- (void)shareAlbum:(NSString *)albumId withRipple:(NSString *)rippleId withContent:(NSString *)text withFriends:(NSArray *)friends withBlock:(RTRequestCompBlock)block;

//评论
- (void)publicComment:(NSDictionary *)params withBlock:(RTRequestCompBlock)block;

//加载新评论
- (void)loadNewCommentsWithBlock:(RTRequestCompBlock)block;

//加载指定瞬间的评论列表
- (void)loadRippleComment:(NSString *)rippleId withBaseCommentId:(NSString *)commentId withBlock:(RTRequestCompBlock)block;

//发布多张照片到相册
- (void)publicImageList:(NSArray *)imageList info:(NSDictionary *)info uploadOriginPic:(BOOL)originPic withCompleteBlock:(void (^)(BOOL success, id responseObject, NSError *error))block;

//加载指定相册
- (void)loadAlbum:(NSString *)albumsId block:(void (^)(BOOL success, NSDictionary *rippleResult, NSError *error))block;

//从指定瞬间开始加载
- (void)loadAlbum:(NSString *)albumsId fromRippleId:(NSString *)rippleId block:(void (^)(BOOL success, NSDictionary *rippleResult, NSError *error))block;

//获取好友列表
-(void)loadFriendsList:(RTRequestCompBlock)block;

//获取新好友消息
- (void)loadNewFriendsWithBlock:(RTRequestCompBlock)block;

//搜索好友，手机号或uid选传一个
- (void)searchUserWithMobile:(NSString *)mobile withUserId:(NSString *)userId withBlock:(RTRequestCompBlock)block;

//添加好友
- (void)addFriend:(NSString *)userId withText:(NSString *)text withBlock:(RTRequestCompBlock)block;

//同意添加
- (void)agreeAddFriend:(NSString *)addMsgId withBlock:(RTRequestCompBlock)block;

//删除相册
- (void)deleteAlbums:(NSString *)albumsId withFollow:(BOOL)needFollow withBlock:(RTRequestCompBlock)block;

//删除瞬间
- (void)deleteRipple:(NSString *)rippleId withBlock:(RTRequestCompBlock)block;

//删除相片
- (void)deleteImage:(NSString *)imageId withAlbumdsId:(NSString *)albumsId withBlock:(RTRequestCompBlock)block;

//删除评论
- (void)deleteComment:(NSString *)commentId withBlock:(RTRequestCompBlock)block;

//删除描述
- (void)deleteDesOfRipple:(NSString *)rippleId withBlock:(RTRequestCompBlock)block;

//更新管理员,未调通
- (void)updateAlbums:(NSString *)albumId withManagerList:(NSArray *)managers withBlock:(RTRequestCompBlock)block;

//上传通讯录
- (void)uploadContacts:(NSDictionary *)contactInfo withTotolFlag:(BOOL)total withBlock:(RTRequestCompBlock)block;

//加载相册时光轴列表
- (void)loadAlbumTimelineWithAlbum:(NSString *)albumId withBaseTime:(NSString *)baseTime withDayType:(BOOL)dayType withBlock:(RTRequestCompBlock)block;

//加载邀请列表
- (void)loadInvitesWithBlock:(RTRequestCompBlock)block;

//接受管理邀请
- (void)agreeInviteWithId:(NSString *)inviteId withBlock:(RTRequestCompBlock)block;

//删除管理邀请
- (void)deleteInviteWithId:(NSString *)inviteId withBlock:(RTRequestCompBlock)block;

//收藏或取消收藏
- (void)collectAlbum:(NSString *)albumId isCollect:(BOOL)collect withBlock:(RTRequestCompBlock)block;

//发布拼图邀请
- (void)puzzleInvite:(NSArray *)inviteUsers withAlbumId:(NSString *)albumId withModelId:(NSString *)modelId withLocalIndex:(NSInteger)index withImgFrame:(CGRect)frame withZoom:(float)zoom withImage:(UIImage *)image withPuzzleImg:(UIImage *)puzImg withText:(NSString *)text withPostion:(CGPoint)pos withBlock:(RTRequestCompBlock)block;

//拼图
- (void)puzzlePic:(UIImage *)image withScreenPic:(UIImage *)screen withInviteId:(NSString *)InviteId withLocalIndex:(NSInteger)index withImgFrame:(CGRect)frame withZoom:(float)zoom withBlock:(RTRequestCompBlock)block;

//我发出的拼图邀请，是否只加载正在进行，非完成的还是全部
- (void)puzzleMyInviteWithOnlyLoading:(BOOL)load withBlock:(RTRequestCompBlock)block;

//邀请我的拼图，是否只显示非完成的
- (void)puzzleInviteMeWithOnlyLoading:(BOOL)load withBlock:(RTRequestCompBlock)block;

//加载新消息
- (void)loadNewMsgWithBlock:(RTRequestCompBlock)block;

//获取验证码
- (void)loadMobleAuthCodeWithPhone:(NSString *)phone needExistAccount:(BOOL)exist withBlock:(RTRequestCompBlock)block;

//提交验证码
- (void)loginWtihAuthCode:(NSString *)phone withCode:(NSString *)code withBlock:(RTRequestCompBlock)block;

//下载文件
- (void)downloadFile:(NSString *)url withBlock:(RTRequestCompBlock)block;

@end

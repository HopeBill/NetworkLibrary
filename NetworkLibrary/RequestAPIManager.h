//
//  RequestAPIManager.h
//  OneKeyBrother
//
//  Created by Bill on 9/4/2019.
//  Copyright © 2019 Bill. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestBaseAPI.h"

@protocol RequestAPIManagerDelegate <NSObject>
@optional
//请求成功后调用的代理
-(void)networkingIdendifier:(NSString*)Idendifier requestSuccessBackResponse:(NSDictionary*)response;
//请求失败后调用调理
-(void)networkingIdendifier:(NSString*)Idendifier requestFailedBackResponese:(NSError*)error;

@optional
//上传图片成功的回调
-(void)updateImageRequestSuccessBackResponse:(id)response withLocationData:(NSArray*)locationArr;
//上传图片失败的回调
-(void)updateImageRequestFailedBackResponese:(id)response withLocationData:(NSArray*)locationArr;

@optional
//多接口请求成功后调用的代理
-(void)moreNetworkingIdendifier:(NSString*)Idendifier requestSuccessBackResponse:(id)data;
//多接口请求成功后调用的代理
-(void)moreNetworkingIdendifier:(NSString*)Idendifier requestFailedBackResponese:(NSError*)error;
@end
NS_ASSUME_NONNULL_BEGIN

@interface RequestAPIManager : NSObject
@property(nonatomic,weak)id<RequestAPIManagerDelegate>delegate;
/*
 * 网络请求
 */
- (void)requestWithType:(RequestAPIType)type Url:(NSString *)url params:(id)params;

/**
 * 多个网络请求
 */
-(void)requesWithData:(NSArray*)data;
/**
 *GCD异步上传图片
 */
-(void)updateImageURL:(NSString*)url withPhotoAsset:(NSArray*)photos;

@end

NS_ASSUME_NONNULL_END

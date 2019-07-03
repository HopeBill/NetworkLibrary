//
//  RequestBaseAPI.h
//  youqinghai
//
//  Created by 舒永超 on 16/3/20.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSErrorHelper.h"

typedef NS_ENUM(NSInteger, NetType) {
    Net,
    NONet,
    WiFiNet,
    OtherNet,
};

typedef NS_ENUM(NSUInteger,RequestAPIType) {
    RequestAPITypeGet,
    RequestAPITypePost,
    RequestAPITypeJosn,
    RequestAPITypePatch,
    RequestAPITypeDelete,
};

typedef void (^NetworkingURLResponseCallBack)(id response,NSURLSessionDataTask*task);
@interface RequestBaseAPI : NSObject
{
   
}
@property(nonatomic,strong)NSMutableDictionary *dispatchTask;
@property(nonatomic, assign) enum NetType netType;
@property(nonatomic, strong) NSString *netTypeString;

+ (instancetype)standardAPI;
/**
 * 网络请求
 */
- (NSInteger)requestWithType:(RequestAPIType)type Url:(NSString *)url params:(id)params success:(NetworkingURLResponseCallBack)success failure:(NetworkingURLResponseCallBack)failure;
/**
 *多个网络请求
 **/
-(void)requesWithData:(NSArray*)data success:(NetworkingURLResponseCallBack)success;
/**
 *GCD异步上传图片
 */
-(void)GCDAsynchronouPhotoAlbum:(NSString*)url photoAsset:(NSArray*)photos withParames:(NSDictionary*)parames photoSucessBackKey:(void(^)(id data,id subdata))completion;
@end

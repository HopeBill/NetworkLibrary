//
//  RequestBaseAPI.m
//  youqingh
//
//  Created by 舒永超 on 16/3/20.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "RequestBaseAPI.h"
#import "AFNetworking.h"
#import "ResourceUtilityClass.h"
#import "NSDictionary+Request.h"

#define WeakSelf(self)    __block __weak typeof(self)weakSelf=self

@interface RequestBaseAPI()
@property(nonatomic,assign)BOOL load;
@property (nonatomic, strong)NSNumber *recordedRequestId;
@property(nonatomic,strong)NSDateFormatter *formatter;
@property(nonatomic,strong)NSMutableDictionary *sessionDataTaskDic;
@end

@implementation RequestBaseAPI

+ (instancetype)standardAPI
{
    static RequestBaseAPI* requestBaseAPI;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        requestBaseAPI = [[[self class] alloc] init];
    });
    return requestBaseAPI;
}

#pragma mark - 创建网络请求管理类单例对象
+ (AFHTTPSessionManager*)sharedHTTPOperationManager
{
    static AFHTTPSessionManager* manager = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        manager = [AFHTTPSessionManager manager];
        manager.requestSerializer.timeoutInterval = 20.f; //超时时间为20s
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        
        manager.responseSerializer.acceptableContentTypes = [NSSet
            setWithObjects:@"application/json", @"text/json", @"text/javascript",
            @"text/plain", @"text/html",@"application/graphql", nil];
       
     
    });
    return manager;
}

- (instancetype)init
{
    if (self = [super init]) {
        [self startMonitoringNet];
    }
    return self;
}

#pragma mark - 监听网络状态
- (NetType)startMonitoringNet
{
    AFNetworkReachabilityManager* mgr =
        [AFNetworkReachabilityManager sharedManager];
    [mgr startMonitoring];
    WeakSelf(self);
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
    
        switch (status) {
        case AFNetworkReachabilityStatusReachableViaWiFi:
            weakSelf.netType = WiFiNet;
            weakSelf.netTypeString = @"WIFI";
          
            break;

        case AFNetworkReachabilityStatusReachableViaWWAN:
            weakSelf.netType = OtherNet;
            weakSelf.netTypeString = @"2G/3G/4G";

            break;

        case AFNetworkReachabilityStatusNotReachable:
            weakSelf.netType = NONet;
            weakSelf.netTypeString = @"网络已断开";
            break;

        case AFNetworkReachabilityStatusUnknown:
            weakSelf.netType = NONet;
            weakSelf.netTypeString = @"其他情况";
            break;
        default:
            break;
        }
    }];
    return weakSelf.netType;
}

/*
 * 网络请求
 */
- (NSInteger)requestWithType:(RequestAPIType)type Url:(NSString *)url params:(id)params success:(NetworkingURLResponseCallBack)success failure:(NetworkingURLResponseCallBack)failure{
//  NSString * urlStr=[url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    switch (type) {
        case RequestAPITypeGet:
           return [self GetRequestWithUrl:url params:params success:success failure:failure];
            break;
            
        case RequestAPITypePost:
            return  [self PostRequestWithUrl:url params:params success:success failure:failure];
            break;
        case RequestAPITypeJosn:
            return  [self JsonRequestWithUrl:url params:params success:success failure:failure];
            break;

            
        default:
            break;
    }
    
    return 0;
}
#pragma mark ====多个网络请求=====
-(void)requesWithData:(NSArray*)data success:(NetworkingURLResponseCallBack)success{
    
    __block NSMutableArray *result=[NSMutableArray array];
    for (id obj in data) {
        [result addObject:[NSNull null]];
    }
    
    dispatch_group_t group=dispatch_group_create();
   __block NSMutableArray *requesIDArr=[NSMutableArray array];
    WeakSelf(self);
    for (NSInteger i=0;i<data.count;i++) {
        dispatch_group_enter(group);
        NSDictionary *dics=data[i];
        NSNumber *requesID=[self generateRequestId];
        [requesIDArr addObject:requesID];
         AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];

        id parameterData=dics.allValues.firstObject;
        if ([parameterData isKindOfClass:[NSArray class]]) {
            //上传参数是json
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
            parameterData=dics.allValues.firstObject[0];
        }else{
            manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain", @"text/html",@"application/graphql", nil];
        }
        manager.requestSerializer.timeoutInterval = 20.f; //超时时间为20s
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
//        //头部添加sid
//        NSString *usersid=[UserInformationModel shareManager].userSid;
//
//        if (usersid.length) {
//            [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",usersid] forHTTPHeaderField:@"Authorization"];
//        }else{
//              [manager.requestSerializer setValue:@"1" forHTTPHeaderField:@"Authorization"];
//        }
        NSURLSessionDataTask* task =[manager POST:dics.allKeys.firstObject parameters:parameterData progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            @synchronized(result) {
                NSLog(@"URL:%@?%@--返回信息:%@",dics.allKeys.firstObject,[[NSString alloc]initWithData:task.originalRequest.HTTPBody encoding:NSUTF8StringEncoding],responseObject);
                result[i]=responseObject;
                if ([responseObject[@"code"] integerValue]!=200) {
                    //当请求不成功时取消所有请求
                   [weakSelf cancelMoreRequest:requesIDArr];
                }
            }
            dispatch_group_leave(group);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            @synchronized(result) {
                result[i]=error;
                [weakSelf cancelMoreRequest:requesIDArr];
            }
            dispatch_group_leave(group);
        }];
        [self.sessionDataTaskDic setObject:task forKey:requesID];
        NSLog(@"URL:%@?%@",dics.allKeys.firstObject,[[NSString alloc]initWithData:task.originalRequest.HTTPBody encoding:NSUTF8StringEncoding]);
    }
    dispatch_group_notify(group,dispatch_get_main_queue(), ^{
        if (success) success(result,nil);
    });
}
-(void)cancelMoreRequest:(NSArray*)arr{
    for (NSNumber *num in arr) {
        [self cancelRequestWithRequestId:num];
    }
}

#pragma mark-GCD-异步上传图片
-(void)GCDAsynchronouPhotoAlbum:(NSString*)url photoAsset:(NSArray*)photos withParames:(NSDictionary*)parames photoSucessBackKey:(void(^)(id data,id subdata))completion{
    
    NSMutableArray *result=[NSMutableArray array];
    NSMutableArray *subresult=[NSMutableArray array];
    for (id obj in photos) {
        [result addObject:[NSNull null]];
         [subresult addObject:[NSNull null]];
    }
    
    dispatch_group_t group=dispatch_group_create();
    
    for (NSInteger i=0;i<photos.count;i++) {
        dispatch_group_enter(group);
        NSDictionary *dics=photos[i];
        
        [self AFNetworkingUploadPhoto:dics withUrl:url withParames:parames backComepletion:^(id data, id subdata) {
            @synchronized(result) {
                result[i]=@{dics.allKeys.firstObject:data};
                subresult[i]=subdata;
            }
            dispatch_group_leave(group);
        }];
    }
    dispatch_group_notify(group,dispatch_get_main_queue(), ^{
        if (completion)  completion(result,subresult);
    });
    
}
-(NSURLSessionDataTask*)AFNetworkingUploadPhoto:(NSDictionary*)photoDic withUrl:(NSString*)url withParames:(NSDictionary*)parame backComepletion:(void(^)(id data,id subdata))comepletion{
    AFHTTPSessionManager *manger=[AFHTTPSessionManager manager];
    manger.responseSerializer=[AFHTTPResponseSerializer serializer];
//    NSString *usersid=[UserInformationModel shareManager].userSid;
//    //头部添加sid
//    if (usersid.length) {
//        [manger.requestSerializer setValue:[NSString stringWithFormat:@"%@",usersid] forHTTPHeaderField:@"Authorization"];
//    }else{
//        [manger.requestSerializer setValue:@"1" forHTTPHeaderField:@"Authorization"];
//    }
    NSData *data =[Tool compressImage:photoDic[photoDic.allKeys.firstObject] toMaxFileSize:2.0];
    // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
    // 要解决此问题，
    // 可以在上传时使用当前的系统事件作为文件名
    // 设置时间格式
    [self.formatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString *dateString = [self.formatter stringFromDate:[NSDate date]];
    NSString *fileName = [NSString  stringWithFormat:@"%@.jpg", dateString];
    __block NSDictionary *returnDic=photoDic;
    NSURLSessionDataTask *uploadtask=[manger POST:url parameters:@{@"sid":[Helper filterStrObject:parame[@"sid"]]} constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFileData:data name:@"file" fileName:fileName mimeType:@"image/jpg"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if ([dic isKindOfClass:[NSDictionary class]]&& comepletion) {
            if (comepletion) comepletion(dic,returnDic);
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (comepletion) comepletion(error,returnDic);
        
    }];
     NSLog(@"请求链接：%@?%@",url,[[NSString alloc]initWithData:uploadtask.originalRequest.HTTPBody encoding:NSUTF8StringEncoding]);
    return uploadtask;
}


- (NSInteger)GetRequestWithUrl:(NSString *)url params:(NSDictionary*)params success:(NetworkingURLResponseCallBack)success failure:(NetworkingURLResponseCallBack)failure{
    NSNumber *requesID=[self generateRequestId];
     AFHTTPSessionManager* manager = [RequestBaseAPI sharedHTTPOperationManager];
//    //头部添加sid
//    NSString *usersid=[UserInformationModel shareManager].userSid;
//    if (usersid.length) {
//        [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",usersid] forHTTPHeaderField:@"Authorization"];
//    }else{
//        [manager.requestSerializer setValue:@"1" forHTTPHeaderField:@"Authorization"];
//    }
    
    NSString *paramStr=[params ParamsStringSignature:NO];
    NSURLSessionDataTask* task = [manager GET:url parameters:paramStr progress:nil success:^(NSURLSessionDataTask* task, id responseObject) {
        
        success(responseObject,task);
    
     }failure:^(NSURLSessionDataTask* task, NSError* error) {
         failure(error,task);
            
    }];
    
     NSLog(@"请求链接：%@?%@",url,[[NSString alloc]initWithData:task.originalRequest.HTTPBody encoding:NSUTF8StringEncoding]);
    [self.sessionDataTaskDic setObject:task forKey:requesID];
    return [requesID integerValue];
}

- (NSInteger)PostRequestWithUrl:(NSString *)url params:(id)params success:(NetworkingURLResponseCallBack)success failure:(NetworkingURLResponseCallBack)failure{
    NSNumber *requesID=[self generateRequestId];
    AFHTTPSessionManager* manager = [RequestBaseAPI sharedHTTPOperationManager];
//    //头部添加sid
//    NSString *usersid=[UserInformationModel shareManager].userSid;
//    if (usersid.length) {
//        [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",usersid] forHTTPHeaderField:@"Authorization"];
//    }else{
//        [manager.requestSerializer setValue:@"1" forHTTPHeaderField:@"Authorization"];
//    }

    NSURLSessionDataTask* task = [manager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask* task, id responseObject) {
        NSLog(@"返回值：%@",responseObject);
         success(responseObject,task);
        
    } failure:^(NSURLSessionDataTask* task, NSError* error) {
        
        failure(error,task);
        
    }];
     NSLog(@"请求链接：%@?%@",url,[[NSString alloc]initWithData:task.originalRequest.HTTPBody encoding:NSUTF8StringEncoding]);
    [self.sessionDataTaskDic setObject:task forKey:requesID];
    return [requesID integerValue];
}
- (NSInteger)JsonRequestWithUrl:(NSString *)url params:(id)params success:(NetworkingURLResponseCallBack)success failure:(NetworkingURLResponseCallBack)failure{
    NSNumber *requesID=[self generateRequestId];
    
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval = 20.f; //超时时间为20s
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
//    //头部添加sid
//    NSString *usersid=[UserInformationModel shareManager].userSid;
//    if (usersid.length) {
//        [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",usersid] forHTTPHeaderField:@"Authorization"];
//    }else{
//          [manager.requestSerializer setValue:@"1" forHTTPHeaderField:@"Authorization"];
//    }
    
    NSURLSessionDataTask* task = [manager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask* task, id responseObject) {
        NSLog(@"返回值：%@",responseObject);
        success(responseObject,task);
        
    } failure:^(NSURLSessionDataTask* task, NSError* error) {
        
        failure(error,task);
        
    }];
    NSLog(@"请求链接：%@?%@",url,[[NSString alloc]initWithData:task.originalRequest.HTTPBody encoding:NSUTF8StringEncoding]);
    [self.sessionDataTaskDic setObject:task forKey:requesID];
    return [requesID integerValue];
}
#pragma mark=== 保存请求ID
-(NSNumber*)generateRequestId{
    
    if (_recordedRequestId==nil) {
        _recordedRequestId = @(1);
    }else{
        if ([_recordedRequestId integerValue] == NSIntegerMax) {
            _recordedRequestId = @(1);
        } else {
            _recordedRequestId = @([_recordedRequestId integerValue] + 1);
        }
    }
    return _recordedRequestId;
}

/*
 * 单独取消请求
 */

- (void)cancelRequestWithRequestId:(NSNumber *)requestID
{
   
    NSURLSessionDataTask *task = [self.sessionDataTaskDic objectForKey:requestID];
    if (task) {
        [task cancel];
        [self.sessionDataTaskDic removeObjectForKey:requestID];
    }
    
}
-(NSDateFormatter*)formatter{
    NetWorkingReformer(NSDateFormatter,_formatter)
}
-(NSMutableDictionary*)sessionDataTaskDic{
    NetWorkingReformer(NSMutableDictionary,_sessionDataTaskDic)
}
@end

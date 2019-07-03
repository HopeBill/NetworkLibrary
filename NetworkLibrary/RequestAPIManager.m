
//
//  RequestAPIManager.m
//  OneKeyBrother
//
//  Created by Bill on 9/4/2019.
//  Copyright © 2019 Bill. All rights reserved.
//

#import "RequestAPIManager.h"
#import "ResourceUtilityClass.h"
@interface RequestAPIManager ()
@property(nonatomic,strong)NSString *baseUrl;
@end

@implementation RequestAPIManager
- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}
/*
 * 网络请求
 */
- (void)requestWithType:(RequestAPIType)type Url:(NSString *)url params:(id)params;{

    WeakSelf(self);
    NSDictionary *requestParams=[self getRequestData:params];
    [[RequestBaseAPI standardAPI] requestWithType:type Url:url params:requestParams success:^(id response, NSURLSessionDataTask *task) {
        [weakSelf requestSuccessBack:response withIdendifier:task];
    } failure:^(id response, NSURLSessionDataTask *task) {
        [weakSelf requestFailureBack:response withResponse:task];
    }];
}

#pragma mark=== 处理请求参数===
-(NSDictionary*)getRequestData:(NSDictionary*)dic{
    
    NSMutableDictionary *dics=[NSMutableDictionary dictionaryWithDictionary:[Helper filterDicObject:dic]];
    return dics;
}

#pragma mark ===多个网络请求====
-(void)requesWithData:(NSArray*)data{
 
    NSMutableArray *parmeterArr=[NSMutableArray array];
    for (NSDictionary *subdic in data) {
        if ([subdic.allValues.firstObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *requestParams=[self getRequestData:subdic.allValues.firstObject];
            [parmeterArr addObject:@{subdic.allKeys.firstObject:requestParams}];
        }else{
             [parmeterArr addObject:@{subdic.allKeys.firstObject:subdic.allValues.firstObject}];
        }
    }
    
    WeakSelf(self);
    [[RequestBaseAPI standardAPI] requesWithData:parmeterArr success:^(id response, id Idendifier) {
         [weakSelf moreRequestSuccessBack:response withIdendifier:Idendifier];
    }];
}
#pragma mark===  GCD异步上传图片==
-(void)updateImageURL:(NSString *)url withPhotoAsset:(NSArray *)photos
{
    WeakSelf(self);
    NSDictionary *requestParams=[self getRequestData:@{}];
    [[RequestBaseAPI standardAPI] GCDAsynchronouPhotoAlbum:url photoAsset:photos withParames:requestParams photoSucessBackKey:^(id data, id subdata) {
         [weakSelf updateImageBackResponse:data withData:subdata];
    }];
 
}

#pragma mark===成功回调处理====
-(void)requestSuccessBack:(id)response withIdendifier:(NSURLSessionDataTask*)task{
    
    NSString *url=task.response.URL.absoluteString;
   
    if ([response isKindOfClass:[NSDictionary class]]) {
        NSString *codeStr=[Helper filterStrObject:response[@"code"]];
        if ([codeStr intValue]==200 && [response[@"result"] integerValue]==1)
        {
            if ([self.delegate respondsToSelector:@selector(networkingIdendifier:requestSuccessBackResponse:)])
            {
                [self.delegate networkingIdendifier:url requestSuccessBackResponse:[Helper filterDicObject:[Helper filterDicObject:response][@"data"]]];
            }
        }else{
            [self requestFailureBack:[Helper filterDicObject:response] withResponse:task];
        }
        
    }else{
        [self requestFailureBack:[Helper filterDicObject:response] withResponse:task];
    }
    
}

#pragma mark===失败回调处理=====
-(void)requestFailureBack:(id)data withResponse:(NSURLSessionDataTask*)task{
    
    if ([data isKindOfClass:[NSError class]]) {
        NSError *error=(NSError*)data;
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        NSInteger statusCode = response.statusCode;
        NSMutableDictionary* userInfo =
        [error.userInfo mutableCopy] ?: [NSMutableDictionary dictionary];
        userInfo[customErrorInfoKey] = [NSErrorHelper handleErrorMessage:error];
        error=[NSErrorHelper createErrorWithUserInfo:userInfo domain:BASED_URL code:statusCode];
        [self handleErrorResultWithSubscriber:error withIdendifier:task.response.URL.absoluteString];
    }else{
        NSDictionary *responseObject=[Helper filterDicObject:data];
        NSMutableDictionary* userInfo =[NSMutableDictionary dictionary];
        userInfo[customErrorInfoKey] =[NSErrorHelper handleSuccessMessage:responseObject];
        NSString *codeStr=[Helper filterStrObject:responseObject[@"code"]];
        NSError *error=[NSErrorHelper createErrorWithUserInfo:userInfo domain:BASED_URL code:[codeStr intValue]];
        
        [self handleErrorResultWithSubscriber:error withIdendifier:task.response.URL.absoluteString];
    }
    
}
#pragma mark======
-(void)handleErrorResultWithSubscriber:(id)response withIdendifier:(NSString*)url{

    if ([self.delegate respondsToSelector:@selector(networkingIdendifier:requestFailedBackResponese:)]) {
        [self.delegate networkingIdendifier:url requestFailedBackResponese:response];
    }
}


#pragma mark====多个请求返回的结果
-(void)moreRequestSuccessBack:(NSArray*)response withIdendifier:(id)Idendifier{
    NSMutableArray *returnArr=[NSMutableArray array];
    for (NSDictionary *obj in response) {
        id subobj= [self moreNetworkingHandleResult:obj];
        [returnArr addObject:subobj];
    }
    BOOL success=NO;
    NSError *error=nil;
    for (id subdic in returnArr) {
        if ([subdic isKindOfClass:[NSError class]]) {
            success=NO;
            error=subdic;
             NSLog(@"错误 error:code:%ld--message:%@", error.code,error.userInfo[customErrorInfoKey]);
            break;
        }else{
            success=YES;
        }
    }
    
    if (success) {
        if (self.delegate &&[self.delegate respondsToSelector:@selector(moreNetworkingIdendifier:requestSuccessBackResponse:)]) {
            [self.delegate moreNetworkingIdendifier:Idendifier requestSuccessBackResponse:returnArr];
        }
    }else{
        if (self.delegate && [self.delegate respondsToSelector:@selector(moreNetworkingIdendifier:requestFailedBackResponese:)]){
            [self.delegate moreNetworkingIdendifier:Idendifier requestFailedBackResponese:error];
        }
    }
    
    
}
-(id)moreNetworkingHandleResult:(id)data{
    if ([data isKindOfClass:[NSError class]]) {
        NSError *error=(NSError*)data;
        NSMutableDictionary* userInfo =
        [error.userInfo mutableCopy] ?: [NSMutableDictionary dictionary];
        userInfo[customErrorInfoKey] = [NSErrorHelper handleErrorMessage:error];
        error=[NSErrorHelper createErrorWithUserInfo:userInfo domain:BASED_URL];
        return error;
    }else{
        NSDictionary *responseObject=[Helper filterDicObject:data];
        if ([responseObject[@"code"] integerValue]==200 && [responseObject[@"result"] integerValue]==1) {
            return responseObject[@"data"];
        }
        NSMutableDictionary* userInfo =[NSMutableDictionary dictionary];
        userInfo[customErrorInfoKey] =[NSErrorHelper handleSuccessMessage:responseObject];
        NSError *error=[NSErrorHelper createErrorWithUserInfo:userInfo domain:BASED_URL code:[responseObject[@"code"] intValue]];
        return error;
    }
}

#pragma mark=== 上传图片之后的回调
-(void)updateImageBackResponse:(id)data withData:(id)subdata{
    NSMutableArray *returnArr=[NSMutableArray array];
    for (NSDictionary *obj in data) {
        NSMutableDictionary *subdic=[NSMutableDictionary dictionary];
        id subobj= [self moreNetworkingHandleResult:obj.allValues.firstObject];
        [subdic setObject:subobj forKey:obj.allKeys.firstObject];
        [returnArr addObject:subdic];
    }
      BOOL success=NO;
    for (NSDictionary *subdic in returnArr) {
        if ([subdic.allValues.firstObject isKindOfClass:[NSError class]]) {
            success=NO;
            break;
        }else{
            success=YES;
        }
    }
    if (success) {
    if (self.delegate && [self.delegate respondsToSelector:@selector(updateImageRequestSuccessBackResponse:withLocationData:)]) {
        [self.delegate updateImageRequestSuccessBackResponse:[Helper filterArrObject:returnArr] withLocationData:[Helper filterArrObject:subdata]];
    }
    }else{
        if (self.delegate && [self.delegate respondsToSelector:@selector(updateImageRequestFailedBackResponese:withLocationData:)]) {
            [self.delegate updateImageRequestFailedBackResponese:[Helper filterArrObject:returnArr] withLocationData:[Helper filterArrObject:subdata]];
        }
    }
}
@end

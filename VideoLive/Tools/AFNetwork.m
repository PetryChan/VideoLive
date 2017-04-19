//
//  AFNetwork.m
//  VideoLive
//
//  Created by petry(陈荣) on 2017/4/5.
//  Copyright © 2017年 petry(陈荣). All rights reserved.
//

#import "AFNetwork.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>

@implementation AFNetwork

+ (AFHTTPSessionManager *)shareManager
{
    static AFHTTPSessionManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html",@"text/plain", nil];
    });
    return manager;
}

+ (AFHTTPSessionManager *)manager
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.securityPolicy.allowInvalidCertificates = true;
    
    return manager;
}

+ (void)GET:(NSString *)URLString
 parameters:(id)parameters
    success:(void (^)(id _Nonnull))success
    failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure
{
    NSString *str = [[NSString stringWithFormat:@"%@",URLString] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[self shareManager] GET:str parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        if (success) {
            //从服务器中获取到数据是字典形式的，这里习惯使用json字符串，进行解析
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"请求失败，请检查网络,或者刷新频率过快"];
        if (failure) {
            failure(task,error);
        }
    }];
}

+ (void)POST:(NSString *)URLString
  parameters:(id)parameters
     success:(void (^)(id _Nonnull))success
     failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure
{
    NSString *str = [[NSString stringWithFormat:@"%@",URLString] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPSessionManager *manager = [self manager];
//    manager.securityPolicy.allowInvalidCertificates = true;
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    [manager.requestSerializer setTimeoutInterval:10.0];
    [manager POST:str parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"数据解析失败，请重新尝试"];
        if (failure) {
            failure(task,error);
        }
    }];
}

+ (void)spec_GET:(NSString *)URLString
      parameters:(id)parameters
         success:(void (^)(id _Nonnull))success
         failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure
{
//    [SVProgressHUD showWithStatus:@"正在玩命请求中..."];
    AFNetworkReachabilityStatus status = [[AFNetworkReachabilityManager sharedManager] networkReachabilityStatus];
    if (status == AFNetworkReachabilityStatusNotReachable) {
        [SVProgressHUD showWithStatus:@"连接网络失败..."];
        return;
    }
    AFHTTPSessionManager *manager = [self manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setTimeoutInterval:5.0];
    [manager GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"请求失败，请检查网络,或者刷新频率过快"];
        if (failure) {
            failure(task,error);
        }
    }];
    
}

+ (void)async_GET:(NSString *)URLString
       parameters:(id)parameters
          success:(void (^)(id _Nonnull))success
          failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure
{
    AFNetworkReachabilityStatus status = [[AFNetworkReachabilityManager sharedManager] networkReachabilityStatus];
    if (status == AFNetworkReachabilityStatusNotReachable) {
        [SVProgressHUD showWithStatus:@"连接网络失败..."];
        return;
    }
    AFHTTPSessionManager *manager = [self manager];
    [manager GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"请求失败，请检查网络,或者刷新频率过快"];
        if (failure) {
            failure(task,error);
        }
    }];

}

@end

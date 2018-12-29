//
//  AFNHelper.m
//  L2CSmartMotor
//
//  Created by feaonline on 2018/9/25.
//  Copyright © 2018年 feaonline. All rights reserved.
//

#import "AFNHelper.h"

@implementation AFNHelper


+ (AFNHelper *)sharedManager {
    
    static AFNHelper *handle = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        handle = [AFNHelper manager];
        handle.responseSerializer = [AFHTTPResponseSerializer serializer];
        handle.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"application/json",@"text/json",@"text/javascript",@"text/html",nil];
        
        
    });
    
    return handle;
    
}


//get请求
+ (NSURLSessionDataTask *)get:(NSString *)url parameter:(id)parameters success:(void (^)(id responseObject))success faliure:(void (^)(id error))failure
{
    
    
    NSLog(@"url=====%@",url);
    
    NSLog(@"parameters======%@",parameters);
    
    
    NSURLSessionDataTask *dataTask = [[AFNHelper sharedManager] GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        NSLog(@"%@",responseObject);
        
        success(responseObject);
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
        failure(error);
        
        
        
    }];
    
    return dataTask;
}

//post请求
+ (NSURLSessionDataTask *)post:(NSString *)url parameters:(id)parameters success:(void(^)(id responseObject))success faliure:(void(^)(id error))failure {
    
    NSLog(@"parameters======%@",parameters);
    
    NSLog(@"url=====%@",url);
    
//    NSString *urlStr = [BaseUrl stringByAppendingString:url];
    
    NSURLSessionDataTask *dataTask = [[AFNHelper sharedManager] POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        NSLog(@"%@",responseObject);
        success(responseObject);
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
        failure(error);
        
    }];
    
    return dataTask;
    
}

+ (NSURLSessionDataTask *)postNoBaseUrl:(NSString *)url parameters:(id)parameters success:(void(^)(id responseObject))success faliure:(void(^)(id error))failure {
    
    
    NSURLSessionDataTask *dataTask = [[AFNHelper sharedManager] POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        
        success(responseObject);
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure(error);
        
    }];
    
    return dataTask;
    
}

//文件上传
+ (NSURLSessionDataTask *)post:(NSString *)url parameters:(id)parameters  constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block success:(void (^)(id responseObject))success faliure:(void (^)(id error))failure{
    
    NSURLSessionDataTask *dataTask = [[AFNHelper sharedManager] POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        block(formData);
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        success(responseObject);
        
        NSLog(@"%@",responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure(error);
        NSLog(@"%@",error);
        
    }];
    
    return dataTask;
    
}

//文件上传(不需要拼接基地址)
+ (NSURLSessionDataTask *)postWithNoBaseUrl:(NSString *)url parameters:(id)parameters constructingBodyWithBlock:(void (^)(id<AFMultipartFormData>))block progress:(void (^)(NSProgress *))progress success:(void (^)(id))success faliure:(void (^)(id))failure {
    
    NSURLSessionDataTask *dataTask = [[AFNHelper sharedManager] POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        block(formData);
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
        if (uploadProgress) {
            
            progress(uploadProgress);
        }
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        success(responseObject);
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure(error);
        
    }];
    
    return dataTask;
    
}


//文件下载
+ (void)downloadTaskWithUrl:(NSString *)url progress:(void (^)(id downloadProgress))ProgressBlock savePath:(NSString *)savePath  completionHandler:(void (^)(NSURLResponse *response ,NSURL *filePath))completion  error:(void (^)(id error))failure{
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    
    NSURLSessionDownloadTask *download =  [[AFNHelper sharedManager]  downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
        if (downloadProgress) {
            ProgressBlock(downloadProgress);
        }
        
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        return  [NSURL fileURLWithPath:savePath];
        
    }completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        if (!error) {
            completion(response,filePath);
        }
        else {
            
            failure(error);
            
        }
        
        
    }];
    [download resume];
    
    
}

@end

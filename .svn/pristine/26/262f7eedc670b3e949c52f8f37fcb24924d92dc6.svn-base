//
//  Singleton.h
//  loginIn
//
//  Created by jumpapp1 on 16/4/12.
//  Copyright © 2016年 jumpapp1. All rights reserved.
//

#ifndef Singleton_h
#define Singleton_h

#define singleton_Interface(class) +(class *)share##class;
#define singleton_implemetntion(class)\
static class *instance = nil;\
+(class *)share##class\
{\
if (!instance){\
instance = [[class alloc]init];\
}\
return instance;\
}\
+(class *)allocWithZone:(struct _NSZone *)zone\
{\
static dispatch_once_t onece;\
dispatch_once(&onece,^{\
instance = [super allocWithZone:zone];\
});\
return instance;\
}

#endif /* Singleton_h */

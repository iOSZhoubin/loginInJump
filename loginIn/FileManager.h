//
//  FileManager.h
//  loginIn
//
//  Created by jumpapp1 on 16/4/12.
//  Copyright © 2016年 jumpapp1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
@interface FileManager : NSObject
singleton_Interface(FileManager)
@property(nonatomic,assign)int netState;
@end

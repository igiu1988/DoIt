//
//  SeMonitorController.h
//  RunloopMonitorDemo
//
//  Created by game3108 on 16/4/14.
//  Copyright © 2016年 game3108. All rights reserved.
//

#import <Foundation/Foundation.h>

// 创建一个单例，调用startMonitor即可
@interface SeMonitorController : NSObject
+ (instancetype) sharedInstance;
- (void) startMonitor;
- (void) endMonitor;
- (void) printLogTrace;
@end

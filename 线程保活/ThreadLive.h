//
//  ThreadLive.h
//  DoIt
//
//  Created by wangyang on 2020/10/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/*
 初始化一个ThreadLive类的属性，在init方法里已经做了线程保活
 将这个属性设置为nil，则可以关闭线程。
 其深入Runloop的原理参考相关源码分析：https://www.jianshu.com/p/4d5b6fc33519
 */
@interface ThreadLive : NSObject

- (void)testThreadLive;
@end

NS_ASSUME_NONNULL_END

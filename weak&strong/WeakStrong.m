//
//  WeakStrong.m
//  DoIt
//
//  Created by wangyang on 2020/10/4.
//

#import "WeakStrong.h"
@interface WYObject: NSObject
@end
@implementation WYObject
- (void)dealloc {
    
}
@end
@implementation WeakStrong

+ (void)testWeak {
    WYObject *obj = [[WYObject alloc] init];
    // 此时的obj在x0，
    __weak WYObject *weakObj = obj;
    // 给block赋值，相当于objc_storeStrong()
    void (^block)(void) = ^(){
        NSLog(@"TestObj对象地址2:%@",weakObj);
        // 从汇编代码能看来出，在执行NSLog之后，会对obj进行release操作，根据release的源码逻辑，此时的obj会被释放
        dispatch_async(dispatch_queue_create(DISPATCH_QUEUE_PRIORITY_DEFAULT, NULL), ^{
            
            for (int i = 0; i < 1000000; i++) {
                // 模拟一个耗时的任务
            }

            NSLog(@"耗时的任务 结束 TestObj对象地址3:%@",weakObj);
        });
    };
    block();
}

+ (void)testStrong {
    WYObject *obj = [[WYObject alloc] init];
    __weak WYObject *weakObj = obj;
    void (^block)(void) = ^(){
        __strong NSObject *strongObj = weakObj;
        if(! strongObj) {
            return;
        }
        NSLog(@"TestObj对象地址:%@",weakObj);
        dispatch_async(dispatch_queue_create(DISPATCH_QUEUE_PRIORITY_DEFAULT, NULL), ^{
            
            for (int i = 0; i < 1000000; i++) {
                // 模拟一个耗时的任务
            }

            NSLog(@"耗时的任务 结束 TestObj对象地址:%@",strongObj);
        });
    };
    block();
}
@end

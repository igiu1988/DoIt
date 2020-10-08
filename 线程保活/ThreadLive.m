//
//  ThreadLive.m
//  DoIt
//
//  Created by wangyang on 2020/10/8.
//

#import "ThreadLive.h"
@interface HTThread : NSThread
@end

@implementation HTThread
- (void)dealloc
{
    NSLog(@"%s", __func__);
}
@end


@interface ThreadLive ()
@property (nonatomic, strong) HTThread *thread;
@property (nonatomic, assign, getter=isStoped) BOOL stopped;

@end

@implementation ThreadLive
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self startThread];
    }
    return self;
}
- (void)startThread {
    __weak typeof(self) weakSelf = self;
    
    self.stopped = NO;
    self.thread = [[HTThread alloc] initWithBlock:^{
        NSLog(@"begin-----%@", [NSThread currentThread]);
        
        // ① 获取/创建当前线程的 RunLoop
        // ② 向该 RunLoop 中添加一个 Source/Port 等来维持 RunLoop 的事件循环
        [[NSRunLoop currentRunLoop] addPort:[[NSPort alloc] init] forMode:NSDefaultRunLoopMode];
    
        while (weakSelf && !weakSelf.isStoped) {
            // ③ 启动该 RunLoop
            /*
              [[NSRunLoop currentRunLoop] run]
              如果调用 RunLoop 的 run 方法，则会开启一个永不销毁的线程
              因为 run 方法会通过反复调用 runMode:beforeDate: 方法，以运行在 NSDefaultRunLoopMode 模式下
              换句话说，该方法有效地开启了一个无限的循环，处理来自 RunLoop 的输入源 Sources 和 Timers 的数据
            */
            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        }
        NSLog(@"end-----%@", [NSThread currentThread]);
    }];
    [self.thread start];
}

- (void)testThreadLive
{
    if (!self.thread) return;
    [self performSelector:@selector(_testThreadLive) onThread:self.thread withObject:nil waitUntilDone:NO];
}

// 子线程需要执行的任务
- (void)_testThreadLive
{
    NSLog(@"%s-----%@", __func__, [NSThread currentThread]);
}

// 停止子线程的 RunLoop
- (void)stopThread
{
    // 设置标记为 YES
    self.stopped = YES;
    // 停止 RunLoop
    CFRunLoopStop(CFRunLoopGetCurrent());
    NSLog(@"%s-----%@", __func__, [NSThread currentThread]);
    // 清空线程
    self.thread = nil;
}

- (void)dealloc
{
    NSLog(@"%s", __func__);
    
    if (!self.thread) return;
    // 在子线程调用（waitUntilDone设置为YES，代表子线程的代码执行完毕后，当前方法才会继续往下执行）
    [self performSelector:@selector(stopThread) onThread:self.thread withObject:nil waitUntilDone:YES];
}
@end

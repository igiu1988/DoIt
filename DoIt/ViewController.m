//
//  ViewController.m
//  DoIt
//
//  Created by wangyang on 2020/10/4.
//

#import "ViewController.h"
#import "WeakStrong.h"
#import "ThreadLive.h"
@interface ViewController ()
@property (nonatomic, strong) ThreadLive *threadTest;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.threadTest = [[ThreadLive alloc] init];
}

- (IBAction)buttonAction:(id)sender {
    self.threadTest = nil;
    NSLog(@"button action");
}

@end

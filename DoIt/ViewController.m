//
//  ViewController.m
//  DoIt
//
//  Created by wangyang on 2020/10/4.
//

#import "ViewController.h"
#import "WeakStrong.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [WeakStrong testWeak];
    [WeakStrong testStrong];
}


@end

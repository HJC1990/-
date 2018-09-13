//
//  ViewController.m
//  仿音量柱形图
//
//  Created by sam on 2018/9/13.
//  Copyright © 2018年 sam. All rights reserved.
//

#import "ViewController.h"
#import "VolumeView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    VolumeView *volume = [[VolumeView alloc] initWithFrame:CGRectMake(200, 200, 160, 160)];
    volume.columnW = 44;
    volume.columnH = 100;
    volume.cornerRad = 12;
    [self.view addSubview:volume];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

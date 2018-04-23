//
//  ONViewController.m
//  ONONLive
//
//  Created by SanW on 2018/4/23.
//  Copyright © 2018年 ONONTeam. All rights reserved.
//

#import "ONViewController.h"
#import "ONCaptureController.h"
@interface ONViewController ()

@end

@implementation ONViewController
- (void)viewWillAppear:(BOOL)animated{
    NSLog(@"A viewWillAppear");
}
- (void)viewDidAppear:(BOOL)animated{
    NSLog(@"A viewDidAppear");
}
- (void)viewWillDisappear:(BOOL)animated{
    NSLog(@"A viewWillDisappear");
}
- (void)viewDidDisappear:(BOOL)animated{
    NSLog(@"A viewDidDisappear");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    NSLog(@"A viewDidLoad");
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    ONCaptureController *captureController = [[ONCaptureController alloc]init];
    [self.navigationController pushViewController:captureController animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

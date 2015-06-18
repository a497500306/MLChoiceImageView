//
//  ViewController.m
//  MLChoiceImageView
//
//  Created by a on 15-6-18.
//  Copyright (c) 2015年 sss. All rights reserved.
//

#import "ViewController.h"
#import "MLAssetPickerController.h"

@interface ViewController ()<MLAssetPickerControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)openTheAlbum {
    MLAssetPickerController *pc = [[MLAssetPickerController alloc] init];
    pc.SelectNumber = 6;
    pc.delegate = self;
    UINavigationController* uc = [[UINavigationController alloc]initWithRootViewController:pc];
    [self presentViewController:uc animated:YES completion:NULL];
}
-(void)assetPickerController:(MLAssetPickerController *)picker didFinishPickingAssets:(NSArray *)assets{
    //在这里退出模态窗口
    //取得Asset照片属性,自己转换便可
    NSLog(@"有几张照片%lu",(unsigned long)assets.count);
}
@end

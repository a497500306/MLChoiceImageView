//
//  MLChoiceAlbumController.m
//  JTTXLV2
//
//  Created by a on 15-6-3.
//
//

#import "MLChoiceAlbumController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "MLAssetPickerController.h"
#if !__has_feature(objc_arc)
#error this file need set arc
#endif
@interface MLChoiceAlbumController()<UIGestureRecognizerDelegate>

@end

@implementation MLChoiceAlbumController
-(NSMutableArray *)albumsArray{
    if (_albumsArray == nil) {
        _albumsArray = [[NSMutableArray alloc] init];
        return _albumsArray;
    }
    return _albumsArray;
}

//实现滑动退出功能,实现self.navigationController.interactivePopGestureRecognizer.delegate = self;
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return YES;
}
-(void)viewDidLoad{
    [super viewDidLoad];
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    //cell高度
    self.tableView.rowHeight = 60;
    //设置返回按钮
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 34, 34)];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"back_nor.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(dianjifanhui) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItems = @[leftBarItem];
}
#pragma mark - 点击返回
-(void)dianjifanhui{
    [self.navigationController popViewControllerAnimated:YES];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.albumsArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == 0) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    ALAssetsGroup *assetsGroup = self.albumsArray[self.albumsArray.count - indexPath.row - 1];
    //相册名字
    NSString *str = [NSString stringWithFormat:@"%d",assetsGroup.numberOfAssets];
    if ([[assetsGroup valueForProperty:ALAssetsGroupPropertyName] isEqualToString:@"Camera Roll"]) {
        cell.textLabel.text = @"相机胶卷";
        cell.detailTextLabel.text =str;
    }else if ([[assetsGroup valueForProperty:ALAssetsGroupPropertyName] isEqualToString:@"My Photo Stream"]){
        cell.textLabel.text = @"我的照片流";
        cell.detailTextLabel.text =str;
    }else{
        cell.textLabel.text = [assetsGroup valueForProperty:ALAssetsGroupPropertyName];
        cell.detailTextLabel.text =str;
    }
    [assetsGroup enumerateAssetsWithOptions:NSEnumerationReverse usingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
        if (result) {
            //相册图片
            cell.imageView.image = [UIImage imageWithCGImage:result.thumbnail];
            *stop = YES;
        } else {
            
        }
    }];
    //显示剪头
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ALAssetsGroup *assetsGroup = self.albumsArray[self.albumsArray.count - indexPath.row - 1];
    self.ap.assetsGroup = assetsGroup;
    self.ap.isXuanzheImage = YES;
    [self dianjifanhui];
}
@end

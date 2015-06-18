//
//  MLChoiceImageView.m
//  JTTXLV2
//
//  Created by a on 15-5-29.
//
//

#import "MLAssetPickerController.h"
#import "MLChoiceImageCell.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import "MLCollectionViewFlowLayout.h"
#import "UIImage+MJ.h"
#import "MLChoiceButton.h"
#import "MLChoiceModel.h"
#import "MLLeafletPictureController.h"
#import "MLChoiceAlbumController.h"
#if !__has_feature(objc_arc)
#error this file need set arc
#endif
#define ewai 50
@interface MLAssetPickerController()<UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,MLChoiceImageCellDelegate>

@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, copy) NSArray *fetchResults;
@property (nonatomic, strong) PHFetchResult *fetchResult;
@property (nonatomic, strong) NSMutableArray *xuanzheArray;
@property (nonatomic, strong) NSMutableArray *modelArray;
@property (nonatomic, weak) UIBarButtonItem *barbtn;
@property (nonatomic, assign) BOOL isquanxian;
/**
 *  相册数组
 */
@property (nonatomic, strong) NSMutableArray *albumsArray;
@end

@implementation MLAssetPickerController
+ (ALAssetsLibrary *)defaultAssetsLibrary
{
    static dispatch_once_t pred = 0;
    static ALAssetsLibrary *library = nil;
    dispatch_once(&pred,
                  ^{
                      library = [[ALAssetsLibrary alloc] init];
                  });
    return library;
}
-(NSMutableArray *)albumsArray{
    if (_albumsArray == nil) {
        _albumsArray = [[NSMutableArray alloc] init];
        return _albumsArray;
    }
    return _albumsArray;
}
-(NSMutableArray *)modelArray{
    if (_modelArray == nil) {
        _modelArray = [[NSMutableArray alloc] init];
        return _modelArray;
    }
    return _modelArray;
}
-(NSMutableArray *)xuanzheArray{
    if (_xuanzheArray == nil) {
        _xuanzheArray = [[NSMutableArray alloc] init];
        return _xuanzheArray;
    }
    return _xuanzheArray;
}
static NSString *const ID = @"image";
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    //相片获取
    [self huoquXiangpian];
    //初始化
    [self chushihua];
}
-(void)viewDidLoad{
    [super viewDidLoad];
    //通知
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(tongzhi:) name:@"MLLeafletPictureController_Send" object:nil];
}
#pragma mark - 获取相片
-(void)huoquXiangpian{
    NSString *tipTextWhenNoPhotosAuthorization; // 提示语
    // 获取当前应用对照片的访问授权状态
    ALAuthorizationStatus authorizationStatus = [ALAssetsLibrary authorizationStatus];
    // 如果没有获取访问授权，或者访问授权状态已经被明确禁止，则显示提示语，引导用户开启授权
    if (authorizationStatus == ALAuthorizationStatusRestricted || authorizationStatus == ALAuthorizationStatusDenied) {
        NSDictionary *mainInfoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString *appName = [mainInfoDictionary objectForKey:@"CFBundleDisplayName"];
        tipTextWhenNoPhotosAuthorization = [NSString stringWithFormat:@"请在设备的\"设置-隐私-照片\"选项中，允许%@访问你的手机相册", appName];
        self.isquanxian = YES;
    }
    if (self.assetsGroup) {
        if (self.isXuanzheImage) {
            self.xuanzheArray = nil;
            self.isXuanzheImage = NO;
        }
        NSMutableArray *modelArray = [[NSMutableArray alloc] init];
        ALAssetsGroup *assetsGroup = self.assetsGroup;
        __weak typeof(self) weakSelf = self;
        [assetsGroup enumerateAssetsWithOptions:NSEnumerationReverse usingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
            if (result) {
                MLChoiceModel *model = [[MLChoiceModel alloc] init];
                model.isSelected = NO;
                model.mark = 0;
                model.asset = result;
                [modelArray addObject:model];
            } else {
                // result 为 nil，即遍历相片或视频完毕，可以展示资源列表
                if (weakSelf.modelArray.count > 0) return ;
                weakSelf.modelArray = modelArray;
            }
        }];
    }else{
        ALAssetsLibrary *assetsLibrary = [self.class defaultAssetsLibrary];
        NSMutableArray *albumsArray = [[NSMutableArray alloc] init];
        __weak typeof(self) weakSelf = self;
        [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
            if (group) {
                [group setAssetsFilter:[ALAssetsFilter allPhotos]];
                if (group.numberOfAssets > 0) {
                    // 把相册储存到数组中，方便后面展示相册时使用
                    [albumsArray addObject:group];
                    NSLog(@"%@",group);
                }
            } else {
                if ([albumsArray count] > 0) {
                    // 把所有的相册储存完毕，可以展示相册列表
                    self.albumsArray = albumsArray;
                    NSMutableArray *modelArray = [[NSMutableArray alloc] init];
                    for (int i = 0; i < albumsArray.count; i++) {
                        ALAssetsGroup *assetsGroup = albumsArray[i];
                        NSString* groupname = [assetsGroup valueForProperty:ALAssetsGroupPropertyName];
                        if ([groupname isEqualToString:@"Camera Roll"]) {
                            [assetsGroup enumerateAssetsWithOptions:NSEnumerationReverse usingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                                if (result) {
                                    MLChoiceModel *model = [[MLChoiceModel alloc] init];
                                    model.isSelected = NO;
                                    model.mark = 0;
                                    model.asset = result;
                                    [modelArray addObject:model];
                                } else {
                                    // result 为 nil，即遍历相片或视频完毕，可以展示资源列表
                                    if (weakSelf.modelArray.count > 0) return ;
                                    weakSelf.modelArray = modelArray;
                                }
                            }];
                        }
                    }
                    [self.collectionView reloadData];
                } else {
                    // 没有任何有资源的相册，输出提示
                }
            }
        } failureBlock:^(NSError *error) {
            NSLog(@"Asset group not found!\n");
        }];
    }
}
#pragma mark -  通知
- (void)tongzhi:(NSNotification *)aNotification{
    NSDictionary *info = [aNotification userInfo];
    NSArray *array = [info objectForKey:@"assets"];
    [self.delegate assetPickerController:self didFinishPickingAssets:array];
}
#pragma mark - 初始化
-(void)chushihua{
    self.navigationItem.title = @"发送图片"; //设置nav标题
    self.navigationItem.titleView.tintColor = [UIColor colorWithRed:65.0/255.0 green:153.0/255.0 blue:228.0/255.0 alpha:0.0];
    //设置返回按钮
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 34, 34)];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"back_nor.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(dianjifanhui) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItems = @[leftBarItem];
    //设置发送按钮
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleBordered target:self action:@selector(dianjifasong)];
    [rightBtn setTintColor:[UIColor colorWithRed:53/255.0 green:133/255.0 blue:221/255.0 alpha:1]];
    self.navigationItem.rightBarButtonItem = rightBtn;
    if (self.xuanzheArray.count > 0) {
        NSString *set = [NSString stringWithFormat:@"发送(%d)",self.xuanzheArray.count];
        [rightBtn setTitle:set];
        rightBtn.enabled = YES;
    }else{
        rightBtn.enabled = NO;
    }
    self.barbtn = rightBtn;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64) collectionViewLayout:[[MLCollectionViewFlowLayout alloc] init]];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [collectionView registerNib:[UINib nibWithNibName:@"MLChoiceImageCell" bundle:nil] forCellWithReuseIdentifier:ID];
    collectionView.backgroundColor = [UIColor whiteColor];
    //设置额外的滚动区域
    collectionView.contentInset = UIEdgeInsetsMake(0, 0, ewai, 0);
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    
    //底部选择相册
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - ewai - 64, self.view.frame.size.width, ewai)];
    imageView.backgroundColor = [UIColor whiteColor];
    imageView.userInteractionEnabled = YES;
    //选择相册
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 100, 40)];
    [btn setBackgroundImage:[UIImage resizedImageWithName:@"write_sms_bg_pre"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage resizedImageWithName:@"write_sms_bg_pre"] forState:UIControlStateHighlighted];
    [btn setTitle:@"选择相册" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithRed:53/255.0 green:133/255.0 blue:221/255.0 alpha:1] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(dianjixuanzhexiangche) forControlEvents:UIControlEventTouchUpInside];
    //线
    UIView *xian = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 1)];
    xian.backgroundColor = [UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:1];
    [imageView addSubview:xian];
    [imageView addSubview:btn];
    [self.view addSubview:imageView];
    
    if (self.isquanxian == YES) {
        // 展示提示语没有限权
        NSDictionary *mainInfoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString *appName = [mainInfoDictionary objectForKey:@"CFBundleDisplayName"];
        NSString *tipTextWhenNoPhotosAuthorization = [NSString stringWithFormat:@"请在设备的\"设置-隐私-照片\"选项中，允许%@访问你的手机相册", appName];
        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(25, 100, self.view.frame.size.width - 50 , 200)];
        lable.text = tipTextWhenNoPhotosAuthorization;
        lable.textAlignment = NSTextAlignmentCenter;
        lable.numberOfLines = 0;
        [self.view addSubview:lable];
    }
}
#pragma mark - 点击发送
-(void)dianjifasong{
    NSMutableArray *mutableArray = [NSMutableArray array];
    for (int i = 0; i < self.xuanzheArray.count; i++) {
        MLChoiceModel *model = self.xuanzheArray[i];
        [mutableArray addObject:model.asset];
    }
    NSArray *array = (NSArray *)mutableArray;
    [self.delegate assetPickerController:self didFinishPickingAssets:array];
}
#pragma mark - 点击返回
-(void)dianjifanhui{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.modelArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MLChoiceImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    MLChoiceModel *model = self.modelArray[indexPath.row];
    cell.tag = indexPath.row;
    cell.delegate = self;
    cell.imageView.image = [UIImage imageWithCGImage:model.asset.thumbnail];
    cell.asset = model.asset;
    cell.xuanzheBtn.selected = model.isSelected;
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MLLeafletPictureController *leaflet = [[MLLeafletPictureController alloc] init];
    leaflet.modelArray = self.modelArray;
    leaflet.xuanzheArray = self.xuanzheArray;
    leaflet.ShowSeat = indexPath.row;
    leaflet.SelectNumber = self.SelectNumber;
    [self.navigationController pushViewController:leaflet animated:YES];
}
#pragma mark - 点击相册
-(void)dianjixuanzhexiangche{
    MLChoiceAlbumController *choice = [[MLChoiceAlbumController alloc] init];
    choice.albumsArray = self.albumsArray;
    choice.ap = self;
    self.modelArray = nil;
    self.xuanzheArray = nil;
    [self.navigationController pushViewController:choice animated:YES];
}
#pragma mark - cell代理方法
-(void)xuanzhedezhaopian:(MLChoiceButton *)btn andCell:(MLChoiceImageCell *)cell{
    UICollectionView *collection = (UICollectionView *)cell.superview;
    NSIndexPath *index = [collection indexPathForCell:cell];
    if (btn.selected == YES) {//取消
        btn.selected = NO;
        MLChoiceModel *model = self.modelArray[index.row];
        model.isSelected = NO;
        [self.xuanzheArray removeObjectAtIndex:model.yixuanMark];
        for (int i = 0; i < self.xuanzheArray.count ; i++) {
            MLChoiceModel *ModelA = self.xuanzheArray[i];
            if (ModelA.yixuanMark > model.yixuanMark) {
                ModelA.yixuanMark = ModelA.yixuanMark - 1;
            }
        }
    }else{//选中
        //判断选中张数
        if (self.SelectNumber) {//设置了数字
            if (self.xuanzheArray.count == self.SelectNumber ) {//弹框提示
                [self tangkuang:self.SelectNumber];
                return ;
            }
        }else{//默认9张
            if (self.xuanzheArray.count == self.SelectNumber ) {//弹框提示
                [self tangkuang:9];
                return ;
            }
        }
        btn.selected = YES;
        MLChoiceModel *model = self.modelArray[index.row];
        model.isSelected = YES;
        model.yixuanMark = self.xuanzheArray.count;
        [self.xuanzheArray addObject:model];
    }
    if (self.xuanzheArray.count == 0) {
        [self.barbtn setTitle:@"发送"];
        self.barbtn.enabled = NO;
    }else{
        NSString *str = [NSString stringWithFormat:@"发送(%d)",self.xuanzheArray.count];
        [self.barbtn setTitle:str];
        self.barbtn.enabled = YES;
    }
}

#pragma mark - 弹框提示
-(void)tangkuang:(NSInteger)ger{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        NSString *str = [NSString stringWithFormat:@"你最多只能选择%d张",ger];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:str message:nil preferredStyle:UIAlertViewStyleSecureTextInput];
        // 设置popover指向的item
        alert.popoverPresentationController.barButtonItem = self.navigationItem.leftBarButtonItem;
        // 添加按钮
        [alert addAction:[UIAlertAction actionWithTitle:@"我知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        }]];
        [self presentViewController:alert animated:YES completion:nil];
    }else{
        NSString *str = [NSString stringWithFormat:@"你最多只能选择%d张",ger];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:str message:nil delegate:self cancelButtonTitle:@"我知道了" otherButtonTitles:nil];
        alert.alertViewStyle = UIAlertViewStyleSecureTextInput;
        [alert show];
    }
}
-(void)dealloc
{
    NSLog(@"MLChatViewController -- dealloc");
}
@end

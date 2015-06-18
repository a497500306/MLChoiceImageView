//
//  MLLeafletPictureController.m
//  JTTXLV2
//
//  Created by a on 15-6-1.
//
//

#import "MLLeafletPictureController.h"
#import "MLLeafletPictureLayout.h"
#import "MLLeafletPictureCell.h"
#import "UIImage+Extension.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import "MLPhotoView.h"
#import "MLChoiceModel.h"
#import "MLAssetPickerController.h"
#if !__has_feature(objc_arc)
#error this file need set arc
#endif

@interface MLLeafletPictureController()<UICollectionViewDataSource, UICollectionViewDelegate,MLAssetPickerControllerDelegate>
/**
 *  头部View
 */
@property (nonatomic, weak) UIView *headView;
/**
 *  底部View
 */
@property (nonatomic, weak) UIView *belowView;
@property (nonatomic, weak) UICollectionView *collectionView;
/**
 *  选择Btn
 */
@property (nonatomic, weak) UIButton *xuanzheBtn;
/**
 *  发送Btn
 */
@property (nonatomic, weak) UIButton *fasongBtn;
@property (nonatomic, strong)UIImage *resolutionImage;
@property (nonatomic, strong)UIImage *screenImage;
/**
 *  当前Cell的indexPath;
 */
@property (nonatomic, strong)NSIndexPath *indexPath;
@end

@implementation MLLeafletPictureController
-(UIImage *)resolutionImage{
    if (_resolutionImage == nil) {
        _resolutionImage = [[UIImage alloc] init];
        return _resolutionImage;
    }
    return _resolutionImage;
}
-(UIImage *)screenImage{
    if (_screenImage == nil) {
        _screenImage = [[UIImage alloc] init];
        return _screenImage;
    }
    return _screenImage;
}
-(void)viewDidLoad{
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = YES;
    //隐藏navigationContoller
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    //初始化
    [self chushihua];

}
#pragma mark - 内存警告
-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
#pragma mark - 界面完全显示时调用
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(danji) name:@"MLPhotoBrowser_SingleClick" object:nil];
}
#pragma mark - 监听单击通知
-(void)danji{
    if (self.headView.frame.origin.y == 0) {
        __weak typeof(self) weakSelf = self;
        [UIView animateWithDuration:0.3 animations:^{
            weakSelf.headView.frame = CGRectMake(0, -64, self.view.frame.size.width, 64);
            weakSelf.belowView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height,  [UIScreen mainScreen].bounds.size.width, 44);
        }];
    }else{
        __weak typeof(self) weakSelf = self;
        [UIView animateWithDuration:0.3 animations:^{
            weakSelf.headView.frame = CGRectMake(0, 0, self.view.frame.size.width, 64);
            weakSelf.belowView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 44,  [UIScreen mainScreen].bounds.size.width, 44);
        }];
    }
}
#pragma mark - 初始化
-(void)chushihua{
    //设置返回按钮
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 34, 34)];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"back_nor.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(dianjifanhui) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItems = @[leftBarItem];
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(-10, 0, self.view.frame.size.width+20, self.view.frame.size.height) collectionViewLayout:[[MLLeafletPictureLayout alloc] init]];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [collectionView registerClass:[MLLeafletPictureCell class] forCellWithReuseIdentifier:@"cell"];
    collectionView.backgroundColor = [UIColor whiteColor];
    //默认位子
    NSIndexPath* indexPath1 = [NSIndexPath indexPathForItem:self.ShowSeat inSection:0];
    [collectionView scrollToItemAtIndexPath:indexPath1 atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    //设置额外的滚动区域
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    //创建头部
    UIView *touView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    touView.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:0.8];
    //线
    UIView *xian = [[UIView alloc] initWithFrame:CGRectMake(0, 63, self.view.frame.size.width, 0.5)];
    xian.backgroundColor = [UIColor colorWithRed:182/255.0 green:182/255.0 blue:182/255.0 alpha:1];
    [touView addSubview:xian];
    //创建返回按钮
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(15, 25, 34, 34)];
    [btn setBackgroundImage:[UIImage imageNamed:@"back_nor.png"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(dianjifanhui) forControlEvents:UIControlEventTouchUpInside];
    [touView addSubview:btn];
    //创建选择按钮
    UIButton *xuanzheBtn = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 15 - 34, 25, 34, 34)];
    [xuanzheBtn setImage:[UIImage imageNamed:@"xc_agreement_unchecked"] forState:UIControlStateNormal];
    [xuanzheBtn setImage:[UIImage imageNamed:@"xc_agreement_checked"] forState:UIControlStateSelected];
    [xuanzheBtn addTarget:self action:@selector(dianjixuanzhe:) forControlEvents:UIControlEventTouchUpInside];
    self.xuanzheBtn = xuanzheBtn;
    [touView addSubview:xuanzheBtn];
    [self.view addSubview:touView];
    self.headView = touView;
    //创建底部
    UIView *diView = [[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 44, [UIScreen mainScreen].bounds.size.width, 44)];
    diView.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:0.8];
    //线
    UIView *diXian = [[UIView alloc] initWithFrame:CGRectMake(0, 1, self.view.frame.size.width, 0.5)];
    diXian.backgroundColor = [UIColor colorWithRed:182/255.0 green:182/255.0 blue:182/255.0 alpha:1];
    [diView addSubview:diXian];
    //创建发送按钮
    UIButton *diBtn = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 68 - 15, 5, 68, 34)];
    NSString *str;
    if (self.xuanzheArray.count > 0) {
        str = [NSString stringWithFormat:@"发送(%d)",self.xuanzheArray.count];
        [diBtn setTitle:str forState:UIControlStateNormal];
        diBtn.enabled = YES;
    }else{
        [diBtn setTitle:@"发送" forState:UIControlStateNormal];
        diBtn.enabled = NO;
    }
    [diBtn setTitleColor:[UIColor colorWithRed:53/255.0 green:133/255.0 blue:221/255.0 alpha:1] forState:UIControlStateNormal];
    [diBtn setTitleColor:[UIColor colorWithRed:193/255.0 green:193/255.0 blue:193/255.0 alpha:1] forState:UIControlStateDisabled];
    [diBtn addTarget:self action:@selector(dianjifasong) forControlEvents:UIControlEventTouchUpInside];
    [diView addSubview:diBtn];
    self.fasongBtn = diBtn;
    [self.view addSubview:diView];
    self.belowView = diView;
}
#pragma mark - 点击选择
-(void)dianjixuanzhe:(UIButton *)btn{
    if (btn.selected == YES) {//取消
        btn.selected = NO;
        MLChoiceModel *model = self.modelArray[self.indexPath.row];
        model.isSelected = NO;
        [self.xuanzheArray removeObjectAtIndex:model.yixuanMark];
        for (int i = 0; i < self.xuanzheArray.count ; i++) {
            MLChoiceModel *ModelA = self.xuanzheArray[i];
            if (ModelA.yixuanMark > model.yixuanMark) {
                ModelA.yixuanMark = ModelA.yixuanMark - 1;
            }
        }
        [self.collectionView reloadData];
    }else{//选择
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
        MLChoiceModel *model = self.modelArray[self.indexPath.row];
        model.isSelected = YES;
        model.yixuanMark = self.xuanzheArray.count;
        [self.xuanzheArray addObject:model];
    }
    if (self.xuanzheArray.count == 0) {
        [self.fasongBtn setTitle:@"发送" forState:UIControlStateNormal];
        self.fasongBtn.enabled = NO;
    }else{
        NSString *str = [NSString stringWithFormat:@"发送(%d)",self.xuanzheArray.count];
        [self.fasongBtn setTitle:str forState:UIControlStateNormal];
        self.fasongBtn.enabled = YES;
    }
    [self.collectionView reloadData];
}
#pragma mark - 弹框提示
-(void)tangkuang:(NSInteger)ger{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        NSString *str = [NSString stringWithFormat:@"你最多只能选择%d张",ger];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:str message:nil preferredStyle:UIAlertViewStyleSecureTextInput];
        // 设置popover指向的item
        alert.popoverPresentationController.barButtonItem = self.navigationItem.leftBarButtonItem;
        // 添加按钮
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
            NSLog(@"点击了确定按钮");
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            NSLog(@"点击了取消按钮");
        }]];
        [self presentViewController:alert animated:YES completion:nil];
    }else{
        NSString *str = [NSString stringWithFormat:@"你最多只能选择%d张",ger];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:str message:nil delegate:self cancelButtonTitle:@"我知道了" otherButtonTitles:nil];
        alert.alertViewStyle = UIAlertViewStyleSecureTextInput;
        [alert show];
    }
}
#pragma mark - 点击发送
-(void)dianjifasong{
    NSMutableArray *mutableArray = [NSMutableArray array];
    for (int i = 0; i < self.xuanzheArray.count; i++) {
        MLChoiceModel *model = self.xuanzheArray[i];
        [mutableArray addObject:model.asset];
    }
    NSArray *array = array = (NSArray *)mutableArray;
    //传通知
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    NSDictionary * dict = @{@"assets":array};
    [center postNotificationName:@"MLLeafletPictureController_Send" object:self userInfo:dict];
}
#pragma mark - 点击返回
-(void)dianjifanhui{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.modelArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.indexPath = indexPath;
    MLLeafletPictureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    MLChoiceModel *model = self.modelArray[indexPath.row];
    ALAsset *asset = model.asset;
    ALAssetRepresentation* representation = [asset defaultRepresentation];
    @autoreleasepool {
        self.screenImage = [UIImage imageWithCGImage:representation.fullScreenImage];
        if (self.screenImage.size.height / self.screenImage.size.width > 3||self.screenImage.size.width /self.screenImage.size.height > 3) {
            self.resolutionImage = [UIImage imageWithCGImage:representation.fullResolutionImage];
            [cell imageViewFarme:[UIScreen mainScreen].bounds andImage:self.resolutionImage];
        }else{
            [cell imageViewFarme:[UIScreen mainScreen].bounds andImage:self.screenImage];
        }
    }
    self.xuanzheBtn.selected = model.isSelected;
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.view.bounds.size.width+20, self.view.bounds.size.height);
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"MLLeafletPictureController -- dealloc");
}
- (BOOL)prefersStatusBarHidden{
    return YES;
}
@end
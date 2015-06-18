//
//  MLLeafletPictureLayout.m
//  JTTXLV2
//
//  Created by a on 15-6-1.
//
//

#import "MLLeafletPictureLayout.h"
#if !__has_feature(objc_arc)
#error this file need set arc
#endif
@implementation MLLeafletPictureLayout
/**
 *  一些初始化工作最好在这里实现
 */
- (void)prepareLayout
{
    [super prepareLayout];
    // 每个cell的尺寸
    self.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    // 设置水平滚动
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //设置间距
    self.minimumLineSpacing = 0;
    //分页
    self.collectionView.pagingEnabled = YES;
    //显示指示器
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
}

@end

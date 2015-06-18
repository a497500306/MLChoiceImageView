//
//  MLCollectionViewFlowLayout.m
//  JTTXLV2
//
//  Created by a on 15-5-29.
//
//

#import "MLCollectionViewFlowLayout.h"
#if !__has_feature(objc_arc)
#error this file need set arc
#endif
@implementation MLCollectionViewFlowLayout
/**
 *  一些初始化工作最好在这里实现
 */
- (void)prepareLayout
{
    [super prepareLayout];
    // 每个cell的尺寸
    self.itemSize = CGSizeMake(([UIScreen mainScreen].bounds.size.width - 40) /4, ([UIScreen mainScreen].bounds.size.width -40)/4);
    self.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    self.minimumLineSpacing = 5;
    // 每一个cell(item)都有自己的UICollectionViewLayoutAttributes
    // 每一个indexPath都有自己的UICollectionViewLayoutAttributes
}
/**
 *  只要显示的边界发生改变就重新布局:
 内部会重新调用prepareLayout和layoutAttributesForElementsInRect方法获得所有cell的布局属性
 */
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}
@end

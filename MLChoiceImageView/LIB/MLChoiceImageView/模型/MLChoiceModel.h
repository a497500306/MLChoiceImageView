//
//  MLChoiceModel.h
//  JTTXLV2
//
//  Created by a on 15-6-1.
//
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>

@interface MLChoiceModel : NSObject
/**
 *  存放在数组的位置
 */
@property (nonatomic, assign)NSInteger mark;
/**
 *  存放在已选数组的位置
 */
@property (nonatomic, assign)NSInteger yixuanMark;
/**
 *  是否被选中
 */
@property (nonatomic, assign)BOOL isSelected;
/**
 *  图片属性
 */
@property (nonatomic, strong)ALAsset *asset;
@end

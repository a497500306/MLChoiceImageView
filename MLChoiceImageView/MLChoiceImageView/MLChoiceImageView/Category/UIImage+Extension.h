//
//  UIImage+Extension.h
//  01-QQ聊天布局
//
//  Created by apple on 14-4-2.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)
+ (UIImage *)resizableImage:(NSString *)name;
/**
 *  固定方向
 */
- (UIImage *)fixOrientation ;
/**
 *  自动缩放到指定大小
 */
- (UIImage *)thumbnailWithImage:(UIImage *)image size:(CGSize)asize;
/**
 *  保持原来的长宽比，生成一个缩略图
 */
- (UIImage *)thumbnailWithImageWithoutScale:(UIImage *)image size:(CGSize)asize;
@end
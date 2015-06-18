//
//  MLLeafletPictureCell.m
//  JTTXLV2
//
//  Created by a on 15-6-1.
//
//

#import "MLLeafletPictureCell.h"
#import "MLPhotoView.h"
#if !__has_feature(objc_arc)
#error this file need set arc
#endif
@interface MLLeafletPictureCell()
@property(nonatomic, weak)MLPhotoView *imageView;
@end

@implementation MLLeafletPictureCell
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
}
-(void)imageViewFarme:(CGRect)rect andImage:(UIImage *)image
{
    [self.imageView removeFromSuperview];
    NSLog(@"%@",self.imageView);
    MLPhotoView *imageView = [[MLPhotoView alloc] initWithFrame:CGRectMake(rect.origin.x,0, rect.size.width + 20 , rect.size.height) andImage:image];
    imageView.autoresizingMask = (1 << 6) -1;
    self.imageView = imageView;
    [self addSubview:self.imageView];
}
-(void)dealloc
{
    NSLog(@"MLLeafletPictureCell -- dealloc");
}
@end

//
//  MLChoiceButton.m
//  JTTXLV2
//
//  Created by a on 15-5-29.
//
//

#import "MLChoiceButton.h"
#if !__has_feature(objc_arc)
#error this file need set arc
#endif
@implementation MLChoiceButton
-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    return CGRectMake(14, 2, 16, 16);
}
-(void)dealloc
{
    NSLog(@"MLChoiceButton -- dealloc");
}
@end

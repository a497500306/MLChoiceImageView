//
//  MLChoiceImageCell.m
//  JTTXLV2
//
//  Created by a on 15-5-29.
//
//

#import "MLChoiceImageCell.h"
#import "MLChoiceButton.h"
#import "MLChoiceModel.h"
#if !__has_feature(objc_arc)
#error this file need set arc
#endif
@interface MLChoiceImageCell()
@end

@implementation MLChoiceImageCell
- (void)awakeFromNib {
    [self.xuanzheBtn addTarget:self action:@selector(dianjiXuanzheBtn:) forControlEvents:UIControlEventTouchUpInside];
    
}
#pragma mark - 点击选择
-(void)dianjiXuanzheBtn:(MLChoiceButton *)btn{
    btn.tag = self.tag;
    [self.delegate xuanzhedezhaopian:btn andCell:self];
}
-(void)dealloc
{
    NSLog(@"MLChoiceImageCell -- dealloc");
}
@end
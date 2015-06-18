//
//  MLChoiceImageCell.h
//  JTTXLV2
//
//  Created by a on 15-5-29.
//
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
@class MLChoiceButton;
@class MLChoiceImageCell;
@protocol  MLChoiceImageCellDelegate <NSObject>
@optional
-(void)xuanzhedezhaopian:(MLChoiceButton *)btn andCell:(MLChoiceImageCell *)cell;
@end

@interface MLChoiceImageCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet MLChoiceButton *xuanzheBtn;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, strong)ALAsset *asset;
@property (nonatomic, strong) id<MLChoiceImageCellDelegate> delegate;
@end

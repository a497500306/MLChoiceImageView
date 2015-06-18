//
//  MLChoiceImageView.h
//  JTTXLV2
//
//  Created by a on 15-5-29.
//
//

#import <UIKit/UIKit.h>

@class PHAssetCollection;
@class MLAssetPickerController;
@class ALAssetsGroup;
@protocol  MLAssetPickerControllerDelegate <NSObject>
@optional
-(void)assetPickerController:(MLAssetPickerController *)picker didFinishPickingAssets:(NSArray *)assets;
@end
@interface MLAssetPickerController : UIViewController
/**
 *  最多选择张数,默认9张
 */
@property (nonatomic, assign) NSInteger SelectNumber;
/**
 *  是否是点击选择相册后
 */
@property (nonatomic, assign) BOOL isXuanzheImage;
@property (nonatomic, strong) ALAssetsGroup *assetsGroup;
@property (nonatomic, strong) id<MLAssetPickerControllerDelegate> delegate;

@end

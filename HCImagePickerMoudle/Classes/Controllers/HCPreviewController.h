//
//  HCPreviewController.h
//  ImagePicker
//
//  Created by yinhaichao on 2017/9/26.
//  Copyright © 2017年 VRSeen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
@class HCImage;
/**
 图片选择block

 @param selected 选择状态
 */
typedef void(^ImageSelectedBlock)(BOOL selected);

@interface HCPreviewController : UIViewController

/**
 资源
 */
@property (nonatomic, strong) HCImage *image;

/**
 图片选择block
 */
@property (nonatomic, copy) ImageSelectedBlock imageSelectedBlock;

@end

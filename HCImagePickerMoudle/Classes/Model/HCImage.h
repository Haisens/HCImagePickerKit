//
//  HCImage.h
//  ImagePicker
//
//  Created by yinhaichao on 2017/9/26.
//  Copyright © 2017年 VRSeen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

@interface HCImage : NSObject

/**
 选中状态
 */
@property (nonatomic, assign) BOOL selected;

/**
 资源
 */
@property (nonatomic, strong) PHAsset *asset;

@end

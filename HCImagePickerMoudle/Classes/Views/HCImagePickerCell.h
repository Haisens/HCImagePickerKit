//
//  HCImagePickerCell.h
//  ImagePicker
//
//  Created by yinhaichao on 2017/9/26.
//  Copyright © 2017年 VRSeen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCImage.h"

/**
 图片选择样式
 
 - HCCellSelectedStyleNone: 无选中按钮(只能选择一张照片)
 - HCCellSelectedStyleTopRightCorner: 选中按钮在右上角（默认为右上角）
 - HCCellSelectedStyleTopLeftCorner: 选中按钮在左上角
 - HCCellSelectedStyleBottomRightCorner: 选中按钮在右下角
 - HCCellSelectedStyleBottomLeftCorner: 选中按钮在左下角
 */
typedef NS_OPTIONS(NSInteger, HCCellSelectedStyle) {
    HCCellPickerSelectedStyleNone,
    HCCellPickerSelectedStyleTopRightCorner,
    HCCellPickerSelectedStyleTopLeftCorner,
    HCCellPickerSelectedStyleBottomRightCorner,
    HCCellPickerSelectedStyleBottomLeftCorner
};

typedef void(^ButtonClickedBlock)(BOOL selected);
/**
 图片选择状态

 - HCImagePickerCellStateSelected: 选中状态
 - HCImagePickerCellStateNone: 未选中状态
 */
typedef NS_OPTIONS(NSInteger, HCImagePickerCellState) {
    
    HCImagePickerCellStateNone,
    HCImagePickerCellStateSelected
};

/**
 HCImagePicker样式

 - HCImagePickerModelDefault: cell默认样式
 - HCImagePickerModelCustom: cell自定义样式
 */
typedef NS_OPTIONS(NSInteger, HCImagePickerStyle) {
    
    HCImagePickerStyleDefault,
    HCImagePickerStyleCustom
};

@interface HCImagePickerCell : UICollectionViewCell

/**
 cell缩略图
 */
@property (nonatomic, strong) UIImageView *imageView;

/**
 选择状态按钮
 */
@property (nonatomic, strong) UIButton *selectButton;

/**
 数据模型
 */
@property (nonatomic, strong) HCImage *image;

/**
 button图片
 */
@property (nonatomic, strong) UIImage *buttonImage;

/**
 选中后的button图片
 */
@property (nonatomic, strong) UIImage *buttonSelectedImage;

/**
 选中按钮点击block
 */
@property (nonatomic, copy) ButtonClickedBlock buttonClickedBlock;

/**
 cell选中样式
 */
@property (nonatomic, assign) HCCellSelectedStyle cellSelectedStyle;

/**
 图片最大选择数
 */
@property (nonatomic, assign) NSInteger maxNum;

@end

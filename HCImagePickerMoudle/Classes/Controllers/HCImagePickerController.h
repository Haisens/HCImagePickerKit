//
//  HCImagePickerController.h
//  ImagePicker
//
//  Created by yinhaichao on 2017/9/26.
//  Copyright © 2017年 VRSeen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

/**
 图片选择样式

 - HCImagePickerSelectedStyleNone: 无选中按钮(只能选择一张照片)
 - HCImagePickerSelectedStyleTopRightCorner: 选中按钮在右上角（默认为右上角）
 - HCImagePickerSelectedStyleTopLeftCorner: 选中按钮在左上角
 - HCImagePickerSelectedStyleBottomRightCorner: 选中按钮在右下角
 - HCImagePickerSelectedStyleBottomLeftCorner: 选中按钮在左下角
 */
typedef NS_OPTIONS(NSInteger, HCImagePickerSelectedStyle) {
    HCImagePickerSelectedStyleNone,
    HCImagePickerSelectedStyleTopRightCorner,
    HCImagePickerSelectedStyleTopLeftCorner,
    HCImagePickerSelectedStyleBottomRightCorner,
    HCImagePickerSelectedStyleBottomLeftCorner
};

/**
 HCImagePickerController代理方法
 */
@protocol HCImagePickerControllerDelegate <NSObject>

/**
 选择完成时回掉，返回image数组

 @param images image数组
 */
- (void)didFinishedSelectImages:(NSArray <UIImage *>*)images;

/**
 选择完成时回掉，返回asset数组

 @param assets asset数组
 */
- (void)didFinishedSelectAssets:(NSArray <PHAsset *>*)assets;

@end

@interface HCImagePickerController : UIViewController

/**
 设置多选图片最大数(默认为4)
 */
@property (nonatomic, assign) NSInteger maxNum;

/**
 选定按钮位置（默认为右上角）
 */
@property (nonatomic, assign) HCImagePickerSelectedStyle selectedStyle;

/**
 HCImagePickerController代理
 */
@property (nonatomic, weak) id <HCImagePickerControllerDelegate> delegate;

- (instancetype)initWithSelectedStyle:(HCImagePickerSelectedStyle)selectedStyle;

@end


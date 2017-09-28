//
//  HCImagePickerCell.m
//  ImagePicker
//
//  Created by yinhaichao on 2017/9/26.
//  Copyright © 2017年 VRSeen. All rights reserved.
//

#import "HCImagePickerCell.h"
#import <Photos/Photos.h>

#define ButtonWidth self.bounds.size.width/3

@interface HCImagePickerCell ()

/**
 已选择图片数
 */
@property (nonatomic, assign) NSInteger num;
@end

@implementation HCImagePickerCell

#pragma mark
#pragma mark -- 初始化／初始化UI
/**
 初始化button
 */
- (void)initButton {
    
    if (!_cellSelectedStyle) {
        return;
    }
    self.selectButton.selected = _image.selected;
    [self.selectButton setImage:[UIImage imageNamed:@"gou"] forState:UIControlStateNormal];
    [self.selectButton setImage:[UIImage imageNamed:@"gouS"] forState:UIControlStateSelected];
}

/**
 初始化imageView
 */
- (void)initImageView {
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    // 同步获得图片, 只会返回1张图片
    options.synchronous = YES;
    @autoreleasepool {
        // 从asset中获得图片
        PHImageManager *imageManager = [PHImageManager defaultManager];
        [imageManager requestImageForAsset:_image.asset targetSize:CGSizeZero contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            // result为获得的图片
            self.imageView.image = result;
        }];
    }
}

/**
 初始化cell
 */
- (void)initCell {
    [self initImageView];
}

#pragma mark
#pragma mark -- getter方法
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self.contentView addSubview:_imageView];
    }
    return _imageView;
}
/**
 懒加载selectButton

 @return selectButton
 */
- (UIButton *)selectButton {
    
    if (!_selectButton) {
        _selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        NSInteger i = 0,j = 0;
        switch (_cellSelectedStyle) {
            case HCCellPickerSelectedStyleTopRightCorner: {
                i = 1;
                j = 0;
            }
                break;
            case HCCellPickerSelectedStyleTopLeftCorner: {
                i = 0;
                j = 0;
            }
                break;
            case HCCellPickerSelectedStyleBottomRightCorner: {
                i = 1;
                j = 1;
            }
                break;
            case HCCellPickerSelectedStyleBottomLeftCorner: {
                i = 0;
                j = 1;
            }
                break;
            default:
                break;
        }
        _selectButton.frame = CGRectMake(2 * i * ButtonWidth, 2 * j * ButtonWidth, ButtonWidth, ButtonWidth);
        _selectButton.backgroundColor = [UIColor orangeColor];
        [_selectButton addTarget:self action:@selector(selectButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_selectButton];
    }
    return _selectButton;
}

#pragma mark
#pragma mark -- setter方法
- (void)setImage:(HCImage *)image {
    _image = image;
    [self initCell];
}

- (void)setCellSelectedStyle:(HCCellSelectedStyle)cellSelectedStyle {
    _cellSelectedStyle = cellSelectedStyle;
    [self initButton];
}

#pragma mark
#pragma mark -- 事件
/**
 勾选事件
 */
- (void)selectButtonClicked {
    
    if (_num == _maxNum) {
        [self alertShow];
    }
    _selectButton.selected = !_selectButton.selected;
    self.buttonClickedBlock(_selectButton.selected);
    if (_selectButton.selected) {
        _num++;
    } else {
        _num--;
    }
}

- (void)alertShow {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"你最多只能选择%ld张图片!", _maxNum] delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alertView show];
}

@end

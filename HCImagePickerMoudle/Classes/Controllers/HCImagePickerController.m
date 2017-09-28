//
//  HCImagePickerController.m
//  ImagePicker
//
//  Created by yinhaichao on 2017/9/26.
//  Copyright © 2017年 VRSeen. All rights reserved.
//

#import "HCImagePickerController.h"
#import "HCImagePickerCell.h"
#import "HCImage.h"
#import "HCPreviewController.h"

@interface HCImagePickerController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

/**
 图片管理
 */
@property (nonatomic, strong) PHImageManager *imageManager;

/**
 数据集合
 */
@property (nonatomic, copy) NSMutableArray <HCImage *>*dataArray;

/**
 选中图片集合
 */
@property (nonatomic, copy) NSMutableArray <UIImage *>* images;

/**
 选中asset集合
 */
@property (nonatomic, copy) NSMutableArray <PHAsset *>*assets;

/**
 collectionView
 */
@property (nonatomic, strong) UICollectionView *collectionView;

/**
 完成按钮
 */
@property (nonatomic, strong) UIButton *finishButton;
@end

@implementation HCImagePickerController

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

static NSString *cellID = @"cellIdentifier";
#pragma mark
#pragma mark -- 初始化方法
- (instancetype)initWithSelectedStyle:(HCImagePickerSelectedStyle)selectedStyle {
    if (self = [super init]) {
        _selectedStyle = selectedStyle;
        _maxNum = 4;
    }
    return self;
}

#pragma mark
#pragma mark -- 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUI];
    [self getOriginalImages];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark
#pragma mark -- 加载数据


#pragma mark -- 懒加载
- (PHImageManager *)imageManager {
    if (!_imageManager) {
        _imageManager = [PHImageManager defaultManager];
    }
    return _imageManager;
}

- (NSMutableArray<HCImage *> *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (NSMutableArray<UIImage *> *)images {
    if (!_images) {
        _images = [NSMutableArray array];
    }
    return _images;
}

- (NSMutableArray<PHAsset *> *)assets {
    if (!_assets) {
        _assets = [NSMutableArray array];
    }
    return _assets;
}

#pragma mark
#pragma mark -- 数据请求

/**
 *  遍历相簿中的所有图片
 *  @param assetCollection 相簿
 *  @param original        是否要原图
 */
- (void)enumerateAssetsInAssetCollection:(PHAssetCollection *)assetCollection original:(BOOL)original {
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    // 同步获得图片, 只会返回1张图片
    options.synchronous = YES;
    
    // 获得某个相簿中的所有PHAsset对象
    PHFetchResult<PHAsset *> *assets = [PHAsset fetchAssetsInAssetCollection:assetCollection options:nil];
    for (PHAsset *asset in assets) {
        HCImage *image = [[HCImage alloc] init];
        image.asset = asset;
        image.selected = NO;
        [self.dataArray addObject:image];
    }
    [_collectionView reloadData];
}

/**
 获得图片资源
 */
- (void)getOriginalImages {
    // 获得相机胶卷
    PHAssetCollection *cameraRoll = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil].lastObject;
    // 遍历相机胶卷,获取大图
    [self enumerateAssetsInAssetCollection:cameraRoll original:NO];
}

#pragma mark
#pragma mark -- 初始化UI

/**
 初始化UI
 */
- (void)initUI {
    self.view.backgroundColor = [UIColor whiteColor];
    [self initCollectionView];
}

/**
 初始化collectionView
 */
- (void)initCollectionView {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake((SCREEN_WIDTH - 25)/4, (SCREEN_WIDTH - 25)/4);
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:flowLayout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerClass:[HCImagePickerCell class] forCellWithReuseIdentifier:cellID];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self.view addSubview:_collectionView];
}

#pragma mark
#pragma mark -- 事件

/**
 用户选择完成
 */
- (void)finishButtonClicked {
    if (self.delegate != nil) {
        [self.delegate didFinishedSelectAssets:_assets];
        [self.delegate didFinishedSelectImages:_images];
    }
}

#pragma mark
#pragma mark -- collectionView代理

/**
 返回每个section的item个数
 */
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    HCImagePickerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.cellSelectedStyle = (HCCellSelectedStyle)_selectedStyle;
    cell.image = self.dataArray[indexPath.row];
    cell.buttonClickedBlock = ^(BOOL selected) {
        _dataArray[indexPath.row].selected = selected;
    };
    cell.backgroundColor = [UIColor yellowColor];
    
    return cell;
}

/**
 设置每个item的UIEdgeInsets
 */
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

/**
 设置每个item水平间距
 */
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 5;
}

/**
 设置每个item垂直间距
 */
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 5;
}

/**
 点击item方法
 */
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    HCPreviewController *previewVC = [[HCPreviewController alloc] init];
    previewVC.image = self.dataArray[indexPath.row];
    __weak HCImagePickerController *blockSelf = self;
    previewVC.imageSelectedBlock = ^(BOOL selected) {
        _dataArray[indexPath.row].selected = selected;
        [blockSelf.collectionView reloadData];
        if (selected) {
            [blockSelf.assets addObject:_dataArray[indexPath.row].asset];
        } else {
            [blockSelf.assets removeObject:_dataArray[indexPath.row].asset];
        }
        
    };
    [self presentViewController:previewVC animated:YES completion:nil];
}

#pragma mark
#pragma mark -- 业务逻辑

/**
 设置最大选择数

 @param maxNum 最大选择数
 */
- (void)setMaxNum:(NSInteger)maxNum {
    _maxNum = maxNum;
}

/**
 设置图片选中样式

 @param selectedStyle 图片选中样式
 */

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

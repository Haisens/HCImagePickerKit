//
//  HCPreviewController.m
//  ImagePicker
//
//  Created by yinhaichao on 2017/9/26.
//  Copyright © 2017年 VRSeen. All rights reserved.
//

#import "HCPreviewController.h"
#import "HCImage.h"

@interface HCPreviewController ()

/**
 预览图
 */
@property (nonatomic, strong) UIImageView *imageView;

/**
 右上按钮
 */
@property (nonatomic, strong) UIButton *rightButton;

/**
 顶部view
 */
@property (nonatomic, strong) UIView *topView;

/**
 底部view
 */
@property (nonatomic, strong) UIView *bottomView;

/**
 底部按钮
 */
@property (nonatomic, strong) UIButton *bottomButton;

/**
 已选择图片数
 */
@property (nonatomic, assign) NSInteger num;
@end

@implementation HCPreviewController

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#pragma mark
#pragma mark -- 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadData];
    [self initUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark
#pragma mark -- 数据加载
- (void)loadData {
    _num = [[[NSUserDefaults standardUserDefaults] valueForKey:@"imageNum"] integerValue];
}


#pragma mark
#pragma mark -- 初始化UI

/**
 初始化UI
 */
- (void)initUI {
    [self initImageView];
    [self initToolUI];
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
        __weak HCPreviewController *blockSelf = self;
        [imageManager requestImageForAsset:_image.asset targetSize:CGSizeMake(_image.asset.pixelWidth, _image.asset.pixelHeight) contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            // result为获得的图片
            blockSelf.imageView.image = result;
        }];
    }
}

/**
 初始化工具UI
 */
- (void)initToolUI {
    [self initTopView];
    [self initBottomView];
}

/**
 顶部UI
 */
- (void)initTopView {
    _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    _topView.backgroundColor = [UIColor blackColor];
    _topView.alpha = 0.8;
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(15, 20, 30, 30);
    [leftButton setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightButton.selected = _image.selected;
    _rightButton.frame = CGRectMake(SCREEN_WIDTH - 45, 20, 30, 30);
    [_rightButton setImage:[UIImage imageNamed:@"gou"] forState:UIControlStateNormal];
    [_rightButton setImage:[UIImage imageNamed:@"gouS"] forState:UIControlStateSelected];
    [_rightButton addTarget:self action:@selector(rightButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [_topView addSubview:leftButton];
    [_topView addSubview:_rightButton];
    [self.view addSubview:_topView];
}

/**
 底部UI
 */
- (void)initBottomView {
    _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 49, SCREEN_WIDTH, 49)];
    _bottomView.backgroundColor = [UIColor blackColor];
    _bottomView.alpha = 0.8;
    _bottomButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _bottomButton.frame = CGRectMake(SCREEN_WIDTH - 75, 15, 60, 30);
    _bottomButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [_bottomButton setTitle:[NSString stringWithFormat:@"确定(%ld)", _num] forState:UIControlStateNormal];
    [_bottomButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [_bottomButton addTarget:self action:@selector(bottomButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:_bottomButton];
    [self.view addSubview:_bottomView];
}
#pragma mark
#pragma mark -- 事件

/**
 返回事件
 */
- (void)leftButtonClicked {
    [self dismissViewControllerAnimated:YES completion:^{
        [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%ld", _num] forKey:@"imageNum"];
    }];
}

/**
 选择／取消选择图片
 */
- (void)rightButtonClicked {
    _rightButton.selected = !_rightButton.selected;
    self.imageSelectedBlock(_rightButton.selected);
    if (_rightButton.selected) {
        _num++;
        [_bottomButton setTitle:[NSString stringWithFormat:@"确定(%ld)", _num] forState:UIControlStateNormal];
    } else {
        _num--;
        [_bottomButton setTitle:[NSString stringWithFormat:@"确定(%ld)", _num] forState:UIControlStateNormal];
    }
}

/**
 完成按钮
 */
- (void)bottomButtonClicked {
    NSLog(@"%s", __FUNCTION__);
}

#pragma mark
#pragma mark -- 代理


#pragma mark
#pragma mark -- 业务逻辑
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.view addSubview:_imageView];
        _imageView.backgroundColor = [UIColor blackColor];
    }
    return _imageView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

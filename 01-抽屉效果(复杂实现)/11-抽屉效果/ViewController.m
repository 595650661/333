//
//  ViewController.m
//  11-抽屉效果
//
//  Created by xiaomage on 15/6/16.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//


// 宏里面的#，会自动把后面的参数变成C语言的字符串
#define keyPath(objc,keyPath) @(((void)objc.keyPath,#keyPath))


// 宏的操作原理，每输入一个字母就会直接把宏右边的拷贝，并且会自动补齐前面的内容。

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, weak) UIView *mainV;
@property (nonatomic, weak) UIView *leftV;
@property (nonatomic, weak) UIView *rightV;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 添加子控件
    [self setUpChildView];
    // 添加Pan手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self.view addGestureRecognizer:pan];
}

- (void)setUpChildView {
    // left
    UIView *leftV = [[UIView alloc] initWithFrame:self.view.bounds];
    leftV.backgroundColor = [[UIColor greenColor] colorWithAlphaComponent:0.5];
    [self.view addSubview:leftV];
    _leftV = leftV;
    
    // right
    UIView *rightV = [[UIView alloc] initWithFrame:self.view.bounds];
    rightV.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:0.5];
    [self.view addSubview:rightV];
    _rightV = rightV;
    
    // main
    UIView *mainV = [[UIView alloc] initWithFrame:self.view.bounds];
    mainV.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.5];
    [self.view addSubview:mainV];
    _mainV = mainV;
}
#pragma mark - pan的方法
- (void)pan:(UIPanGestureRecognizer *)pan {
    // 获取手势的移动的位置
    CGPoint transP = [pan translationInView:self.view];
    // 获取X轴的偏移量
    CGFloat offsetX = transP.x;
    // 修改mainV的Frame
    _mainV.frame = [self frameWithOffsetX:offsetX];
    // 判断下mainV的x是否大于0
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];
    /* 这里必须复位，不然会叠加
     必须把形变设置为0，不然会因为不断调用这个方法，值会不断叠加，，
     例如从0 - 3的距离应该只移动3，但是却变1+2+3 = 6，移动了6的距离
     */
    [pan setTranslation:CGPointZero inView:self.view];
}

// 手指往右移动，视图X轴也要往右移动（x++），y轴往下移动（y增加），尺寸缩放（按比例）。
#define kMaxY 80
#pragma mark - 根据offsetX计算mainV的Frame
- (CGRect)frameWithOffsetX:(CGFloat)offsetX {
    // 获取上一次的frame
    CGRect frame = _mainV.frame;
    // 获取屏幕的高度
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    // X轴每平移一点，Y轴需要移动
    CGFloat offsetY = offsetX * kMaxY / screenH;
    // 获取上一次的高度
    CGFloat preH = frame.size.height;
    // 获取上一次的宽度
    CGFloat preW = frame.size.width;
    // 获取当前的高度
    CGFloat curH = preH - 2 * offsetY;
    if (frame.origin.x < 0) { // 往左移动
        curH = preH + 2 * offsetY;
    }
    // 获取尺寸的缩放比例
    CGFloat scale = curH / preH;
    // 获取当前的宽度
    CGFloat curW = preW * scale;
    // 更改frame
    // 获取当前X
    frame.origin.x += offsetX;
    // 获取当前Y
    CGFloat y = (screenH - curH) / 2;
    frame.origin.y = y;
    frame.size.height = curH;
    frame.size.width = curW;
    return frame;
}
// 只要监听的属性一改变，就会调用观察者的这个方法，通知你有新值
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSLog(@"%@",NSStringFromCGRect(_mainV.frame));
    if (_mainV.frame.origin.x > 0) { // 往右边移动，隐藏蓝色的view
        _rightV.hidden = YES;
    }else if (_mainV.frame.origin.x < 0){ // 往左边移动，显示蓝色的view
        _rightV.hidden = NO;
    }
}


@end

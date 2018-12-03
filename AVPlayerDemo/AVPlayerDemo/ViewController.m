//
//  ViewController.m
//  AVPlayerDemo
//
//  Created by 张诚 on 15/1/28.
//  Copyright (c) 2015年 zhangcheng. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
@interface ViewController ()
{
    AVPlayerItem*playerItem;
    AVPlayer*player;
    
    UIProgressView*progressView;
    UISlider*_slider;
    
    //判断slider是否按下
    BOOL isOpen;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    
    //进行初始创建
    NSURL*url=[NSURL URLWithString:@"https://cdn-ekwing-oss-new.ekwing.com/acpf/data/upload/base/2017/08/22/599bfce5eb417.mp4"];
    //创建item
    playerItem=[[AVPlayerItem alloc]initWithURL:url];
    //创建avplay
    player =[AVPlayer playerWithPlayerItem:playerItem];
    //生成layer层
    AVPlayerLayer*layer=[AVPlayerLayer playerLayerWithPlayer:player];
    //设置坐标
    layer.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    //把layer层加入到self.view中
    [self.view.layer addSublayer:layer];
    //进行播放
    [player play];
    
    
/******以上是基本播放界面，但是没有前进后退******************/
    //观察是否播放了 kvo进行观察 观察playerItem.status的属性
    [playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    
    //观察缓存现在的进度 kvo进行观察   观察playerItem.loadedTimeRanges属性
    [playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];

    
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    
    if ([keyPath isEqualToString:@"status"]) {
        /*
         AVPlayerStatusUnknown,
         AVPlayerStatusReadyToPlay,
         AVPlayerStatusFailed
         */
        
        if (playerItem.status==AVPlayerStatusReadyToPlay) {
            NSLog(@"开始播放");
            //需要开始获取数据，包括播放总时长 播放缓存 播放的当前时间
            [self loadData];
            
        }else{
            NSLog(@"播放失败");
        }
        
    }else{
    //kvo触发的另外一个属性
        NSArray*array=[playerItem loadedTimeRanges];
    //获取缓存范围
        CMTimeRange range=[array.firstObject CMTimeRangeValue];
    //获取从哪开始的
        CGFloat start=CMTimeGetSeconds(range.start);
    //缓存了多少
        CGFloat duration=CMTimeGetSeconds(range.duration);
    //一共缓存了多少
        CGFloat allCache=start+duration;
       // NSLog(@"缓存了多少数据~~~~%f",allCache);
        
    //设置缓存百分比
        CMTime allTime=[playerItem duration];
    //转换
        CGFloat time=CMTimeGetSeconds(allTime);
        CGFloat y=allCache/time;
       // NSLog(@"缓存百分比~~~%f",y);
        progressView.progress=y;
    
    }
}
#pragma mark 获取播放的数据
-(void)loadData{
    //第一个参数是每隔多久，调用一次，在这里设置的是每隔1秒调用一次
    __weak AVPlayerItem*xx=playerItem;
   __weak UISlider*cc=_slider;
    [player addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:NULL usingBlock:^(CMTime time) {
        //当前播放时间
        CGFloat current=xx.currentTime.value/xx.currentTime.timescale;
        //总时间长度
        CMTime time1=xx.duration;
        float x=CMTimeGetSeconds(time1);
        
       // NSLog(@"当前播放的秒数%f~~~总时间长度%f~~",current,x);
        
        //设置滑动条进度
        float v=current/x;
        
        //判断slider是否按下去了，如果按下去了，就先别赋值
        if (!isOpen) {
            cc.value=v;
        }
        
        
    }];

}

-(void)createUI{
    progressView=[[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];
    progressView.frame=CGRectMake(0, 460, self.view.frame.size.width, 20);
    [self.view addSubview:progressView];
    
    _slider=[[UISlider alloc]initWithFrame:CGRectMake(0, 480, self.view.frame.size.width, 20)];
    [self.view addSubview:_slider];
    //添加点击时间
    [_slider addTarget:self action:@selector(sliderClickDown:) forControlEvents:UIControlEventTouchDown];
    //抬起来的事件
    [_slider addTarget:self action:@selector(sliderClickUp:) forControlEvents:UIControlEventTouchUpInside];
    
    
}
//按下去触发的事件
-(void)sliderClickDown:(UISlider*)slider{
    NSLog(@"按下去的事件");
    isOpen=YES;
}
-(void)sliderClickUp:(UISlider*)slider{
    NSLog(@"抬起来的事件");
    isOpen=NO;
    //从这里开始播放
    CGFloat g=slider.value;
    //获取总时长
    CMTime time1=playerItem.duration;
    float x=CMTimeGetSeconds(time1);
    //进行播放
    [player seekToTime:CMTimeMake(x*g, 1)];
    //播放
    [player play];
    //暂停按钮
    //[player pause];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

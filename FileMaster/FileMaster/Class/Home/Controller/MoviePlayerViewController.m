//
//  MoviePlayerViewController.m
//  FileMaster
//
//  Created by Tengfei on 16/2/28.
//  Copyright © 2016年 tengfei. All rights reserved.
//


#import "MoviePlayerViewController.h"
#import "VKVideoPlayer.h"
#import "VKVideoPlayerCaptionSRT.h"
#import "AppDelegate.h"
#import <MediaPlayer/MediaPlayer.h>
 #import "ForwardBackView.h"

#import "SeekDuration.h"

typedef NS_ENUM(NSInteger,SwipeStyle) {
    PlayerSwipeUnKnown = -1,
    PlayerSwipePlaySpeed =  0,
    PlayerSwipePlayVoice =  1,
    PlayerSwipePlayLight =  2,
};

static float scale = 2208.0/900;
@interface MoviePlayerViewController ()<AVAudioSessionDelegate,VKVideoPlayerDelegate>{
    NSNumber * fastNum;
    NSString * shareImagePath;
    //业务开关
    BOOL _attached;
    BOOL isEndFast;//快进结束
}

/**
 *  是否播放的是本地已经下载的文件，YES：是，NO：可以不用传递
 */
@property (nonatomic,assign)BOOL isPlayLocalFile;

//@property (nonatomic, strong) VKVideoPlayer* player;
@property (nonatomic,copy) NSString *currentLanguageCode;
/** 时间栏是否隐藏 */
@property (nonatomic,assign)BOOL isStatusBarHidden;

 //*快进view*/
@property (nonatomic,weak)ForwardBackView * forwardView;

/***  引导页  变量 */

@property (nonatomic,assign)BOOL isPlayingChangeState;
@property (nonatomic,assign)SwipeStyle swipeType;
/**
 *  上次播放到第几秒；注：单位是秒，播放器会自动向前退5s
 */
@property (nonatomic,strong)NSNumber *lastDurationTime;
@property (nonatomic, strong) VKVideoPlayer* player;
@property (nonatomic, assign) CGPoint curTickleStart;
@end

@implementation MoviePlayerViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
//    self.lastDurationTime = [DatabaseTool getSeekTVDuration:self.movieId episode:self.currentNum];
//    
//    if (self.isPlayLocalFile) {
//        [self.player.view.captionButton setTitle:[self getQuality:self.quality] forState:UIControlStateNormal];
//        self.player.view.captionButton.userInteractionEnabled = NO;
//    }else{
//        self.player.view.captionButton.userInteractionEnabled = YES;
//    }
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
 
//    [self addSeekTVDataWithepisodeID:self.episodeSid];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self playSampleClip1];
}

#pragma mark - 播放
- (void)playSampleClip1 {
    if (self.isPlayLocalFile) { //播放本地视频
        //        /Users/rrlhy/Library/Developer/CoreSimulator/Devices/B40AC509-DFB2-443A-B9C0-03A2D58D37AD/data/Containers/Data/Application/E304843C-E9B7-4413-9AAE-48B16EEC6AE1/Documents/video.m3u8
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask , YES) firstObject];
        NSString *url = [path stringByAppendingString:[NSString stringWithFormat:@"/%@",self.playLocalUrl]];
        self.player.isPlayLocalFile = YES;
        [self playStream:[NSURL fileURLWithPath:url]];
//        NSLog(@"%@",playUrl);
//        NSString *playUrl = [NSString stringWithFormat:@"%@/%@",KBasePlayUrl,self.playLocalUrl];
//        [self playStream:[NSURL URLWithString:playUrl]];
    }else{//播网络视频
//        self.player.isPlayLocalFile = NO;
//        [self playStream:[NSURL URLWithString:self.listModel.m3u8.url]];
    }
    
    [self.player setCaptionToTop:[self testCaption:@"testCaptionTop"]];
 }

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isPlayLocalFile = YES;
    
    //默认是YES隐藏的
    self.isStatusBarHidden = NO;
    
    self.player = [[VKVideoPlayer alloc] init];
    self.player.delegate = self;
    
    self.player.view.frame = self.view.bounds;
    self.player.view.playerControlsAutoHideTime = @10;
    [self.view addSubview:self.player.view];
    
#pragma mark - 现在不做分享，分享按钮隐藏
    self.player.view.shareBtn.hidden = YES;//现在不做分享，分享按钮隐藏
    self.player.view.suggestBtn.hidden = YES;
    self.player.view.selectBtn.hidden = YES;
    [self.player.view.captionButton setTitle:@"本地" forState:UIControlStateNormal];
    [self.player.view.captionButton setTitle:@"本地" forState:UIControlStateHighlighted];

    
    //1-标题
    self.player.view.titleLabel.text = self.topTitle ;
    //2－快进
    [self.view addSubview:self.forwardView];
    
    //设置为后台播放
    [[NSNotificationCenter defaultCenter] addObserver:self selector: @selector(handleInterruption:) name:AVAudioSessionInterruptionNotification object:[AVAudioSession sharedInstance]];
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [[AVAudioSession sharedInstance] setDelegate:self];
    NSError *error = nil;
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:&error];
    [audioSession setActive:YES error:&error];
    
    //    if(self.listModel  && self.listModel.episodeList.count){
    //        [self.view addSubview:self.listMenu];
    //    }else{
    //        self.player.view.selectBtn.hidden = YES;//选集
    //    }
    //    [self.view addSubview:self.listMenu];
    
    //    [self showQualityMenu];//1.0版本不调节清晰度，所以这里不进行注释
}


- (void)handleInterruption:(NSNotification *)notice{
    /* For example:
     [[NSNotificationCenter defaultCenter] addObserver: myObject
     selector:    @selector(handleInterruption:)
     name:        AVAudioSessionInterruptionNotification
     object:      [AVAudioSession sharedInstance]];
     */
    [self saveDuration];
    [self.player pauseButtonPressed];
}

#pragma - mark VKVideoPlayerDelegate代理
- (void)videoPlayer:(VKVideoPlayer *)videoPlayer willStartVideo:(id<VKVideoPlayerTrackProtocol>)track{
//    self.lastDurationTime = [DatabaseTool getSeekTVDuration:self.movieId episode:self.currentNum];
//
//    if (self.lastDurationTime == nil || self.lastDurationTime == 0) {
//        self.lastDurationTime = @0;
//    }
//    
//    NSLog(@"--ddduration:%@",self.lastDurationTime);
//    [track setLastDurationWatchedInSeconds: self.lastDurationTime];
    
    NSNumber *duration = [SeekDuration getDurationWithName:self.topTitle];
    if (duration == nil || duration == 0) {
        duration = @0;
    }

    NSLog(@"--ddduration:%@",duration);
    [track setLastDurationWatchedInSeconds: duration];
}

//即将播放的代理
- (void)videoPlayer:(VKVideoPlayer*)videoPlayer didStartVideo:(id<VKVideoPlayerTrackProtocol>)track
{
    
}

- (BOOL)shouldVideoPlayer:(VKVideoPlayer*)videoPlayer changeStateTo:(VKVideoPlayerState)toState{
 
    return YES;
}

- (void)videoPlayer:(VKVideoPlayer*)videoPlayer willChangeStateTo:(VKVideoPlayerState)toState{
    //    NSLog(@"----willChangeStateTo:%d",toState);
    if(self.player.currentTime != 0.0){
        self.isPlayingChangeState = YES;
        self.lastDurationTime = [NSNumber numberWithDouble:self.player.currentTime];
    }
}

#pragma mark - VKVideoPlayerDelegate代理 - 播放结束，自动消失播放界面
- (void)videoPlayer:(VKVideoPlayer *)videoPlayer didPlayToEnd:(id<VKVideoPlayerTrackProtocol>)track{
    
//    NSString * episodeID = self.episodeSid;
//    //保存需要字段到数据库
//    [self addSeekTVDataWithepisodeID:episodeID];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)handleErrorCode:(VKVideoPlayerErrorCode)errorCode track:(id<VKVideoPlayerTrackProtocol>)track customMessage:(NSString *)customMessage{
   
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch * touch = [touches anyObject];
    self.curTickleStart = [touch locationInView:self.view];
}

//手势控制音量和亮度
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    //当前触摸点
    CGPoint current = [touch locationInView:self.view];
    //上一个触摸点
    CGPoint previous = [touch previousLocationInView:self.view];
    
    CGRect leftF;//左半边的
    CGRect reightF;//右半边
    if (!IsIOS8) {
        leftF = CGRectMake(0, 0, KHeight/2, KWidth);//左半边的
        reightF = CGRectMake( KHeight/2 , 0, KHeight/2, KWidth);//右半边
    }else{
        leftF = CGRectMake(0, 0, KWidth/2, KHeight);//左半边的
        reightF = CGRectMake( KWidth/2 , 0, KWidth/2, KHeight);//右半边
    }
    
    CGFloat moveAmtx = current.x - self.curTickleStart.x;
    CGFloat moveAmty = current.y - self.curTickleStart.y;
    
    CGFloat ratio = moveAmty/10000;
    isEndFast = YES;
    
    if (self.player.view.isLockBtnEnable) {
        return;
    }
    
    if (CGRectContainsPoint(leftF, previous) && CGRectContainsPoint(leftF, current)&&(fabs(moveAmtx)<fabs(moveAmty))) {//调整左边 亮度
         self.swipeType = PlayerSwipePlayLight;
        //获取屏幕亮度
        CGFloat lightness = [UIScreen mainScreen].brightness;
        lightness = lightness - ratio;
        if (lightness>=1) {
            lightness=1;
        }
        if (lightness <= 0) {
            lightness = 0;
        }
        [[UIScreen mainScreen] setBrightness:lightness];
        
    }else if(CGRectContainsPoint(reightF, previous) && CGRectContainsPoint(reightF, current)&&(fabs(moveAmtx) < fabs(moveAmty))){//调整右边 音量
         self.swipeType = PlayerSwipePlayVoice;
        CGFloat volumness = [MPMusicPlayerController applicationMusicPlayer].volume;
        volumness = volumness - ratio;
        [[MPMusicPlayerController applicationMusicPlayer] setVolume:volumness];
        
    }else if(fabs(moveAmtx) > 30 &&(fabs(moveAmtx) > fabs(moveAmty))){
        
        self.swipeType = PlayerSwipePlaySpeed;
         self.forwardView.hidden = NO;
        if (!isEndFast) {
            [self.player begainFast];
            isEndFast = YES;
        }
        int seconds = fabs(moveAmtx)/10;
        int currentTotal;
        if (moveAmtx > 0) {//快进
            fastNum = [NSNumber numberWithInt:seconds];
            self.forwardView.direction = ForwardUp;
            currentTotal = self.player.currentTime + seconds;
        }else{//后退
            fastNum = [NSNumber numberWithInt:-seconds];
            self.forwardView.direction = ForwardBack;
            currentTotal = self.player.currentTime - seconds;
        }
        NSString * currentTime = [VKSharedUtility timeStringFromSecondsValue:currentTotal];
        NSString * total = [VKSharedUtility timeStringFromSecondsValue:(int)self.player.view.scrubber.maximumValue];
        self.forwardView.time = [NSString stringWithFormat:@"%@/%@",currentTime,total];
    }else{
        
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.curTickleStart = CGPointZero;
    
    if (self.swipeType == PlayerSwipePlaySpeed) {
        
        [self.player endFastWithTime:self.player.currentTime +[fastNum floatValue]];
    }
    isEndFast = NO;
    self.forwardView.hidden = YES;
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.curTickleStart = CGPointZero;
    isEndFast = NO;
    self.forwardView.hidden = YES;
    self.swipeType = PlayerSwipeUnKnown;
}


- (BOOL)prefersStatusBarHidden {
    return self.isStatusBarHidden;
}

- (void)playSampleClip2 {
    [self playStream:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"SampleVideo_640x360_1mb" ofType:@"mp4"]]];
    
    [self setLanguageCode:@"JP"];
    [self.player setCaptionToTop:[self testCaption:@"testCaptionTop"]];
}

- (void)playStream:(NSURL*)url{
    VKVideoPlayerTrack *track = [[VKVideoPlayerTrack alloc] initWithStreamURL:url];
    track.hasNext = YES;
    [self.player loadVideoWithTrack:track];
}

- (VKVideoPlayerCaption*)testCaption:(NSString*)captionName {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:captionName ofType:@"srt"];
    NSData *testData = [NSData dataWithContentsOfFile:filePath];
    NSString *rawString = [[NSString alloc] initWithData:testData encoding:NSUTF8StringEncoding];
    VKVideoPlayerCaption *caption = [[VKVideoPlayerCaptionSRT alloc] initWithRawString:rawString];
    return caption;
}

- (void)addDemoControl {
    UIButton *playSample1Button = [UIButton buttonWithType:UIButtonTypeCustom];
    playSample1Button.frame = CGRectMake(10,40,80,40);
    [playSample1Button setTitle:@"stream" forState:UIControlStateNormal];
    [playSample1Button addTarget:self action:@selector(playSampleClip1) forControlEvents:UIControlEventTouchUpInside];
    [self.player.view addSubviewForControl:playSample1Button];
    
    UIButton *playSample2Button = [UIButton buttonWithType:UIButtonTypeCustom];
    playSample2Button.frame = CGRectMake(100,40,80,40);
    [playSample2Button setTitle:@"local file" forState:UIControlStateNormal];
    [playSample2Button addTarget:self action:@selector(playSampleClip2) forControlEvents:UIControlEventTouchUpInside];
    [self.player.view addSubviewForControl:playSample2Button];
}

#pragma mark - 调节按钮
#pragma mark - VKVideoPlayerControllerDelegate
- (void)videoPlayer:(VKVideoPlayer*)videoPlayer didControlByEvent:(VKVideoPlayerControlEvent)event {
    NSLog(@"%s event:%d", __FUNCTION__, event);
    if (self.player.view.isLockBtnEnable) {
        return;
    }
    //返回
    if (event == VKVideoPlayerControlEventTapDone) {
        //小屏播放器是点击返回不执行默认的一些逻辑
       
        [self.player pauseContent];
        [self saveDuration];
//        NSString * episodeID = self.episodeSid;
//        if (self.player.currentTime > 0) {
//            [self addSeekTVDataWithepisodeID:episodeID];
//        }
        
        [self dismissViewControllerAnimated:YES completion:^{
            [_player pauseContent];
            [[AVAudioSession sharedInstance] setDelegate:nil];
            _player.delegate = nil;
            _player.track = nil;
            _player = nil;
        }];
        
        
        return;
    }
    //点击屏幕的操作
    if(event == 0){
        self.isStatusBarHidden = self.player.view.controls.hidden;
        [self setNeedsStatusBarAppearanceUpdate];
        
//        if (_qualityMenu.isShow) {
//            _qualityMenu.isShow = NO;
//        }
//        if (_listMenu.isShowing == YES) {
//            [_listMenu hiddenForAnimation];
//        }
        return;
    }
    //全屏操作
    if(event == VKVideoPlayerControlEventTapFullScreen){
        NSLog(@"VKVideoPlayerControlEventTapFullScreen");
    }
    
    //分享
    if (event == VKVideoPlayerControlEventShare) {
        
        return;
    }
    //上报
    if (event == VKVideoPlayerControlEventSuggest) {
        NSLog(@"上报");
 
        return;
    }
    //选集
    if (event == VKVideoPlayerControlEventSelectMenu) {
        NSLog(@"选集");
    
        return;
    }
    //片源质量
    if (event == VKVideoPlayerControlEventTapCaption) {
        [self begainFullScreen];
        return;
    }
    
    if (event == VKVideoPlayerControlEventPause) {//暂停
        
        return;
    }
    
    if (event == VKVideoPlayerControlEventPlay) {//播放
        //[self reloadAd];
    }
    return;
}

- (void)setLanguageCode:(NSString*)code {
    self.currentLanguageCode = code;
    VKVideoPlayerCaption *caption = nil;
    if ([code isEqualToString:@"JP"]) {
        caption = [self testCaption:@"Japanese"];
    } else if ([code isEqualToString:@"EN"]) {
        caption = [self testCaption:@"English"];
    }
    if (caption) {
        [self.player setCaptionToBottom:caption];
        [self.player.view.captionButton setTitle:[code uppercaseString] forState:UIControlStateNormal];
    }
}


#pragma mark - 快进
- (ForwardBackView*)forwardView{
    if (!_forwardView) {
        ForwardBackView * forwardView = [[ForwardBackView alloc]initWithFrame:CGRectMake(0, 0, 170, 84)];
        if (IsIOS8) {
            forwardView.center = CGPointMake(self.view.center.y, self.view.center.x);
        }else{
            forwardView.center = CGPointMake(self.view.center.x, self.view.center.y);
        }
        forwardView.hidden = YES;
        [self.view addSubview:forwardView];
        self.forwardView = forwardView;
    }
    return _forwardView;
}

#pragma - mark - 播放本地文件
//- (void)playLocalFile:(EpisodeModel *)model urlType:(UrlType)urlType{
//    [self addSeekTVDataWithepisodeID:model.sid];
//    [self.player pauseContent];
//    __weak __typeof(self)weakSelf = self;
//    [MovieGetPlayUrl getNewM3u8UrlWithSeasonId:self.movieId episodeSid:model.sid quality:@"high" isSmallPlay:YES andBlock:^(urlDataModel *data, NSError *error) {
//        //        NSLog(@"--data-%@--error:%@",data,error);
//        NSString *uniquenName = [NSString stringWithFormat:@"%@%@",weakSelf.movieId,model.episodeNo];
//        
//        NSString *playUrl = @"";
//        if (urlType == UrlM3u8) {
//            NSLog(@"http://127.0.0.1:12345/%@/movie.m3u8",[uniquenName stableName]);
//            playUrl = [NSString stringWithFormat:@"http://127.0.0.1:12345/%@/movie.m3u8",[uniquenName stableName]];
//        }else if (urlType == UrlHttp){
//            playUrl = uniquenName;
//        }
//        
//        weakSelf.episodeSid = model.sid;
//        weakSelf.currentNum = [model.episodeNo intValue];
//        weakSelf.lastDurationTime = [DatabaseTool getSeekTVDuration:self.movieId episode:weakSelf.currentNum];
//        
//        weakSelf.isPlayLocalFile = YES;
//        
//        if (weakSelf.isPlayLocalFile) { //播放本地视频
//            weakSelf.player.view.captionButton.userInteractionEnabled = NO;
//            
//            NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask , YES) firstObject];
//            NSString *url = [path stringByAppendingString:[NSString stringWithFormat:@"/%@/Video/%@.mp4",kDownDomanPath,playUrl]];
//            weakSelf.player.isPlayLocalFile = YES;
//            [weakSelf playStream:[NSURL fileURLWithPath:url]];
//        }
//        //        [weakSelf playStream:URL(playUrl)];
//        weakSelf.player.view.titleLabel.text = [NSString stringWithFormat:@"%@-第%@集",weakSelf.topTitle,model.episodeNo];
//        [weakSelf.listMenu hiddenForAnimation];
//    }];
//}

 

/**
 *  设置集数
 *
 */
 
-(void)setTopTitle:(NSString *)topTitle
{
    _topTitle = topTitle;
    self.player.view.titleLabel.text = topTitle;;
}


#pragma mark - 自动转屏的逻辑
- (BOOL)shouldAutorotate{
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    if (self.player.view.isLockBtnEnable) {
        if (self.interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
            return  UIInterfaceOrientationMaskLandscapeRight;
        }else if(self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft){
            return UIInterfaceOrientationMaskLandscapeLeft;
        }
        return UIInterfaceOrientationMaskLandscape;
    }else{
        return UIInterfaceOrientationMaskLandscape;
    }
}
#pragma mark - 保存看剧时间
- (void)addSeekTVDataWithepisodeID:(NSString *)episodeID{
    if (self.player.currentTime == 0.0)return;
//    [DatabaseTool addSeekTVDuration:self.movieId episode:self.currentNum duration:self.player.currentTime title:self.topTitle urltpye:UrlHttp quality:self.quality episodeID:episodeID coverUrl:self.coverUrl];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}


-(void)saveDuration{
   NSNumber *duration = [NSNumber numberWithDouble:self.player.currentTime];
    [SeekDuration saveDuration:self.topTitle duration:duration];
}

- (void)dealloc{
    [[AVAudioSession sharedInstance] setDelegate:nil];
    _player.delegate = nil;
    _player.track = nil;
    _player = nil;
}
#pragma - mark  进入全屏
-(void)begainFullScreen
{
    NSLog(@"------begainFullScreen");
    //    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    //    appDelegate.allowRotation = YES;
    
    //强制横屏：-：右偏
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val = UIInterfaceOrientationLandscapeRight;
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}
@end

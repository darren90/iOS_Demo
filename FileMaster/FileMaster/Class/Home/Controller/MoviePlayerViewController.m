//
//  MoviePlayerViewController.m
//  FileMaster
//
//  Created by Tengfei on 16/2/28.
//  Copyright © 2016年 tengfei. All rights reserved.
//


#import "MoviePlayerViewController.h"
#import "VKVideoPlayer.h"
//#import "VKVideoPlayerCaptionSRT.h"
#import "VKVideoPlayerCaptionSRT.h"
#import "AppDelegate.h"
#import "MediaPlayer/MediaPlayer.h"
#import "ForwardBackView.h"

@interface MoviePlayerViewController ()<AVAudioSessionDelegate,VKVideoPlayerDelegate>
{
    NSNumber * fastNum;
    BOOL isEndFast;
}
@property (nonatomic, strong) VKVideoPlayer* player;
@property (nonatomic, strong) NSString *currentLanguageCode;


/** 时间栏是否隐藏 */
@property (nonatomic,assign)BOOL isStatusBarHidden;

/** 显示标题的label */
@property (nonatomic,weak) UILabel *nameLabel;
@property (nonatomic,strong)ForwardBackView * forwardView;


@property (nonatomic, assign) CGPoint curTickleStart;
@end

@implementation MoviePlayerViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
 }
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self endFullScreen];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self playSampleClip1];
}
#pragma mark - 播放
- (void)playSampleClip1 {
    [self playStream:[NSURL URLWithString:self.playerUrl]];
    [self.player setCaptionToTop:[self testCaption:@"testCaptionTop"]];
 
    
    //    NSString* path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    //    NSString *url = [path stringByAppendingPathComponent:@"mmaaa.mp4"];
    //   [self playStream:[NSURL URLWithString:url]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
     //默认是YES隐藏的
    //self.isStatusBarHidden = YES;
    
    self.player = [[VKVideoPlayer alloc] init];
    self.player.delegate = self;
    self.player.view.frame = self.view.bounds;
    self.player.view.playerControlsAutoHideTime = @10;
    [self.view addSubview:self.player.view];
    
    [self.view addSubview:self.forwardView];
 
    
    //1-完成
    UIButton *downBtn = self.player.view.doneButton;
    //    downBtn.backgroundColor = [UIColor redColor];
    CGRect downFrame = downBtn.frame;
    downFrame.size.width += 10;
    downFrame.origin.y += 6;
    downBtn.frame = downFrame;
    // [downBtn setImage:[UIImage imageNamed:@"icon_indictor_img"] forState:UIControlStateNormal];
    
    self.player.view.nextButton.hidden= YES;
    
    //2-视频质量
    VKPickerButton *qualityBtn = self.player.view.captionButton;//质量
    //    CGSize qualiSize = [self.quality sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
    qualityBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    //    CGRect qualityFrame = qualityBtn.frame;
    //    qualityFrame.size.width = qualiSize.width+10;
    //    qualityFrame.origin.x -= 10;
    //    qualityBtn.frame = qualityFrame;
    //    qualityBtn.backgroundColor = [UIColor redColor];
    //    [qualityBtn setTitle:self.quality forState:UIControlStateNormal];
    [qualityBtn setTitle:@"高清" forState:UIControlStateNormal];
    [qualityBtn setTitleColor:MJColor(153, 153, 153) forState:UIControlStateNormal];
    [qualityBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    qualityBtn.enabled = NO;
    qualityBtn.userInteractionEnabled = NO;
    
    //3-下载按钮
    VKPickerButton *downloadBtn = self.player.view.videoQualityButton;
    downloadBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    NSString *downloadName = @"下载";
    [downloadBtn setTitle:downloadName forState:UIControlStateNormal];
    [downloadBtn setTitle:downloadName forState:UIControlStateHighlighted];
    downloadBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [downloadBtn setTitleColor:MJColor(153, 153, 153) forState:UIControlStateNormal];
    [downloadBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [downloadBtn addTarget:self action:@selector(downMovie) forControlEvents:UIControlEventTouchUpInside];
    CGRect downloadF = downloadBtn.frame;
    //    downloadF.origin.x += 10;
    downloadF.size.width += 30;
    //    CGFloat downBtnH = 20;
    //    downloadF.origin.y = (downloadF.size.height - downBtnH)/2;
    //    downloadF.size.height = downBtnH;
    downloadBtn.frame = downloadF;
    
    //5-选集
    UIButton * seriesBtn = self.player.view.rewindButton;//倒退30秒 位于右上角
    [seriesBtn setImage:nil forState:UIControlStateNormal];//
    //完成
    //    CGRect downFrame = self.player.view.doneButton.frame;
    
    
    CGFloat height = CGRectGetMaxY(downFrame) - CGRectGetMinY(downFrame);//获取“完成”按钮的高度
    //设置moviewTitle
    UILabel *nameLabel = [[UILabel alloc]init];
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.font = [UIFont systemFontOfSize:16];
    self.nameLabel = nameLabel;
    [self.player.view addSubviewForControl:nameLabel];
    nameLabel.text = self.topTitle;
    CGSize nameSize = [self.topTitle sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]}];
    nameLabel.frame = CGRectMake(CGRectGetMaxX(downFrame)+10,CGRectGetMinY(downFrame)+ (height-nameSize.height)/2, nameSize.width, nameSize.height);
    
    //设置为后台播放
    [[NSNotificationCenter defaultCenter] addObserver:self selector: @selector(handleInterruption:) name:AVAudioSessionInterruptionNotification object:[AVAudioSession sharedInstance]];
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [[AVAudioSession sharedInstance] setDelegate:self];
    NSError *error = nil;
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:&error];
    [audioSession setActive:YES error:&error];
}

- (void)handleInterruption:(NSNotification *)notice
{
    [self.player pauseButtonPressed];
}


#pragma - mark VKVideoPlayerDelegate代理
- (void)videoPlayer:(VKVideoPlayer *)videoPlayer willStartVideo:(id<VKVideoPlayerTrackProtocol>)track
{
    if (self.lastDurationTime == nil || self.lastDurationTime == 0) {
        self.lastDurationTime = @0;
    }
    NSLog(@"--ddduration:%@",self.lastDurationTime);
    [track setLastDurationWatchedInSeconds: self.lastDurationTime];
}

- (BOOL)shouldVideoPlayer:(VKVideoPlayer*)videoPlayer changeStateTo:(VKVideoPlayerState)toState
{
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    return YES;
}

#pragma mark - VKVideoPlayerDelegate代理 - 播放结束，自动消失播放界面
-(void)videoPlayer:(VKVideoPlayer *)videoPlayer didPlayToEnd:(id<VKVideoPlayerTrackProtocol>)track
{
//    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    appDelegate.allowRotation = NO;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)handleErrorCode:(VKVideoPlayerErrorCode)errorCode track:(id<VKVideoPlayerTrackProtocol>)track customMessage:(NSString *)customMessage
{
 
}

 
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches anyObject];
    self.curTickleStart = [touch locationInView:self.view];
}

//手势控制音量和亮度
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    //当前触摸点
    CGPoint current = [touch locationInView:self.view];
    //上一个触摸点
    CGPoint previous = [touch previousLocationInView:self.view];
    
    CGRect leftF = CGRectMake(0, 0, KHeight/2, KWidth);//左半边的
    CGRect reightF = CGRectMake( KHeight + KHeight/2, 0, KHeight/2, KWidth);//右半边
    
    CGFloat moveAmtx = current.x - self.curTickleStart.x;
    CGFloat moveAmty = current.y - self.curTickleStart.y;
    
    CGFloat ratio = moveAmty/10000;
    isEndFast = YES;
    if (CGRectContainsPoint(leftF, previous) && CGRectContainsPoint(leftF, current)&&(fabs(moveAmtx)<fabs(moveAmty))) {//调整左边 亮度
        NSLog(@"调亮度");
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
        NSLog(@"调音量");
        self.swipeType = PlayerSwipePlayVoice;
        CGFloat volumness = [MPMusicPlayerController applicationMusicPlayer].volume;
        volumness = volumness - ratio;
        [[MPMusicPlayerController applicationMusicPlayer] setVolume:volumness];
        
    }else if(!CGRectContainsPoint(reightF, previous) && !CGRectContainsPoint(reightF, current)&&(fabs(moveAmtx) > fabs(moveAmty))){
        
        if (self.player.view.isLockBtnEnable) {
            return;
        }
        self.swipeType = PlayerSwipePlaySpeed;
        NSLog(@"快进后退");
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
    }
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.curTickleStart = CGPointZero;
    
    if (self.swipeType == PlayerSwipePlaySpeed) {
        
        [self.player endFastWithTime:self.player.currentTime +[fastNum floatValue]];
    }
    isEndFast = NO;
    self.forwardView.hidden = YES;
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
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

- (void)playStream:(NSURL*)url {
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

#pragma mark - VKVideoPlayerControllerDelegate
- (void)videoPlayer:(VKVideoPlayer*)videoPlayer didControlByEvent:(VKVideoPlayerControlEvent)event {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.allowRotation = NO;
 
    
    NSLog(@"%s event:%d", __FUNCTION__, event);
    __weak __typeof(self) weakSelf = self;
    
    if (event == VKVideoPlayerControlEventTapDone) {
//        [DatabaseTool addSeekTVDuration:self.model.movieId episode:self.model.episode duration:self.player.currentTime];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
    //全屏操作
    if(event == VKVideoPlayerControlEventTapFullScreen){
        NSLog(@"VKVideoPlayerControlEventTapFullScreen");
        
    }
    if(event == 0){ //点击屏幕的操作
        self.isStatusBarHidden = self.nameLabel.hidden;
        [self setNeedsStatusBarAppearanceUpdate];
    }
    
    if (event == VKVideoPlayerControlEventTapCaption) {
        return;//不再调整
        RUN_ON_UI_THREAD(^{
            VKPickerButton *button = self.player.view.captionButton;
            NSArray *subtitleList = @[@"JP", @"EN"];
            
            if (button.isPresented) {
                [button dismiss];
            } else {
                weakSelf.player.view.controlHideCountdown = -1;
                [button presentFromViewController:weakSelf title:NSLocalizedString(@"settings.captionSection.subtitleLanguageCell.text", nil) items:subtitleList formatCellBlock:^(UITableViewCell *cell, id item) {
                    
                    NSString* code = (NSString*)item;
                    cell.textLabel.text = code;
                    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@%%", @"50"];
                } isSelectedBlock:^BOOL(id item) {
                    return [item isEqualToString:weakSelf.currentLanguageCode];
                } didSelectItemBlock:^(id item) {
                    [weakSelf setLanguageCode:item];
                    [button dismiss];
                } didDismissBlock:^{
                    weakSelf.player.view.controlHideCountdown = [weakSelf.player.view.playerControlsAutoHideTime integerValue];
                }];
            }
        });
    }
}

#pragma - mark 退出全屏 并且强制归正
- (void)endFullScreen
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.allowRotation = NO;
    
    //强制归正：
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val = UIInterfaceOrientationPortrait;
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
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

- (ForwardBackView*)forwardView
{
    if (!_forwardView) {
        ForwardBackView * forwardView = [[ForwardBackView alloc]initWithFrame:CGRectMake(0, 0, 170, 84)];
        forwardView.center = CGPointMake(self.view.center.y, self.view.center.x);
        forwardView.hidden = YES;
        [self.view addSubview:forwardView];
        self.forwardView = forwardView;
    }
    return _forwardView;
}


- (BOOL)shouldAutorotate {
    return NO;
}
//播放界面只支持横屏
// Override to allow orientations other than the default portrait orientation.
// This method is deprecated on ios6
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return interfaceOrientation == UIInterfaceOrientationMaskPortrait;
}

// For ios6, use supportedInterfaceOrientations & shouldAutorotate instead
- (UIInterfaceOrientationMask) supportedInterfaceOrientations{
#ifdef __IPHONE_6_0
    return UIInterfaceOrientationMaskLandscapeRight;
#endif
    return UIInterfaceOrientationMaskLandscapeRight;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)dealloc
{
    [self endFullScreen];
    self.player = nil;
    self.player.delegate = nil;
    self.player.track = nil;
}

@end


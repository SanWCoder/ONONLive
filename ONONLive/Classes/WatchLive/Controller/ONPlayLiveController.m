//
//  ONPlayLiveController.m
//  ONONLive
//
//  Created by SanW on 2018/4/24.
//  Copyright © 2018年 ONONTeam. All rights reserved.
//

#import "ONPlayLiveController.h"
#import <IJKMediaFramework/IJKMediaFramework.h>
@interface ONPlayLiveController ()
@property (nonatomic,retain)id <IJKMediaPlayback> player;

@property (nonatomic,weak) UIView *displayView;

@end

@implementation ONPlayLiveController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    IJKFFOptions *options = [IJKFFOptions optionsByDefault];
    [options setPlayerOptionIntValue:1  forKey:@"videotoolbox"];
    // 帧速率(fps) （可以改，确认非标准桢率会导致音画不同步，所以只能设定为15或者29.97）
    [options setPlayerOptionIntValue:29.97 forKey:@"r"];
    // -vol——设置音量大小，256为标准音量。（要设置成两倍音量时则输入512，依此类推
    [options setPlayerOptionIntValue:512 forKey:@"vol"];
    // @"rtmp://172.16.188.104:1935/rtmplive/room"
    _player = [[IJKFFMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:@"rtmp://172.16.188.104:1935/rtmplive/room"] withOptions:nil];
    UIView *playerView = [self.player view];
    self.displayView = playerView;
    self.displayView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.displayView.frame = self.view.frame;
    [self.view addSubview:self.displayView];
    [self addPlayerNotification];
    [_player prepareToPlay];
    [_player play];
}

- (void)addPlayerNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                            selector:@selector(loadStateDidChange:)
                                name:IJKMPMoviePlayerLoadStateDidChangeNotification
                              object:_player];
    [[NSNotificationCenter defaultCenter] addObserver:self
                            selector:@selector(moviePlayBackFinish:)
                                name:IJKMPMoviePlayerPlaybackDidFinishNotification
                              object:_player];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                            selector:@selector(mediaIsPreparedToPlayDidChange:)
                                name:IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification
                              object:_player];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                            selector:@selector(moviePlayBackStateDidChange:)
                                name:IJKMPMoviePlayerPlaybackStateDidChangeNotification
                              object:_player];
}
- (void)loadStateDidChange:(NSNotification *)notification{
    NSLog(@"loadStateDidChange");
    //    self.player = (IJKFFMoviePlayerController *)_player;
    NSLog(@"loadState = %lu",(unsigned long)_player.loadState);
    switch (_player.loadState) {
        case IJKMPMovieLoadStateUnknown:
            
            break;
        case IJKMPMovieLoadStatePlayable:
            
            break;
        case IJKMPMovieLoadStatePlaythroughOK:
            
            break;
        case IJKMPMovieLoadStateStalled:
            
            break;
        default:
            break;
    }
}
- (void)moviePlayBackFinish:(NSNotification *)notification{
    NSLog(@"moviePlayBackFinish");
}
- (void)mediaIsPreparedToPlayDidChange:(NSNotification *)notification{
    NSLog(@"playbackState = %ld",(long)_player.playbackState);
    NSLog(@"mediaIsPreparedToPlayDidChange");
}
- (void)moviePlayBackStateDidChange:(NSNotification *)notification{
    NSLog(@"moviePlayBackStateDidChange");
}
@end

//
//  ONCaptureController.m
//  ONONLive
//
//  Created by SanW on 2018/4/18.
//  Copyright © 2018年 ONONTeam. All rights reserved.
//

#import "ONCaptureController.h"
#import <LFLiveKit.h>
#import <AVFoundation/AVFoundation.h>
#import <VideoToolbox/VideoToolbox.h>

@interface ONCaptureController ()<AVCaptureVideoDataOutputSampleBufferDelegate,AVCaptureAudioDataOutputSampleBufferDelegate,LFLiveSessionDelegate>
@end

@implementation ONCaptureController
{
    // 会话
// AVCaptureSession *_session;
// 链接
// AVCaptureConnection *_videoConnection;
// AVCaptureVideoPreviewLayer *_prelayer;
    LFLiveSession *_session;
}

- (LFLiveSession*)session {
    if (!_session) {
        /// 设置
        _session = [[LFLiveSession alloc] initWithAudioConfiguration:[LFLiveAudioConfiguration defaultConfiguration] videoConfiguration:[LFLiveVideoConfiguration defaultConfiguration] captureType:LFLiveCaptureMaskAll];
        _session.preView = self.view;
        _session.delegate = self;
        _session.showDebugInfo = YES;
        /// 必须打开运行不然无法录制
        _session.running = YES;
    }
    return _session;
}
- (void)startLive {
    LFLiveStreamInfo *streamInfo = [LFLiveStreamInfo new];
    streamInfo.url = @"rtmp://172.16.188.104:1935/rtmplive/room";
    [self.session startLive:streamInfo];
}

- (void)stopLive {
    [self.session stopLive];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self startLive];
//    [self videoAVCapture];
}
- (void)liveSession:(nullable LFLiveSession *)session liveStateDidChange:(LFLiveState)state{
    NSLog(@"state == %lu",(unsigned long)state);
}
/** live debug info callback */
- (void)liveSession:(nullable LFLiveSession *)session debugInfo:(nullable LFLiveDebug *)debugInfo{
    NSLog(@"debugInfo == %@",debugInfo);
}
/** callback socket errorcode */
- (void)liveSession:(nullable LFLiveSession *)session errorCode:(LFLiveSocketErrorCode)errorCode{
    NSLog(@"errorCode == %lu",(unsigned long)errorCode);
}
/**
- (void)videoAVCapture{
    /// 音频设备
    AVCaptureDevice *audioDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio];
    /// 视频设备
    AVCaptureDevice *videoDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureDeviceInput *audioInput = [AVCaptureDeviceInput deviceInputWithDevice:audioDevice error:nil];
    AVCaptureDeviceInput *videoInput = [AVCaptureDeviceInput deviceInputWithDevice:videoDevice error:nil];
    _session = [[AVCaptureSession alloc]init];
    if ([_session canAddInput:audioInput]) {
        [_session addInput:audioInput];
    }
    if ([_session canAddInput:videoInput]) {
        [_session addInput:videoInput];
    }
    //    [NSURL fileURLWithPath:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByDeletingLastPathComponent] stringByAppendingPathComponent:@"MBA材料撰写.m4a"]];
    //
    AVCaptureVideoDataOutput *videoOutput = [[AVCaptureVideoDataOutput alloc]init];
    dispatch_queue_t videoQueue = dispatch_queue_create("video", DISPATCH_QUEUE_SERIAL);
    [videoOutput setSampleBufferDelegate:self queue:videoQueue];
    AVCaptureAudioDataOutput *audioOutput = [[AVCaptureAudioDataOutput alloc]init];
    dispatch_queue_t audioQueue = dispatch_queue_create("audio", DISPATCH_QUEUE_SERIAL);
    [audioOutput setSampleBufferDelegate:self queue:audioQueue];
    
    if ([_session canAddOutput:audioOutput]) {
        [_session addOutput:audioOutput];
    }
    if ([_session canAddOutput:videoOutput]) {
        [_session addOutput:videoOutput];
    }
    _videoConnection = [videoOutput connectionWithMediaType:AVMediaTypeVideo];
    _prelayer = [[AVCaptureVideoPreviewLayer alloc]initWithSession:_session];
    CALayer *layer = self.view.layer;
    _prelayer.frame = self.view.frame;
    // 填充模式
    _prelayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    // 将视频预览层添加到界面中
    [layer addSublayer:_prelayer];
    [_session startRunning];
}
- (void)captureOutput:(AVCaptureOutput *)output didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection{
    if (connection == _videoConnection) {
        NSLog(@"video data == %@",sampleBuffer);
//        int width = 480, height = 640;
        CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
        // 转换为
        CIImage *ciImage = [CIImage imageWithCVImageBuffer:imageBuffer];
        // 创建滤镜
        CIFilter *filter = [CIFilter filterWithName:@"CIColorMonochrome"];
        // 创建滤镜对象-将图片加入滤镜
        [filter setValue:ciImage forKey:kCIInputImageKey];
        // 设置颜色
        [filter setValue:[CIColor colorWithRed:1.000 green:0.759 blue:0.592 alpha:1] forKey:kCIInputColorKey];
        ciImage = filter.outputImage;
        // 转换
        UIImage *image = [UIImage imageWithCIImage:ciImage];
        dispatch_sync(dispatch_get_main_queue(), ^{
            _prelayer.contents = (id)(image.CGImage);
        });
    }else{
        NSLog(@"audio data == %@",sampleBuffer);
    }
}
*/
@end

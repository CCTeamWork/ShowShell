//
//  TestTools.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/7/18.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "TestTools.h"


@implementation TestTools

/* 压缩视频 */
+ (void)cutDownVideoWithURL:(NSURL *)url{
    //保存至沙盒路径
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];//用时间给文件全名，以免重复，在测试的时候其实可以判断文件是否存在若存在，则删除，重新生成文件即可
    [formater setDateFormat:@"yyyy-MM-dd-HH:mm:ss"];
    NSURL *outPutURL = [NSURL fileURLWithPath:[NSHomeDirectory() stringByAppendingFormat:@"/Documents/output-%@.mp4", [formater stringFromDate:[NSDate date]]]];
    NSLog(@"%@",[NSHomeDirectory() stringByAppendingFormat:@"/Documents/output-%@.mp4", [formater stringFromDate:[NSDate date]]]);
    
    AVURLAsset *asset = [AVURLAsset URLAssetWithURL:url options:nil];
    AVAssetExportSession *session = [[AVAssetExportSession alloc] initWithAsset:asset presetName:AVAssetExportPresetMediumQuality];
    session.outputURL = outPutURL;
    session.outputFileType = AVFileTypeQuickTimeMovie;
    [session exportAsynchronouslyWithCompletionHandler:^{
        NSInteger code = session.status;
        switch (code)
        {
            case AVAssetExportSessionStatusFailed:
            {
                // log error to text view
                NSError *exportError = session.error;
                NSLog (@"AVAssetExportSessionStatusFailed: %@", exportError);
                break;
            }
            case AVAssetExportSessionStatusCompleted:
            {
                NSLog(@"视频转码成功");
            }
        }

    }];
}

/* 取视频中的任意一帧图片  */
+ (UIImage *)thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time {
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
    CMTimeValue  value = asset.duration.value;//总帧数
    CMTimeScale  timeScale = asset.duration.timescale; //timescale为帧率  fps
    NSLog(@"-------总帧数 %lld,  帧率%d",value,timeScale);
    
    NSParameterAssert(asset);
    AVAssetImageGenerator *assetImageGenerator =[[AVAssetImageGenerator alloc] initWithAsset:asset];
    assetImageGenerator.appliesPreferredTrackTransform = YES;
    assetImageGenerator.apertureMode =AVAssetImageGeneratorApertureModeEncodedPixels;
    
    CFTimeInterval thumbnailImageTime = time;
    NSError *error = nil;
    CGImageRef thumbnailImageRef = [assetImageGenerator copyCGImageAtTime:CMTimeMake(thumbnailImageTime, 60) actualTime:NULL error:&error];
    
    if(!thumbnailImageRef){
        NSLog(@"thumbnailImageGenerationError %@",error);
    }
    
    UIImage *thumbnailImage = [UIImage imageWithCGImage:thumbnailImageRef];
    return thumbnailImage;
}



@end

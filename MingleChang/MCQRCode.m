//
//  MCQRCode.m
//  QRCode_OC
//
//  Created by 常峻玮 on 16/1/6.
//  Copyright © 2016年 Mingle. All rights reserved.
//

#import "MCQRCode.h"
#import "MCQRCodeMaskView.h"



@interface MCQRCode ()<AVCaptureMetadataOutputObjectsDelegate>


@property (nonatomic,strong)AVCaptureVideoPreviewLayer *preview;
@property (nonatomic,strong)AVCaptureDeviceInput * input;
@property (nonatomic,strong)AVCaptureMetadataOutput * output;
@property (nonatomic,strong)AVCaptureDevice * device;

@end

@implementation MCQRCode
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
//        MCQRCodeMaskView *lView=[[MCQRCodeMaskView alloc]initWithFrame:frame];
//        [self addSubview:lView];
        [self setupQRCodeScannerWithFrame:frame];
    }
    return self;
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
}


-(void)setupQRCodeScannerWithFrame:(CGRect)frame{
    self.device=[AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    self.input=[AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    self.output=[[AVCaptureMetadataOutput alloc]init];
    [self.output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    self.session = [[AVCaptureSession alloc]init];
    [self.session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([self.session canAddInput:self.input])
    {
        [self.session addInput:self.input];
    }
    
    if ([self.session canAddOutput:self.output])
    {
        [self.session addOutput:self.output];
    }
    self.output.metadataObjectTypes=self.output.availableMetadataObjectTypes;
    self.output.rectOfInterest=CGRectMake((frame.size.height/2-frame.size.width*0.4)/frame.size.height,0.1, frame.size.width*0.8/frame.size.height, frame.size.width*0.8/frame.size.width);
    // Preview
    self.preview =[AVCaptureVideoPreviewLayer layerWithSession:self.session];
    self.preview.videoGravity =AVLayerVideoGravityResize;
    [self.preview setFrame:frame];
    [self.layer insertSublayer:self.preview atIndex:0];
    
    [self.session startRunning];

}
#pragma mark - AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    [self.session stopRunning];
    if (metadataObjects.count > 0) {
        AVMetadataMachineReadableCodeObject *obj = metadataObjects[0];
        if ([self.delegate respondsToSelector:@selector(qrCodeFinishedSanningQRCode:)]) {
            [self.delegate qrCodeFinishedSanningQRCode:obj.stringValue];
        }
    }
}

#pragma mark - Setter And Getter




@end

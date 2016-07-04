//
//  ScannerViewController.m
//  PrettySunshine
//
//  Created by Groupfly on 16/6/30.
//  Copyright © 2016年 Groupfly. All rights reserved.
//

#import "ScannerViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "ZBarSDK.h"
#import "QRView.h"

@interface ScannerViewController ()<AVCaptureMetadataOutputObjectsDelegate, UIAlertViewDelegate,ZBarReaderDelegate>
@property (nonatomic, strong) AVCaptureDevice *device;
@property (nonatomic, strong) AVCaptureDeviceInput *input;
@property (nonatomic, strong) AVCaptureMetadataOutput *output;
@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *preview;
@property (nonatomic, copy) NSString *webURL;
@end

@implementation ScannerViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupView];
//    [self setUpCamera];
    
//    [self setScanRegion];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

    
//    NSError *error= nil;
//    NSDictionary *dic = @{@"key1":@"value1",
//                          @"key2":@[@{@"1":@"-"},@{@"2":@"er"}]
//                          };
//    NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
//    NSString *jsonString = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//    NSLog(@"jsonString---%@",jsonString);
}

/**
 *  设置界面
 */
- (void)setupView{
    self.navigationItem.title = @"扫一扫";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc] initWithTitle:@"相册" style:UIBarButtonItemStyleDone target:self action:@selector(openQRPhoto)];
    
    self.navigationItem.rightBarButtonItem = barBtn;
    
    [self initConfig];
}

- (void)openQRPhoto {
    ZBarReaderController *reader = [ZBarReaderController new];
    reader.allowsEditing = YES;
    reader.readerDelegate = self;
    reader.showsHelpOnFail = NO;
    reader.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:reader animated:YES completion:nil];
}

/**
 *  相机设置
 */
- (void)initConfig {
    // 检查授权
    NSString *mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if (authStatus == AVAuthorizationStatusDenied || authStatus == AVAuthorizationStatusRestricted) {
        [self dismissViewControllerAnimated:YES completion:nil];
        return;
    }
    
    self.device = [AVCaptureDevice defaultDeviceWithMediaType:mediaType];
    
    self.input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    
    self.output = [[AVCaptureMetadataOutput alloc] init];
    [self.output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    self.session = [[AVCaptureSession alloc] init];
    
    [self.session setSessionPreset:AVCaptureSessionPresetHigh];
    
    if ([self.session canAddInput:self.input]) {
        [self.session addInput:self.input];
    }
    if ([self.session canAddOutput:self.output]) {
        [self.session addOutput:self.output];
    }
    
    // 条码类型
    self.output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    
    self.preview = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    self.preview.videoGravity = AVLayerVideoGravityResize;
    self.preview.frame = self.view.layer.bounds;
    [self.view.layer insertSublayer:self.preview atIndex:0];
    
    // kaishi
    [self.session startRunning];
    
    QRView *qrView = [[QRView alloc] initWithFrame:self.view.frame];
    
    NSLog(@"%@",NSStringFromCGRect(self.view.frame));
    
    CGFloat margin = 20;
    CGFloat width = SCREEN_WIDTH - 2*margin ;

    CGSize size = CGSizeMake(width, width);
    
    qrView.transparentArea = size;
    qrView.backgroundColor = [UIColor clearColor];
    qrView.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2 - 50);
    [self.view addSubview:qrView];
    
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, qrView.center.y - size.height/2 - 30,
                                                                  self.view.frame.size.width, 20)];
    tipLabel.text = @"请将摄像头对准二维码/条形码 即可自动扫描";
    tipLabel.textColor = [UIColor whiteColor];
    tipLabel.font = [UIFont systemFontOfSize:15];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:tipLabel];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    NSArray *resuluts = [info objectForKey:ZBarReaderControllerResults];
    
    if (resuluts.count > 0) {
        int quality = 0;
        ZBarSymbol *bestResult = nil;
        for (ZBarSymbol *sym in resuluts) {
            int tempQ = sym.quality;
            if (quality < tempQ) {
                quality = tempQ;
                bestResult = sym;
            }
        }
        
        [self presentResult:bestResult];
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void) presentResult: (ZBarSymbol*)sym {
    if (sym) {
        NSString *tempStr = sym.data;
        if ([sym.data canBeConvertedToEncoding:NSShiftJISStringEncoding]) {
            tempStr = [NSString stringWithCString:[tempStr cStringUsingEncoding:NSShiftJISStringEncoding] encoding:NSUTF8StringEncoding];
        }
        NSLog(@"%@",tempStr);
        
        
        [self handelURLString:tempStr];
    }
}
//}
//- (void)setScanRegion
//{
//    UIImageView *overlayImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"overlaygraphic.png"]];
//    overlayImageView.translatesAutoresizingMaskIntoConstraints = NO;
//    [self.view addSubview:overlayImageView];
//    
//    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.view        attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual
//                                                             toItem:overlayImageView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
//    
//    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.view        attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual
//                                                             toItem:overlayImageView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
//    
//    
//    
//    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
//    CGFloat screenWidth  = [UIScreen mainScreen].bounds.size.width;
//    
//    _output.rectOfInterest = CGRectMake((screenHeight - 200) / 2 / screenHeight,
//                                        (screenWidth  - 260) / 2 / screenWidth,
//                                        200 / screenHeight,
//                                        260 / screenWidth);
//}


- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    DLog(@"%@",metadataObjects);
    
    if (metadataObjects.count > 0) {
        [self.session stopRunning];
        AVMetadataMachineReadableCodeObject *metaDataObject = [metadataObjects firstObject];
        
        self.webURL = metaDataObject.stringValue;
        
        [self handelURLString:self.webURL];
    }
    
}

// 处理扫描的字符串
-(void)handelURLString:(NSString *)string
{
    
    NSArray * array = [string componentsSeparatedByString:@"/"];
    if ([string hasPrefix:@"http"]) {
        
        NSLog(@"%@", array);
        if (array.firstObject) {
            // 这里用户根据自己的业务逻辑进行处理 比如判断字符串是否包含某个特定的字符串 然后根据url跳转到响应的界面(如个人详情加好友页面....)
            if ([array[2] isEqualToString:@"www.baidu.com"]) {
                [self.session startRunning];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.baidu.com"]];
            }else{
                UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"提示"message:[NSString stringWithFormat:@"该链接可能存在风险\n%@",string] delegate:self cancelButtonTitle:@"取消"otherButtonTitles:@"打开链接",nil];
                alertView.tag = 100086;
                alertView.delegate = self;
//                self.urlString = string;
                [self.session stopRunning];
                [alertView show];
            }
        }
    }else{
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"提示"message:[NSString stringWithFormat:@"扫描结果:\n%@",string] delegate:self cancelButtonTitle:@"确定"otherButtonTitles:nil];
        alertView.tag = 100087;
        [self.session stopRunning];
        [alertView show];
    }
}

#pragma mark ---alertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 100086) {
        if (buttonIndex == 1) {
            [self.session startRunning];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.webURL]];
        } else {
            [self.session startRunning];
        }
    }
    
    if (alertView.tag == 100087) {
        if (buttonIndex == 0) {
            [self.session startRunning];
        }
    }
}


@end

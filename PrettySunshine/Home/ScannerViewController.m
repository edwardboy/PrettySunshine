//
//  ScannerViewController.m
//  PrettySunshine
//
//  Created by Groupfly on 16/6/30.
//  Copyright © 2016年 Groupfly. All rights reserved.
//

#import "ScannerViewController.h"
#import <AVFoundation/AVFoundation.h>


@interface ScannerViewController ()<AVCaptureMetadataOutputObjectsDelegate, UIAlertViewDelegate>
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
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    NSError *error= nil;
    NSDictionary *dic = @{@"key1":@"value1",
                          @"key2":@[@{@"1":@"-"},@{@"2":@"er"}]
                          };
    NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"jsonString---%@",jsonString);
}

/**
 *  设置界面
 */
- (void)setupView{
    self.navigationItem.title = @"扫一扫";
    
    self.view.backgroundColor = [UIColor whiteColor];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(cancelButtonClicked)];
    
//    [self setUpCamera];
}
/**
 *  返回
 */
//- (void)cancelButtonClicked
//{
//    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
//}
/**
 *  相机设置
 */
- (void)setUpCamera
{
    _device  = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    _input   = [AVCaptureDeviceInput deviceInputWithDevice:_device error:nil];
    
    _output  = [AVCaptureMetadataOutput new];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    _session = [AVCaptureSession new];
    [_session addInput:_input];
    [_session addOutput:_output];
    _output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];
    
    _preview = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    [_preview setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [_preview setFrame:self.view.layer.bounds];
    [self.view.layer addSublayer:_preview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

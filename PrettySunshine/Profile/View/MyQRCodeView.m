//
//  MyQRCodeView.m
//  QRCode
//
//  Created by Apple on 16/5/9.
//  Copyright © 2016年 aladdin-holdings.com. All rights reserved.
//

#import "MyQRCodeView.h"
#import "UIView+Layout.h"

#import "UserModel.h"

#import "QRCodeGenerator.h"

#define QRViewMargin 20

@interface MyQRCodeView ()

@property (nonatomic,weak)UIImageView *icon;
@property (nonatomic,weak)UILabel *name;
@property (nonatomic,weak)UILabel *address;
// 二维码图片
@property (nonatomic,weak)UIImageView *qrImg;
// 二维码上图片
@property (nonatomic,weak)UIImageView *appIcon;

@end

@implementation MyQRCodeView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self setupContentView];
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.layer.cornerRadius = 10;
    }
    return self;
}

- (void)setupContentView {
    
    // 当前用户信息
    UserModel *model = [UserModel sharedUserModel];
    
    UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(QRViewMargin, QRViewMargin, 60, 60)];
    icon.image = [UIImage imageNamed:model.userPhotoName];
    icon.layer.cornerRadius = 10;
    icon.clipsToBounds = YES;
    [self addSubview:icon];
    self.icon = icon;
    
    UILabel *name = [[UILabel alloc] init];
    name.text = model.userName;
    name.left = CGRectGetMaxX(icon.frame) + 10;
    name.width = 200;
    name.height = 30;
    name.top = icon.top;
    [self addSubview:name];
    self.name = name;
    
    UILabel *address = [[UILabel alloc] init];
    address.text = model.userAddress;
    address.top = CGRectGetMaxY(name.frame);
    address.width = 250;
    address.height = 30;
    address.left = name.left;
    
    address.textColor = [UIColor lightGrayColor];
    [self addSubview:address];
    self.address = address;
  
    
    UIImageView *qrImg = [[UIImageView alloc] init];
    qrImg.top = CGRectGetMaxY(icon.frame) + 10;
    qrImg.left = QRViewMargin;
    qrImg.width = self.width - QRViewMargin * 2;
    qrImg.height = qrImg.width;
    qrImg.layer.borderColor = [UIColor lightGrayColor].CGColor;
    qrImg.layer.borderWidth = 0.5;
    qrImg.layer.cornerRadius = 10;
    qrImg.clipsToBounds = YES;
    [self addSubview:qrImg];
    self.qrImg = qrImg;
    
#warning ---正式时可以把字符串换成自己的个人主页url等...
    qrImg.image = [QRCodeGenerator qrImageForString:model.userUrl imageSize:self.width - QRViewMargin * 4];
    qrImg.contentMode = UIViewContentModeScaleAspectFit;
    
    
    UIImageView *appIcon = [[UIImageView alloc] init];
    appIcon.x = self.width * 0.5 - 25;
    appIcon.y = qrImg.y + qrImg.height * 0.5 - 25;
    appIcon.width = 50;
    appIcon.height = 50;
    appIcon.layer.cornerRadius = 25;
    appIcon.clipsToBounds = YES;
    appIcon.image = [UIImage imageNamed:model.userPhotoName];
    [self addSubview:appIcon];
    
    self.appIcon = appIcon;
    
    
    UILabel *tipLabel = [[UILabel alloc] init];
    tipLabel.text = @"扫一扫上面的二维码即可加我好友";
    tipLabel.left = 0;
    tipLabel.top = CGRectGetMaxY(qrImg.frame) + 10;
    tipLabel.width = self.width;
    tipLabel.height = 30;
    tipLabel.textColor = [UIColor lightGrayColor];
    tipLabel.font = [UIFont systemFontOfSize:14];
    
    [self addSubview:tipLabel];
    tipLabel.textAlignment = NSTextAlignmentCenter;
}


@end

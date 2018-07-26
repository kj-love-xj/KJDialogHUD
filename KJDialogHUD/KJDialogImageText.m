//
//  KJDialogImageText.m
//  Join
//
//  Created by JOIN iOS on 2018/7/25.
//  Copyright © 2018年 huangkejin. All rights reserved.
//

#import "KJDialogImageText.h"

@interface KJDialogImageText ()

/**背景View*/
@property (strong, nonatomic) UIView *kjContentV;

@end

@implementation KJDialogImageText

- (instancetype)initSuperView:(UIView *)sView {
    self = [super initSuperView:sView];
    if (self) {
        [self loadBgView];
        [self loadImageView];
        [self loadLabel];
    }
    return self;
}

/**初始化背景*/
- (void)loadBgView {
    self.kjContentV = [[UIView alloc] init];
    self.kjContentV.backgroundColor = [UIColor clearColor];
    self.kjContentV.clipsToBounds = YES;
    [self.kjBaseView addSubview:self.kjContentV];
    [self.kjContentV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.kjBaseView);
        make.left.greaterThanOrEqualTo(self.kjBaseView.mas_left).offset(0);
        make.right.lessThanOrEqualTo(self.kjBaseView.mas_right).offset(0);
        make.top.greaterThanOrEqualTo(self.kjBaseView.mas_top).offset(0);
        make.bottom.lessThanOrEqualTo(self.kjBaseView.mas_bottom).offset(0);
    }];
}

/**初始化ImageView*/
- (void)loadImageView {
    self.kjImgV = [[UIImageView alloc] init];
    self.kjImgV.clipsToBounds = YES;
    [self.kjContentV addSubview:self.kjImgV];
    [self.kjImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20.0, 20.0));
        make.centerY.equalTo(self.kjContentV);
        make.left.equalTo(self.kjContentV.mas_left).offset(10.0);
    }];
}

/**初始化Label*/
- (void)loadLabel {
    self.kjLabel = [[UILabel alloc] init];
    self.kjLabel.font = [UIFont systemFontOfSize:13.0];
    self.kjLabel.textColor = [UIColor whiteColor];
    self.kjLabel.textAlignment = NSTextAlignmentCenter;
    self.kjLabel.numberOfLines = 0;
    [self.kjContentV addSubview:self.kjLabel];
    [self.kjLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.kjImgV.mas_right).offset(5.0);
        make.right.equalTo(self.kjContentV.mas_right).offset(-10.0);
        make.top.equalTo(self.kjContentV.mas_top).offset(10.0);
        make.bottom.equalTo(self.kjContentV.mas_bottom).offset(-10.0);
    }];
}

/**设置样式*/
- (void)setKjDirection:(KJDialogImageDirection)kjDirection {
    _kjDirection = kjDirection;
    [self kjUpdateConstraints];
}

/**设置图片大小*/
- (void)setKjSize:(CGSize)kjSize {
    _kjSize = kjSize;
    [self kjUpdateConstraints];
}

/**设置文字和图片的间隔*/
- (void)setKjSpace:(CGFloat)kjSpace {
    _kjSpace = kjSpace;
    [self kjUpdateConstraints];
}

/**设置背景最小高度*/
- (void)setKjMinHeight:(CGFloat)kjMinHeight {
    _kjMinHeight = kjMinHeight;
    if (self.kjDirection == KJDialogImageTop || self.kjDirection == KJDialogImageBottom) {
        [self kjUpdateConstraints];
    }
}

/**更新约束*/
- (void)kjUpdateConstraints {
    CGFloat space = fabs(self.kjSpace);
    CGSize size = self.kjSize;
    
    if (self.kjDirection == KJDialogImageLeft ||
        self.kjDirection == KJDialogImageRight) {
        if (space == 0) {
            space = 5.0;
        }
        if (size.height == 0) {
            size = CGSizeMake(20.0, 20.0);
        }
        //背景View的约束
        [self.kjContentV mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.kjBaseView);
        }];
        //子view的约束
        if (self.kjDirection == KJDialogImageLeft) {
            [self.kjImgV mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.kjContentV);
                make.left.equalTo(self.kjContentV.mas_left).offset(10.0);
                make.size.mas_equalTo(size);
            }];
            [self.kjLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.kjImgV.mas_right).offset(space);
                make.right.equalTo(self.kjContentV.mas_right).offset(-10.0);
                make.top.equalTo(self.kjContentV.mas_top).offset(10.0);
                make.bottom.equalTo(self.kjContentV.mas_bottom).offset(-10.0);
            }];
        } else {
            [self.kjImgV mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.kjContentV);
                make.right.equalTo(self.kjContentV.mas_right).offset(-10.0);
                make.size.mas_equalTo(size);
            }];
            [self.kjLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.kjContentV.mas_right).offset(10.0);
                make.top.equalTo(self.kjContentV.mas_top).offset(10.0);
                make.bottom.equalTo(self.kjContentV.mas_bottom).offset(-10.0);
                make.right.equalTo(self.kjImgV.mas_right).offset(-space);
            }];
        }
        
    } else {
        if (space == 0) {
            space = 10.0;
        }
        if (size.height == 0) {
            size = CGSizeMake(40.0, 40.0);
        }
        CGFloat mHeight = fabs(self.kjMinHeight);
        if (mHeight == 0) {
            mHeight = 120.0;
        }
        //背景View的约束
        [self.kjContentV mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.kjBaseView);
            make.width.mas_equalTo(mHeight);
            make.height.mas_greaterThanOrEqualTo(mHeight);
            make.left.equalTo(self.kjBaseView.mas_left).offset(0);
            make.right.equalTo(self.kjBaseView.mas_right).offset(0);
            make.top.equalTo(self.kjBaseView.mas_top).offset(0);
            make.bottom.equalTo(self.kjBaseView.mas_bottom).offset(0);
        }];
        CGFloat imgHeight = size.height/2.0 + space/2.0;
        if (self.kjDirection == KJDialogImageTop) {
            [self.kjLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.kjContentV.mas_centerY).offset(imgHeight);
                make.centerX.equalTo(self.kjContentV);
                make.bottom.lessThanOrEqualTo(self.kjContentV.mas_bottom).offset(-10.0);
                make.left.greaterThanOrEqualTo(self.kjContentV.mas_left).offset(10.0);
                make.right.lessThanOrEqualTo(self.kjContentV.mas_right).offset(-10.0);
            }];
            [self.kjImgV mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.kjLabel.mas_top).offset(-space);
                make.centerX.equalTo(self.kjContentV);
                make.size.mas_equalTo(size);
            }];
        } else {
            [self.kjLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.kjContentV.mas_centerY).offset(-imgHeight);
                make.centerX.equalTo(self.kjContentV);
                make.top.greaterThanOrEqualTo(self.kjContentV.mas_top).offset(10.0);
                make.left.greaterThanOrEqualTo(self.kjContentV.mas_left).offset(10.0);
                make.right.lessThanOrEqualTo(self.kjContentV.mas_right).offset(-10.0);
            }];
            [self.kjImgV mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.kjLabel.mas_bottom).offset(space);
                make.centerX.equalTo(self.kjContentV);
                make.size.mas_equalTo(size);
            }];
        }
    }
}
@end

//
//  KJDialogActivityText.m
//  Join
//
//  Created by JOIN iOS on 2018/7/24.
//  Copyright © 2018年 huangkejin. All rights reserved.
//

#import "KJDialogActivityText.h"

@interface KJDialogActivityText()
/**activity*/
@property (strong, nonatomic) UIActivityIndicatorView *kjActivity;
/**背景View*/
@property (strong, nonatomic) UIView *kjContentV;
@end

@implementation KJDialogActivityText

- (instancetype) initSuperView:(UIView *)sView {
    self = [super initSuperView:sView];
    if (self) {
        [self loadBgView];
        [self loadActivity];
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
//        make.center.equalTo(self.kjBaseView);
//        make.left.greaterThanOrEqualTo(self.kjBaseView.mas_left).offset(0);
//        make.right.lessThanOrEqualTo(self.kjBaseView.mas_right).offset(0);
//        make.top.greaterThanOrEqualTo(self.kjBaseView.mas_top).offset(0);
//        make.bottom.lessThanOrEqualTo(self.kjBaseView.mas_bottom).offset(0);
        make.edges.equalTo(self.kjBaseView);
    }];
}

/**初始化Activity*/
- (void)loadActivity {
    self.kjActivity = [[UIActivityIndicatorView alloc] init];
    self.kjActivity.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    [self.kjContentV addSubview:self.kjActivity];
    [self.kjActivity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.kjContentV);
        make.left.equalTo(self.kjContentV.mas_left).offset(10.0);
    }];
    [self.kjActivity startAnimating];
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
        make.left.equalTo(self.kjActivity.mas_right).offset(5.0);
        make.right.equalTo(self.kjContentV.mas_right).offset(-10.0);
        make.top.equalTo(self.kjContentV.mas_top).offset(10.0);
        make.bottom.equalTo(self.kjContentV.mas_bottom).offset(-10.0);
    }];
}

/**设置文字和Activity的间隔*/
- (void)setKjSpace:(CGFloat)kjSpace {
    _kjSpace = kjSpace;
    [self kjUpdateConstraints];
}

/**设置展示样式*/
- (void)setKjDirection:(KJDialogActivityDirection)kjDirection {
    _kjDirection = kjDirection;
    if (kjDirection == KJDialogActivityLeft || kjDirection == KJDialogActivityRight) {
        self.kjActivity.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    } else {
        self.kjActivity.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    }
    [self kjUpdateConstraints];
}

/**设置Activity颜色*/
- (void)setKjActivityColor:(UIColor *)kjActivityColor {
    _kjActivityColor = kjActivityColor;
    self.kjActivity.color = kjActivityColor;
}

/**设置内容的最小高度*/
- (void)setKjMinHeight:(CGFloat)kjMinHeight {
    _kjMinHeight = kjMinHeight;
    if (self.kjDirection == KJDialogActivityTop || self.kjDirection == KJDialogActivityBottom) {
        [self kjUpdateConstraints];
    }
}

/**更新约束*/
- (void)kjUpdateConstraints {
    CGFloat space = fabs(self.kjSpace);
    if (self.kjDirection == KJDialogActivityLeft ||
        self.kjDirection == KJDialogActivityRight) {
        if (space == 0) {
            space = 5.0;
        }
        //背景View的约束
        [self.kjContentV mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.kjBaseView);
        }];
        //子view的约束
        if (self.kjDirection == KJDialogActivityLeft) {
            [self.kjActivity mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.kjContentV);
                make.left.equalTo(self.kjContentV.mas_left).offset(10.0);
            }];
            [self.kjLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.kjActivity.mas_right).offset(space);
                make.right.equalTo(self.kjContentV.mas_right).offset(-10.0);
                make.top.equalTo(self.kjContentV.mas_top).offset(10.0);
                make.bottom.equalTo(self.kjContentV.mas_bottom).offset(-10.0);
            }];
        } else {
            [self.kjActivity mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.kjContentV);
                make.right.equalTo(self.kjContentV.mas_right).offset(-10.0);
            }];
            [self.kjLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.kjContentV.mas_right).offset(10.0);
                make.top.equalTo(self.kjContentV.mas_top).offset(10.0);
                make.bottom.equalTo(self.kjContentV.mas_bottom).offset(-10.0);
                make.right.equalTo(self.kjActivity.mas_right).offset(-space);
            }];
        }
        
    } else {
        if (space == 0) {
            space = 10.0;
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
        CGFloat activityHeight = 37.0/2.0 + space/2.0;
        if (self.kjDirection == KJDialogActivityTop) {
            [self.kjLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.kjContentV.mas_centerY).offset(activityHeight);
                make.centerX.equalTo(self.kjContentV);
                make.bottom.lessThanOrEqualTo(self.kjContentV.mas_bottom).offset(-10.0);
                make.left.greaterThanOrEqualTo(self.kjContentV.mas_left).offset(10.0);
                make.right.lessThanOrEqualTo(self.kjContentV.mas_right).offset(-10.0);
            }];
            [self.kjActivity mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.kjLabel.mas_top).offset(-space);
                make.centerX.equalTo(self.kjContentV);
            }];
        } else {
            [self.kjLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.kjContentV.mas_centerY).offset(-activityHeight);
                make.centerX.equalTo(self.kjContentV);
                make.top.greaterThanOrEqualTo(self.kjContentV.mas_top).offset(10.0);
                make.left.greaterThanOrEqualTo(self.kjContentV.mas_left).offset(10.0);
                make.right.lessThanOrEqualTo(self.kjContentV.mas_right).offset(-10.0);
            }];
            [self.kjActivity mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.kjLabel.mas_bottom).offset(space);
                make.centerX.equalTo(self.kjContentV);
            }];
        }
    }
}
@end

//
//  KJDialogBaseView.m
//  Join
//
//  Created by JOIN iOS on 2018/7/19.
//  Copyright © 2018年 huangkejin. All rights reserved.
//

#import "KJDialogBaseView.h"

@interface KJDialogBaseView ()
/**superView*/
@property (strong, nonatomic) UIView *spView;

@end

@implementation KJDialogBaseView

/**初始化*/
- (instancetype)initSuperView:(UIView *)sView {
    self = [super init];
    if (self) {
        if (!sView) {
            sView = [UIApplication sharedApplication].keyWindow;
        }
        self.backgroundColor = [UIColor clearColor];
        [sView addSubview:self];
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(sView);
            make.left.greaterThanOrEqualTo(sView.mas_left).offset(13.0);
            make.right.lessThanOrEqualTo(sView.mas_right).offset(-13.0);
            make.top.greaterThanOrEqualTo(sView.mas_top).offset(13.0);
            make.bottom.lessThanOrEqualTo(sView.mas_bottom).offset(-13.0);
        }];
        self.spView = sView;
        [self loadKjView];
    }
    return self;
}

/**初始化背景view*/
- (void)loadKjView {
    self.kjBaseView = [[UIView alloc] init];
    self.kjBaseView.backgroundColor = [UIColor blackColor];
    self.kjBaseView.layer.cornerRadius = 4.0;
    self.kjBaseView.clipsToBounds = YES;
    self.kjBaseView.hidden = YES;
    [self addSubview:self.kjBaseView];
    [self.kjBaseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

/**设置距离*/
- (void)setKjDistance:(CGFloat)kjDistance {
    _kjDistance = kjDistance;
    [self kjBaseUpdateConstraints];
}

/**设置样式*/
- (void)setKjBaseMode:(KJDialogBaseMode)kjBaseMode {
    _kjBaseMode = kjBaseMode;
    [self kjBaseUpdateConstraints];
}


/**设置内容背景颜色*/
- (void)setKjBaseColor:(UIColor *)kjBaseColor {
    if (kjBaseColor) {
        _kjBaseColor = kjBaseColor;
        self.kjBaseView.backgroundColor = kjBaseColor;
    }
}

/**设置内容背景圆角*/
- (void)setKjRadius:(CGFloat)kjRadius {
    self.kjBaseView.layer.cornerRadius = kjRadius;
}


/**外部调用展示*/
- (void)kjShowTime:(NSTimeInterval)kjSeconds {
    if (self.kjBaseView.isHidden) {
        [self.spView bringSubviewToFront:self];
        self.kjBaseView.hidden = NO;
        [self layoutIfNeeded];
    }
    if (kjSeconds > 0) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW,
                                     (int64_t)(kjSeconds * NSEC_PER_SEC)),
                       dispatch_get_main_queue(), ^{
                           [self removeFromSuperview];
                       });
    }
}

#define angle2Radio(angle) ((angle) * M_PI / 180.0)
/**动画展示*/
- (void)kjShowTime:(NSTimeInterval)kjSeconds
       kjAnimation:(KJAnimationShowMode)kjAnimation {
    if (self.kjBaseView.isHidden) {
        [self.spView bringSubviewToFront:self];
        self.kjBaseView.hidden = NO;
        [self layoutIfNeeded];
    }
    //动画处理
    if (kjAnimation == KJAnimationNone) {
        [self kjShowTime:kjSeconds];
    } else {
        if (kjAnimation == KJAnimationShake) {
            CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
            anim.duration = 0.25;
            anim.keyPath = @"transform.rotation";
            anim.values = @[@(angle2Radio(-5)),@(angle2Radio(5)),@(angle2Radio(-5))];
            anim.repeatCount = 2;
            [self.kjBaseView.layer addAnimation:anim forKey:nil];
        } else if (kjAnimation == KJAnimationHeartbeat) {
            CABasicAnimation *anim = [CABasicAnimation animation];
            anim.keyPath = @"transform.scale";
            anim.duration = 0.25;
            anim.repeatCount = 2;
            anim.autoreverses = YES;
            anim.fromValue = @(1.0);
            anim.toValue = @(1.2);
            anim.removedOnCompletion = NO;
            [self.kjBaseView.layer addAnimation:anim forKey:@"kjAnimation"];
        }
        else {
            CATransition *anim = [CATransition animation];
            anim.type = @"moveIn";
            anim.duration = 0.25;
            if (kjAnimation == KJAnimationMoveLeft) {
                anim.subtype = kCATransitionFromLeft;
            } else if (kjAnimation == KJAnimationMoveRight) {
                anim.subtype = kCATransitionFromRight;
            } else if (kjAnimation == KJAnimationMoveTop) {
                anim.subtype = kCATransitionFromTop;
            } else if (kjAnimation == KJAnimationMoveBottom) {
                anim.subtype = kCATransitionFromBottom;
            }
            [self.kjBaseView.layer addAnimation:anim forKey:nil];
        }
        [self kjShowTime:kjSeconds];
    }
}

/**动画展示-由外部自定义动画*/
- (void)kjShowTime:(NSTimeInterval)kjSeconds
   customAnimation:(void (^) (UIView *kjView))kjAnimation {
    if (self.kjBaseView.isHidden) {
        [self.spView bringSubviewToFront:self];
        self.kjBaseView.hidden = NO;
        [self layoutIfNeeded];
    }
    if (kjAnimation) {
        kjAnimation(self.kjBaseView);
    }
    [self kjShowTime:kjSeconds];
}

/**外部调用隐藏*/
+ (void)kjHiddenFromSuperView:(UIView *)kjSuperV {
    if (!kjSuperV) {
        kjSuperV = [UIApplication sharedApplication].keyWindow;
    }
    for (UIView *kjView in kjSuperV.subviews) {
        if ([kjView isKindOfClass:[KJDialogBaseView class]]) {
            [kjView removeFromSuperview];
        }
    }
}

/**更新约束*/
- (void)kjBaseUpdateConstraints {
    CGFloat distance = fabs(self.kjDistance);
    if (self.kjBaseMode == KJDialogBaseNone || self.kjBaseMode == KJDialogBaseFull) {
        distance = self.kjDistance;
    }
    if (self.kjBaseMode == KJDialogBaseNone ||
        self.kjBaseMode == KJDialogBaseTop ||
        self.kjBaseMode == KJDialogBaseBottom ) {
        //内容层的约束更新
        [self.kjBaseView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        //透明层约束
        if (self.kjBaseMode == KJDialogBaseNone) {
            [self mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.spView.mas_centerY).offset(distance);
                make.centerX.equalTo(self.spView);
                make.left.greaterThanOrEqualTo(self.spView.mas_left).offset(13.0);
                make.right.lessThanOrEqualTo(self.spView.mas_right).offset(-13.0);
                make.top.greaterThanOrEqualTo(self.spView.mas_top).offset(13.0);
                make.bottom.lessThanOrEqualTo(self.spView.mas_bottom).offset(-13.0);
            }];
        } else if (self.kjBaseMode == KJDialogBaseTop) {
            [self mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.spView.mas_top).offset(distance);
                make.centerX.equalTo(self.spView);
                make.left.greaterThanOrEqualTo(self.spView.mas_left).offset(13.0);
                make.right.lessThanOrEqualTo(self.spView.mas_right).offset(-13.0);
                make.bottom.lessThanOrEqualTo(self.spView.mas_bottom).offset(-13.0);
            }];
        } else if (self.kjBaseMode == KJDialogBaseBottom) {
            [self mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.spView.mas_bottom).offset(-distance);
                make.centerX.equalTo(self.spView);
                make.left.greaterThanOrEqualTo(self.spView.mas_left).offset(13.0);
                make.right.lessThanOrEqualTo(self.spView.mas_right).offset(-13.0);
                make.top.greaterThanOrEqualTo(self.spView.mas_top).offset(13.0);
            }];
        }
    } else {
        //透明层的约束更新
        [self mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.spView);
        }];
        //设置内容层约束
        if (self.kjBaseMode == KJDialogBaseFull) {
            [self.kjBaseView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.mas_centerY).offset(distance);
                make.centerX.equalTo(self);
                make.left.greaterThanOrEqualTo(self.mas_left).offset(13.0);
                make.right.lessThanOrEqualTo(self.mas_right).offset(-13.0);
                make.top.greaterThanOrEqualTo(self.mas_top).offset(13.0);
                make.bottom.lessThanOrEqualTo(self.mas_bottom).offset(-13.0);
            }];
        } else if (self.kjBaseMode == KJDialogBaseFull_t) {
            [self.kjBaseView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.mas_top).offset(distance);
                make.centerX.equalTo(self);
                make.left.greaterThanOrEqualTo(self.mas_left).offset(13.0);
                make.right.lessThanOrEqualTo(self.mas_right).offset(-13.0);
                make.bottom.lessThanOrEqualTo(self.mas_bottom).offset(-13.0);
            }];
        } else if (self.kjBaseMode == KJDialogBaseFull_b) {
            [self.kjBaseView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.mas_bottom).offset(-distance);
                make.centerX.equalTo(self);
                make.left.greaterThanOrEqualTo(self.mas_left).offset(13.0);
                make.right.lessThanOrEqualTo(self.mas_right).offset(-13.0);
                make.top.greaterThanOrEqualTo(self.mas_top).offset(13.0);
            }];
        }
    }
    [self layoutIfNeeded];
}

@end

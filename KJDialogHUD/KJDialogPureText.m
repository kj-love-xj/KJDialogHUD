//
//  KJDialogPureText.m
//  Join
//
//  Created by JOIN iOS on 2018/7/19.
//  Copyright © 2018年 huangkejin. All rights reserved.
//

#import "KJDialogPureText.h"



@implementation KJDialogPureText

- (instancetype) initSuperView:(UIView *)sView {
    self = [super initSuperView:sView];
    if (self) {
        [self loadLabel];
    }
    return self;
}

/**初始化文本展示Label*/
- (void)loadLabel {
    self.kjLabel = [[UILabel alloc] init];
    self.kjLabel.textColor = [UIColor whiteColor];
    self.kjLabel.font = [UIFont systemFontOfSize:13.0];
    self.kjLabel.textAlignment = NSTextAlignmentCenter;
    self.kjLabel.numberOfLines = 0;
    [self.kjBaseView addSubview:self.kjLabel];
    [self.kjLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.kjBaseView).insets(UIEdgeInsetsMake(10, 10, 10, 10));
    }];
}

@end

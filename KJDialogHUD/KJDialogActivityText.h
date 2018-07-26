//
//  KJDialogActivityText.h
//  Join
//
//  Created by JOIN iOS on 2018/7/24.
//  Copyright © 2018年 huangkejin. All rights reserved.
//

#import "KJDialogBaseView.h"

@interface KJDialogActivityText : KJDialogBaseView

typedef NS_ENUM(NSInteger, KJDialogActivityDirection) {
    KJDialogActivityLeft = 0,   //activity在左，文字在右，该模式下是UIActivityIndicatorViewStyleWhite
    KJDialogActivityRight,      //activity在右，文字在左，该模式下是UIActivityIndicatorViewStyleWhite
    KJDialogActivityTop,        //activity在上，文字在下，该模式下是UIActivityIndicatorViewStyleWhiteLarge
    KJDialogActivityBottom,     //activity在下，文字在上，该模式下是UIActivityIndicatorViewStyleWhiteLarge
};

/**UIlabel*/
@property (strong, nonatomic) UILabel *kjLabel;
/**设置文字和Activity之间的间隔  >0的值
 KJDialogActivityLeft|KJDialogActivityRight 默认是5
 KJDialogActivityTop|KJDialogActivityBottom 默认是10
 */
@property (assign, nonatomic) CGFloat kjSpace;
/**设置Activity颜色*/
@property (strong, nonatomic) UIColor *kjActivityColor;
/**设置Activity方向 默认KJDialogActivityLeft*/
@property (assign, nonatomic) KJDialogActivityDirection kjDirection;
/**设置内容最小高度(同时也是固定的宽度)，
 只有在KJDialogActivityTop|KJDialogActivityBottom模式下有效，
 默认是120 必须是>0的值*/
@property (assign, nonatomic) CGFloat kjMinHeight;

@end

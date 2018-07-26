//
//  KJDialogImageText.h
//  Join
//
//  Created by JOIN iOS on 2018/7/25.
//  Copyright © 2018年 huangkejin. All rights reserved.
//

#import "KJDialogBaseView.h"

@interface KJDialogImageText : KJDialogBaseView

typedef NS_ENUM(NSInteger, KJDialogImageDirection) {
    KJDialogImageLeft = 0,  //图片在左，文字在右
    KJDialogImageRight,     //图片在右，文字在左
    KJDialogImageTop,       //图片在上，文字在下
    KJDialogImageBottom     //图片在下，文字在上
};

/**UILabel*/
@property (strong, nonatomic) UILabel *kjLabel;
/**UIImageView*/
@property (strong, nonatomic) UIImageView *kjImgV;
/**设置展示样式*/
@property (assign, nonatomic) KJDialogImageDirection kjDirection;
/**设置图片大小
 KJDialogImageLeft|KJDialogImageRight 默认是20，20
 KJDialogImageTop|KJDialogImageBottom 默认是40，40
 */
@property (nonatomic) CGSize kjSize;
/**设置文字和图片之间的间隔，
 KJDialogImageLeft|KJDialogImageRight 默认是5
 KJDialogImageTop|KJDialogImageBottom 默认是10
 */
@property (assign, nonatomic) CGFloat kjSpace;
/**设置背景最小高度(同时也是固定宽度) 默认120
 该属性只在KJDialogImageTop|KJDialogImageBottom有效
 */
@property (assign, nonatomic) CGFloat kjMinHeight;

@end

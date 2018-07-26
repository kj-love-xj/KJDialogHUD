//
//  KJDialogBaseView.h
//  Join
//
//  Created by JOIN iOS on 2018/7/19.
//  Copyright © 2018年 huangkejin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KJDialogBaseView : UIView

typedef NS_ENUM(NSInteger, KJDialogBaseMode) {
    KJDialogBaseNone = 0,   //内容居中展示，该模式下，透明层不会覆盖superView，可以设置kjDistance来改变centerY
    KJDialogBaseTop,        //内容紧靠顶部展示，该模式下，透明层不会覆盖superView，可以设置kjDistance来改变顶部距离
    KJDialogBaseBottom,     //内容紧靠底部展示，该模式下，透明层不会覆盖superView，可以设置kjDistance来改变顶部距离
    
    KJDialogBaseFull,       //内容居中展示，该模式下，透明层会覆盖整个superView，可以设置kjDistance来改变centerY
    KJDialogBaseFull_t,     //内容紧靠顶部展示，该模式下，透明层会覆盖superView，可以设置kjDistance来改变底部距离
    KJDialogBaseFull_b,     //内容紧靠底部展示，该模式下，透明层会覆盖superView，可以设置kjDistance来改变底部距离
};

typedef NS_ENUM(NSInteger, KJAnimationShowMode) {
    KJAnimationNone = 0,        //无动画效果
    KJAnimationShake,           //摇动、抖动
    KJAnimationHeartbeat,       //心跳
    KJAnimationMoveLeft,        //从左到右移动
    KJAnimationMoveRight,       //从右到左移动
    KJAnimationMoveTop,         //从上到下移动 
    KJAnimationMoveBottom       //从下到上移动
};

/**初始化*/
- (instancetype)initSuperView:(UIView *)sView;
/**内容背景View*/
@property (strong, nonatomic) UIView *kjBaseView;
/**设置内容背景颜色 默认为blackColor*/
@property (nonatomic) UIColor *kjBaseColor;
/**设置内容背景圆角 默认是4*/
@property (assign, nonatomic) CGFloat kjRadius;
/**配合KJDialogBaseMode，设置自定义约束，
 当为KJDialogBaseNone或KJDialogBaseFull时，该值区分正负值，其它模式下不区分正负值(取绝对值)，
 默认为0
 */
@property (assign, nonatomic) CGFloat kjDistance;
/**设置覆盖样式 默认None*/
@property (assign, nonatomic) KJDialogBaseMode kjBaseMode;
/**设置展示的时间，默认是一直展示，
 当该值>0时，就会在该时间后会自动消失
 当该值<=0时，就不会自动消失，需要主动调用kjHiddenFromSuperView来让其消失
 */
- (void)kjShowTime:(NSTimeInterval)kjSeconds;
/**动画展示-内置简单动画KJAnimationShowMode*/
- (void)kjShowTime:(NSTimeInterval)kjSeconds
       kjAnimation:(KJAnimationShowMode)kjAnimation;
/**动画展示-由外部自定义动画*/
- (void)kjShowTime:(NSTimeInterval)kjSeconds
   customAnimation:(void (^) (UIView *kjView))kjAnimation;
/**外部调用隐藏，当时间设置为<=0时，是不会自动隐藏的，需要调用该方法进行隐藏*/
+ (void)kjHiddenFromSuperView:(UIView *)kjSuperV;

@end

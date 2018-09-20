# KJDialogHUD
一个简易的会话框/提示框

# 使用说明
```Object-c
#import "KJDialogBaseView.h"
#import "KJDialogPureText.h"
#import "KJDialogImageText.h"
#import "KJDialogActivityText.h"


//纯文本
//如果设置superView 则展示在指定的view上，如果不指定，则展示在window上
KJDialogPureText *kjDialog = [[KJDialogPureText alloc] initSuperView:nil];
//有六种模式，full表示透明层会覆盖整个页面，其它的不会覆盖
kjDialog.kjBaseMode = KJDialogBaseFull;
//设置自定义约束
kjDialog.kjDistance = -49.0;
kjDialog.kjLabel.font = [UIFont systemFontOfSize:15.0];
kjDialog.kjLabel.text = @"提示的文本内容";
//展示时间，如过不设置或者时间为<=0，则不会自动消失(需要调用kjHiddenFromSuperView让其消失)
//展示方式有3中，不指定动画、使用内置的简单动画、自定义动画等三种方式
[kjDialog kjShowTime:1.5];//不使用动画展示
[kjDialog kjShowTime:1.5 kjAnimation: KJAnimationShowMode/*指定内置动画*/];//使用内置的动画
[kjDialog kjShowTime:1.5 customAnimation:(^)(UIView *kjView) {
  //这里进行自定义动画处理
}];



//Activity+文本
KJDialogActivityText *kjDialog = [[KJDialogActivityText alloc] initSuperView:nil];
kjDialog.kjDistance = -49.0;
kjDialog.kjLabel.font = [UIFont systemFontOfSize:15.0];
kjDialog.kjLabel.text = kjText;
//相对于纯文本，这里多了一个kjDirection属性，来设置Activity和文本的位置，默认KJDialogActivityLeft
/*
    KJDialogActivityLeft = 0,   //activity在左，文字在右，该模式下是UIActivityIndicatorViewStyleWhite
    KJDialogActivityRight,      //activity在右，文字在左，该模式下是UIActivityIndicatorViewStyleWhite
    KJDialogActivityTop,        //activity在上，文字在下，该模式下是UIActivityIndicatorViewStyleWhiteLarge
    KJDialogActivityBottom,     //activity在下，文字在上，该模式下是UIActivityIndicatorViewStyleWhiteLarge
*/
kjDialog.kjDirection = KJDialogActivityRight;
[kjDialog kjShowTime:0];




//图片 + 文本
KJDialogImageText *kjDialog = [[KJDialogImageText alloc] initSuperView:kjView];
kjDialog.kjDistance = -49.0;
kjDialog.kjDirection = KJDialogImageTop;
kjDialog.kjLabel.text = kjText;
kjDialog.kjLabel.font = [UIFont systemFontOfSize:15.0];
kjDialog.kjImgV.image = [UIImage imageNamed:@"save_complete_icon"];
/*
    KJDialogImageLeft = 0,  //图片在左，文字在右
    KJDialogImageRight,     //图片在右，文字在左
    KJDialogImageTop,       //图片在上，文字在下
    KJDialogImageBottom     //图片在下，文字在上
*/
kjDialog.kjDirection = KJDialogImageTop
[kjDialog kjShowTime:1.5];

```

# 详细说明
https://www.jianshu.com/p/8fcdd0f25fda

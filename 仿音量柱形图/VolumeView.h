//
//  VolumeView.h
//  仿音量柱形图
//
//  Created by sam on 2018/9/13.
//  Copyright © 2018年 sam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VolumeView : UIView

@property (nonatomic, assign) CGFloat selectedValue;//选中值
@property (nonatomic, assign) CGFloat minValue; //最小值
@property (nonatomic, assign) CGFloat maxValue; //最大值
@property (nonatomic, assign) CGFloat columnW; //圆柱宽
@property (nonatomic, assign) CGFloat columnH; //圆柱高
@property (nonatomic, assign) CGFloat cornerRad; //圆角

@end

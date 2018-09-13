//
//  UIColor+HexColor.h
//  仿音量柱形图
//
//  Created by sam on 2018/9/13.
//  Copyright © 2018年 sam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HexColor)

+ (UIColor*)colorWithHexString:(NSString*)stringToConvert;

@end

//
//  VolumeView.m
//  仿音量柱形图
//
//  Created by sam on 2018/9/13.
//  Copyright © 2018年 sam. All rights reserved.
//

#import "VolumeView.h"
#import "UIColor+HexColor.h"

@interface VolumeView ()

@property (nonatomic, strong) CALayer *backgroundLayer;//底部
@property (nonatomic, strong) CAShapeLayer *upperLayer;//覆盖

@end

@implementation VolumeView

- (void)setup {
    self.backgroundLayer = [CALayer layer];
    self.backgroundLayer.backgroundColor = [UIColor colorWithHexString:@"#262626"].CGColor;
    self.backgroundLayer.borderColor = [UIColor colorWithHexString:@"#262626"].CGColor;
    self.backgroundLayer.borderWidth = 0.1;
    self.backgroundLayer.cornerRadius = _cornerRad;
    [self.layer addSublayer:self.backgroundLayer];
    
    self.upperLayer = [CAShapeLayer layer];
    self.upperLayer.backgroundColor = [UIColor whiteColor].CGColor;
    [self.layer addSublayer:self.upperLayer];
    
    self.maxValue = 1;
    self.minValue = 0;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

-(void)awakeFromNib {
    [super awakeFromNib];
    [self setup];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect currentFrame = self.frame;
    float xMiddle = currentFrame.size.width/2.0 ;
    float yMiddle = currentFrame.size.height/2.0 ;
    self.backgroundLayer.frame = CGRectMake(0, 0, _columnW, _columnH);
    self.backgroundLayer.position = CGPointMake(xMiddle, yMiddle);
    
    [self updateupperLayerPositions];
    
}

- (void)updateupperLayerPositions {
    float x = self.frame.size.width/2.0 - _columnW*0.5 ;
    float y = CGRectGetMaxY(self.backgroundLayer.frame) ;
    float cornerH = _cornerRad/_columnH;
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGPoint leftDP = CGPointMake(self.frame.size.width/2.0 - _columnW*0.5+_cornerRad, y-_cornerRad);
    CGPoint rightDP = CGPointMake(self.frame.size.width/2.0 + _columnW*0.5-_cornerRad, y-_cornerRad);
    CGPoint leftTP = CGPointMake(self.frame.size.width/2.0 - _columnW*0.5+_cornerRad, CGRectGetMinY(self.backgroundLayer.frame)+12);
    CGPoint rightTP = CGPointMake(self.frame.size.width/2.0 + _columnW*0.5-_cornerRad, CGRectGetMinY(self.backgroundLayer.frame)+_cornerRad);
    [path moveToPoint:CGPointMake(rightDP.x, y)];
    
    if (_selectedValue > cornerH) {
        [path addArcWithCenter:leftDP radius:_cornerRad startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
        if (_selectedValue > (1-cornerH)) {
            [path addArcWithCenter:leftTP radius:_cornerRad startAngle:M_PI endAngle:(M_PI+M_PI_2*((_selectedValue-(1-cornerH))/cornerH)) clockwise:YES];
            [path addArcWithCenter:rightTP radius:_cornerRad startAngle:-M_PI_2*((_selectedValue-(1-cornerH))/cornerH) endAngle:0 clockwise:YES];
        } else {
            [path addLineToPoint:CGPointMake(x, y-_selectedValue*_columnH)];
            [path addLineToPoint:CGPointMake(x+_columnW, y-_selectedValue*_columnH)];
        }
        [path addArcWithCenter:rightDP radius:_cornerRad startAngle:0 endAngle:-(M_PI_2+M_PI) clockwise:YES];
        
    } else {
        [path addArcWithCenter:leftDP radius:_cornerRad startAngle:M_PI_2 endAngle:M_PI_2+M_PI_2*(_selectedValue/cornerH) clockwise:YES];
        
        [path addArcWithCenter:rightDP radius:_cornerRad startAngle:-(M_PI_2+M_PI)-M_PI_2*(_selectedValue/cornerH) endAngle:-(M_PI_2+M_PI) clockwise:YES];
    }
    
    self.upperLayer.path = path.CGPath;
    self.upperLayer.fillColor = [UIColor whiteColor].CGColor;
    //    self.upperLayer.frame = CGRectMake(x, CGRectGetMaxY(self.backgroundLayer.frame)-_selectedValue*100, 44, _selectedValue*100);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //    UITouch *touchCenter = [touches anyObject];
    //    CGPoint point = [touchCenter locationInView:self];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touchCenter = [touches anyObject];
    CGPoint point = [touchCenter locationInView:self];
    float percentage = (point.y-CGRectGetMinY(self.backgroundLayer.frame)) /(CGRectGetMaxY(self.backgroundLayer.frame) - CGRectGetMinY(self.backgroundLayer.frame)) ;
    if (percentage < 0) {
        percentage = 0;
    }
    if (percentage >=1) {
        percentage = 1;
    }
    percentage = 1-percentage;
    float selectedValue = percentage * (self.maxValue - self.minValue) + self.minValue;
    _selectedValue = selectedValue;
    [self updateupperLayerPositions];
    NSLog(@"----%f",percentage);
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

- (void)setSelectedValue:(CGFloat)selectedValue {
    _selectedValue = selectedValue;
    [self updateupperLayerPositions];
}

- (void)setCornerRad:(CGFloat)cornerRad {
    _cornerRad = cornerRad;
    self.backgroundLayer.cornerRadius = _cornerRad;
}

@end

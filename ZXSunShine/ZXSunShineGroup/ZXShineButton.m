//
//  ZXShineButton.m
//  ZXSunShine
//
//  Created by 忠晓 on 2017/6/9.
//  Copyright © 2017年 忠晓. All rights reserved.
//

#import "ZXShineButton.h"
#import "ZXShineLayer.h"
#import "ZXShineAngleLayer.h"
#import "ZXShineClickLayer.h"

@interface ZXShineButton()

@property (nonatomic,strong)ZXShineClickLayer *clickLayer;
@property (nonatomic,strong)ZXShineLayer *shineLayer;

@end

@implementation ZXShineButton

+ (instancetype)makeShineButton:(buttonBlock)buttonBlock andParams:(paramsBlock)paramsBlock
{
    ZXShineParams *params = [ZXShineParams makeShineParams];
    
    if(paramsBlock)
    {
        paramsBlock(params);
    }
    
    ZXShineButton *button = [[ZXShineButton alloc] initWithParams:params];
    if(buttonBlock)
    {
        buttonBlock(button);
    }
    
    return button;
}

- (instancetype)initWithParams:(ZXShineParams *)params
{
    if(self = [super init])
    {
        self.color = [UIColor lightGrayColor];
        self.params = params;
        self.fillColor = [UIColor colorWithRed:255/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
        
        [self initLayers];

    }
    return self;
}

- (void)setParams:(ZXShineParams *)params
{
    _params = params;
    self.clickLayer.animDuration = params.animDuration / 3;
    self.shineLayer.params = params;
}

- (void)setColor:(UIColor *)color
{
    _color = color;
    
    self.clickLayer.color = color;
    self.shineLayer.color = color;
}

- (void)setFillColor:(UIColor *)fillColor
{
    _fillColor = fillColor;
    
    self.clickLayer.fillColor = fillColor;
    self.shineLayer.fillColor = fillColor;
}

- (ZXShineClickLayer *)clickLayer
{
    if(!_clickLayer)
    {
        _clickLayer = [ZXShineClickLayer layer];
        _clickLayer.backgroundColor = [UIColor yellowColor].CGColor;
    }
    return _clickLayer;
}

- (ZXShineLayer *)shineLayer
{
    if(!_shineLayer)
    {
        _shineLayer = [ZXShineLayer layer];
    }
    return _shineLayer;
}

- (void)setImage:(ZXShineImageType)image
{
    self.clickLayer.image(image);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    if(self.clickLayer.clicked == false)
    {
        __weak typeof(self) weakSelf = self;
        self.shineLayer.endAnim = ^()
        {
            weakSelf.clickLayer.clicked = !weakSelf.clickLayer.clicked;
            weakSelf.clickLayer.startAnim();
            weakSelf.isSelected = weakSelf.clickLayer.clicked;
        };
        self.shineLayer.startAnim();
    }else{
        self.clickLayer.clicked = !self.clickLayer.clicked;
        self.isSelected = self.clickLayer.clicked;
    }
}

- (void)initLayers
{
    self.clickLayer.animDuration = self.params.animDuration / 3;
    self.shineLayer.params = self.params;
    [self.layer addSublayer:self.clickLayer];
    [self.layer addSublayer:self.shineLayer];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.clickLayer.frame = self.bounds;
    self.shineLayer.frame = self.bounds;
}
@end

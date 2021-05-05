//
//  CustomerScrollView.m
//  自定义scrollView
//
//  Created by 李雅珠 on 2021/5/4.
//

#import "CustomerScrollView.h"

@interface CustomerScrollView ()

@property (nonatomic, assign) CGPoint startPoint;

@end

@implementation CustomerScrollView

- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UIPanGestureRecognizer *panG = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
        [self addGestureRecognizer:panG];
        self.layer.masksToBounds = YES;
    }
    return self;
}

- (void)panGesture:(UIPanGestureRecognizer *)pan{
    if (pan.state == UIGestureRecognizerStateBegan) {
        self.startPoint = self.bounds.origin;
    }
    else if (pan.state == UIGestureRecognizerStateChanged){
        CGPoint point = [pan translationInView:self];
        CGFloat newStartX = self.startPoint.x - point.x;
        CGFloat newStartY = self.startPoint.y - point.y;

        // 根据拖动值计算出新的坐标
        CGRect bounds = self.bounds;
        bounds.origin = CGPointMake(newStartX, newStartY);

        // 约束x,y不能超过最大边界
        // 约束最大x
        if (bounds.origin.x + bounds.size.width > _contentSize.width + self.contentInset.right) {
            bounds.origin.x = _contentSize.width + self.contentInset.right - bounds.size.width;
        }
        // 约束最大y
        if (bounds.origin.y + bounds.size.height > _contentSize.height + self.contentInset.bottom) {
            bounds.origin.y = _contentSize.height + self.contentInset.bottom - bounds.size.height;
        }
        // 约束最小x
        if (bounds.origin.x < -self.contentInset.left) {
            bounds.origin.x = -self.contentInset.left;
        }
        // 约束最下y
        if (bounds.origin.y < -self.contentInset.top) {
            bounds.origin.y = -self.contentInset.top;
        }
        self.bounds = bounds;
    }
}

- (void)setContentSize:(CGSize)contentSize{
    _contentSize = contentSize;
}

- (void)setContentOffset:(CGPoint)contentOffset {
    _contentOffset = contentOffset;
    CGRect bounds = self.bounds;
    bounds.origin = _contentOffset;
    self.bounds = bounds;
}


@end

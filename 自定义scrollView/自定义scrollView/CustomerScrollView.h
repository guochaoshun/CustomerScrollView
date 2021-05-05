//
//  CustomerScrollView.h
//  自定义scrollView
//
//  Created by 李雅珠 on 2021/5/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomerScrollView : UIView

@property (nonatomic, assign) CGPoint contentOffset;
@property (nonatomic, assign) CGSize contentSize;
@property (nonatomic, assign) UIEdgeInsets contentInset;

@end

NS_ASSUME_NONNULL_END

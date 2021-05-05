//
//  ViewController.m
//  自定义scrollView
//
//  Created by 李雅珠 on 2021/5/4.
//

#import "ViewController.h"
#import "CustomerScrollView.h"

#define Screen_Width [[UIScreen mainScreen] bounds].size.width
#define Screen_Height [[UIScreen mainScreen] bounds].size.height
#define RANDOM_COLOR [UIColor colorWithRed:(arc4random_uniform(100)/ 100.0) green:(arc4random_uniform(100)/ 100.0) blue:(arc4random_uniform(100)/ 100.0) alpha:1.0]


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self testCustonScollView];

}

#pragma mark 自定义ScrollView封装
- (void)testCustonScollView {
    CustomerScrollView *sc = [[CustomerScrollView alloc] initWithFrame:CGRectMake(0, 100, Screen_Width, Screen_Width)];
    sc.contentSize = CGSizeMake(1000, 1000);
    sc.contentInset = UIEdgeInsetsMake(30, 30, 30, 30);
    sc.contentOffset = CGPointMake(100, 100);
    sc.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:sc];


    for (int i = 0; i<10; i++) {

        for (int j = 0; j<10; j++) {
                UIView * red = [[UIView alloc] initWithFrame:CGRectMake(100*i, 100*j, 100, 100)];
                red.backgroundColor = RANDOM_COLOR;
                [sc addSubview:red];
        }

    }
}

// 下面的可不看,直接到CustomerScrollView中看,下面是学习和练习的过程
#pragma mark 在self.view上实验
- (void)addGestureAndViews {
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePanGesture:)];
    [self.view addGestureRecognizer:pan];

    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 20, 100, 100)];
    [view1 setBackgroundColor:[UIColor blueColor]];
    [self.view addSubview:view1];

    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(Screen_Width - 100, Screen_Height - 100, 100, 100)];
    [view2 setBackgroundColor:[UIColor brownColor]];
    [self.view addSubview:view2];
}

- (void)handlePanGesture:(UIPanGestureRecognizer *)panGestureRecognizer {

    //ContentInset
    CGPoint touchPoint = [panGestureRecognizer translationInView:self.view];//获取手势位置
    CGFloat newOriginY = self.view.bounds.origin.y - touchPoint.y;//根据手势位置计算新的origin值
    CGFloat newOriginX = self.view.bounds.origin.x - touchPoint.x;

    CGFloat min = 0.0;
    CGFloat maxOriginY = 600.0;
    CGFloat maxOriginX = 0;

    if (panGestureRecognizer.state == UIGestureRecognizerStateEnded) {
            min = -50.0;
            maxOriginY = 600.0;
    } else {
            min = -50.0;
            maxOriginY = 650.0;
    }

    CGRect viewBounds = self.view.bounds;
    viewBounds.origin.y = fmax(min, fmin(newOriginY, maxOriginY));//比最大值小的同时比最小值大：min<=newOriginY<=maxOriginY
    viewBounds.origin.x = fmax(0, fmin(newOriginX, maxOriginX));
    self.view.bounds = viewBounds;
    [panGestureRecognizer setTranslation:CGPointZero inView:self.view];

}

#pragma mark 系统的UIScrollView,确认了contenOffset和bounds.origin是同步变化的
- (void)testSystemScrollView {
    UIScrollView * sc = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 100, Screen_Width, Screen_Width)];
    sc.backgroundColor = [UIColor lightGrayColor];
    sc.contentSize = CGSizeMake(1000, 1000);
    [self.view addSubview:sc];

    for (int i = 0; i<10; i++) {

        for (int j = 0; j<10; j++) {
                UIView * red = [[UIView alloc] initWithFrame:CGRectMake(100*i, 100*j, 30, 30)];
                red.backgroundColor = RANDOM_COLOR;
                [sc addSubview:red];
        }

    }

}




// 帮助理解bounds的作用
- (void)testBounds {

    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height)];
    bgView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:bgView];

    UIView * red = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 100, 100)];
    red.backgroundColor = [UIColor redColor];
    [bgView addSubview:red];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        bgView.bounds = CGRectMake(50, 10, Screen_Width, Screen_Height);
    });


}


@end

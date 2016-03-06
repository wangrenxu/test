//
//  ViewController.m
//  网易新闻01
//
//  Created by wang on 16/1/6.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "ViewController.h"
#import "WRXViewController.h"
#define lableW 100
#define lableH 36
#define WRXscale 0.6

@interface ViewController () <UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *titleScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupChildVc];
    [self setupTitle];
    [self scrollViewDidEndScrollingAnimation:self.contentScrollView];
    self.contentScrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * 7, 0);
    self.contentScrollView.pagingEnabled = YES;
   
}
/**
 *添加子控制器
 */
- (void)setupChildVc{
    
    WRXViewController *vc0 = [[WRXViewController alloc] init];
    vc0.title = @"国际";
    [self addChildViewController:vc0];
    WRXViewController *vc1 = [[WRXViewController alloc] init];
    vc1.title = @"政治";
    [self addChildViewController:vc1];
    WRXViewController *vc2 = [[WRXViewController alloc] init];
    vc2.title = @"娱乐";
    [self addChildViewController:vc2];
    WRXViewController *vc3 = [[WRXViewController alloc] init];
    vc3.title = @"军事";
    [self addChildViewController:vc3];
    WRXViewController *vc4 = [[WRXViewController alloc] init];
    vc4.title = @"民生";
    [self addChildViewController:vc4];
    WRXViewController *vc5 = [[WRXViewController alloc] init];
    vc5.title = @"体育";
    [self addChildViewController:vc5];
    WRXViewController *vc6 = [[WRXViewController alloc] init];
    vc6.title = @"农业";
    [self addChildViewController:vc6];
}

/**
 *初始化标题
 */
- (void)setupTitle{
    CGFloat lableY = 0;
    for (int i = 0; i < 7; i++) {
        UILabel *lable = [[UILabel alloc] init];
        CGFloat lableX = i * lableW;
        lable.frame = CGRectMake(lableX, lableY, lableW, lableH);
        lable.text = self.childViewControllers[i].title;
        lable.textAlignment = NSTextAlignmentCenter;
        lable.font = [UIFont systemFontOfSize:13];
        lable.userInteractionEnabled = YES;
        [lable addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lableClick:)]];
        [self.titleScrollView addSubview:lable];
    }
    
    self.titleScrollView.contentSize = CGSizeMake(lableW * 7, 0);
   
}

/**
 *监听lable点击
 */
- (void)lableClick:(UIGestureRecognizer *)tapGestureRecognizer{
    
    
    NSInteger index = [tapGestureRecognizer.view.superview.subviews indexOfObject:tapGestureRecognizer.view];
    
    //设置内容的偏移量
    CGPoint contentOffset = self.contentScrollView.contentOffset;
    contentOffset.x = [UIScreen mainScreen].bounds.size.width * index;
    [self.contentScrollView setContentOffset:contentOffset animated:YES];
    
    
    
    
    //设置标题的偏移量
    CGPoint titleOffset = self.titleScrollView.contentOffset;
    titleOffset.x = self.titleScrollView.subviews[index].center.x - [UIScreen mainScreen].bounds.size.width * 0.5 ;
    if (titleOffset.x <= 0 ) {
        titleOffset.x = 0;
    } else if (titleOffset.x >= 7 * lableW - [UIScreen mainScreen].bounds.size.width){
        titleOffset.x = 7 * lableW - [UIScreen mainScreen].bounds.size.width;
    }
    [self.titleScrollView setContentOffset:titleOffset animated:YES];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    //设置标题的偏移量
    NSInteger index = scrollView.contentOffset.x/scrollView.bounds.size.width;
    CGPoint titleOffset = self.titleScrollView.contentOffset;
    titleOffset.x = self.titleScrollView.subviews[index].center.x - [UIScreen mainScreen].bounds.size.width * 0.5 ;
    if (titleOffset.x <= 0 ) {
        titleOffset.x = 0;
    } else if (titleOffset.x >= 7 * lableW - [UIScreen mainScreen].bounds.size.width){
        titleOffset.x = 7 * lableW - [UIScreen mainScreen].bounds.size.width;
    }

    [self.titleScrollView setContentOffset:titleOffset animated:YES];

}


- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{

    //动画结束再添加控制器的View
    NSInteger index = scrollView.contentOffset.x/scrollView.bounds.size.width;

    if (!self.childViewControllers[index].view.superview) {
        UIView *view = self.childViewControllers[index].view;
        view.frame = CGRectMake(index * self.contentScrollView.bounds.size.width, 0, self.contentScrollView.bounds.size.width, [UIScreen mainScreen].bounds.size.height - 100);
        view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0];
        [self.contentScrollView addSubview:view];
        
    }


}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    //文字渐变大小和颜色渐变
    CGFloat scale = scrollView.contentOffset.x/scrollView.bounds.size.width;
    NSInteger leftIndex = scrollView.contentOffset.x/scrollView.bounds.size.width;
    NSInteger rightIndex = leftIndex + 1;
    CGFloat leftScale = scale - leftIndex;
    CGFloat rightScale = 1 - leftScale;
    UILabel *leftLable = self.titleScrollView.subviews[leftIndex];
    if (rightIndex == 7) return;
    UILabel *rightLable = self.titleScrollView.subviews[rightIndex];
    leftLable.transform = CGAffineTransformMakeScale(1 + rightScale * WRXscale, 1 + rightScale * WRXscale);
    rightLable.transform = CGAffineTransformMakeScale(1 + leftScale * WRXscale, 1 + leftScale * WRXscale);
    for (UILabel *lable in self.titleScrollView.subviews) {
        if (lable == leftLable) {
            leftLable.transform = CGAffineTransformMakeScale(1 + rightScale * WRXscale, 1 + rightScale * WRXscale);
            leftLable.textColor = [UIColor colorWithRed:rightScale green:0.0 blue:0.0 alpha:1.0];
        } else if (lable == rightLable){
            rightLable.transform = CGAffineTransformMakeScale(1 + leftScale * WRXscale, 1 + leftScale * WRXscale);
            rightLable.textColor = [UIColor colorWithRed:leftScale green:0.0 blue:0.0 alpha:1.0];
        } else {
            lable.transform = CGAffineTransformMakeScale(1, 1);
            lable.textColor = [UIColor blackColor];
        }
    }
    
    
    
}
@end

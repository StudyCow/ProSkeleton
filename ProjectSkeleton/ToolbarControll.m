
#import "ToolbarControll.h"
#import "YYlable.h"
#import "MainViewController.h"
#import "MoreControll.h"
#import "BorrowControll.h"
#import "TransferControll.h"
#import "MyInvestControll.h"
@interface ToolbarControll ()

@end

@implementation ToolbarControll

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //添加子控件
    [self addChildView];
    //添加子控制器
    [self addChildControll];
    //添加底部标题
    [self setDownTitles];
    //添加默认控制器
    UIViewController * controll=[self.childViewControllers firstObject];
    controll.view.frame=contentsScrollView.bounds;
    [contentsScrollView addSubview:controll.view];
    CGFloat contentsContentW = self.childViewControllers.count * mainWidth;
    contentsScrollView.contentSize = CGSizeMake(contentsContentW, 0);
    
    YYlable * lable=titlesScrollView.subviews[0];
    lable.textColor=YYColor(253, 203, 35);
}
#pragma mark 子控制器
- (void) addChildControll
{
    MyInvestControll * invesControll=[[MyInvestControll alloc] init];
    invesControll.title=@"我要投资";
    [self addChildViewController:invesControll];
    
    BorrowControll * borrowControll=[[BorrowControll alloc] init];
    borrowControll.title=@"我要借贷";
    [self addChildViewController:borrowControll];
    
    TransferControll * transferControll=[[TransferControll alloc] init];
    transferControll.title=@"债权转让";
    [self addChildViewController:transferControll];
    
    MainViewController * mainControll=[[MainViewController alloc] init];
    mainControll.title=@"我的账户";
    [self addChildViewController:mainControll];
    
    MoreControll * moreControll=[[MoreControll alloc] init];
    moreControll.title=@"更多";
    [self addChildViewController:moreControll];
}
#pragma mark 添加子控件
- (void) addChildView
{
    //顶部
    contentsScrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0,0, mainWidth,mainHeight-50)];
    contentsScrollView.backgroundColor=YYColor(221, 221, 221);
    contentsScrollView.scrollEnabled = YES;
    contentsScrollView.delegate = self;
    contentsScrollView.bounces = YES;
    contentsScrollView.pagingEnabled = YES;
    contentsScrollView.showsHorizontalScrollIndicator = NO;
    contentsScrollView.showsVerticalScrollIndicator=NO;
    [self.view addSubview:contentsScrollView];
    //底部
    CGFloat num=contentsScrollView.y+contentsScrollView.height;
    NSLog(@"contentsScrollView.y===%f",num);
    titlesScrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0,num, mainWidth, mainHeight-contentsScrollView.height)];
    titlesScrollView.backgroundColor=YYColor(255, 255, 255);
    titlesScrollView.delegate=self;
    titlesScrollView.scrollEnabled = YES;
    titlesScrollView.delegate = self;
    titlesScrollView.bounces = YES;
    titlesScrollView.pagingEnabled = YES;
    titlesScrollView.showsHorizontalScrollIndicator = NO;
    titlesScrollView.showsVerticalScrollIndicator=NO;
    [self.view addSubview:titlesScrollView];

}
#pragma mark - <UIScrollViewDelegate>
/**
 *  在scrollView动画结束时调用(添加子控制器的view到self.contentsScrollView)
 *  self.contentsScrollView == scrollView
 *  用户手动触发的动画结束，不会调用这个方法
 */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    // 获得当前需要显示的子控制器的索引
    NSUInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
    
    // 滚动标题栏（self.titlesScrollView）
    YYlable *label = titlesScrollView.subviews[index];
    CGFloat titlesW = titlesScrollView.frame.size.width;
    CGFloat offsetX = 0;
    // 最大的偏移量
    CGFloat maxOffsetX = titlesScrollView.contentSize.width - titlesW;
    if (offsetX < 0) {
        offsetX = 0;
    } else if (offsetX > maxOffsetX) {
        offsetX = maxOffsetX;
    }
    label.textColor=YYColor(253, 203, 35);
    //改变其它lable的颜色
    [titlesScrollView.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
     {
         if (idx != index)
         {
             YYlable *otherLabel = titlesScrollView.subviews[idx];
             [otherLabel setTextColor:[UIColor blackColor]];
         }
     }];
    UIViewController *vc = self.childViewControllers[index];
    // 如果子控制器的view已经在上面，就直接返回
    if (vc.view.superview) return;
    
    // 添加
    CGFloat vcW = scrollView.frame.size.width;
    CGFloat vcH = scrollView.frame.size.height;
    CGFloat vcX = index * vcW;
    CGFloat vcY = 0;
    
    vc.view.frame = CGRectMake(vcX, vcY, vcW, vcH);
    
    [scrollView addSubview:vc.view];
}

/**
 *  当scrollView停止滚动时调用这个方法（用户手动触发的动画停止，会调用这个方法）
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

#pragma mark .添加顶部的所有标题
- (void) setDownTitles
{
    NSUInteger count=self.childViewControllers.count;
    CGFloat labW=mainWidth/5;
    CGFloat labH=titlesScrollView.height;
    CGFloat labY=0;
    for (NSUInteger i=0; i<count; i++)
    {
        YYlable * lable=[[YYlable alloc] init];
        lable.tag=i;
        [titlesScrollView addSubview:lable];
        CGFloat labX=i*labW;
        lable.frame=CGRectMake(labX,labY,labW,labH);
        lable.text=[self.childViewControllers[i] title];
        
        // 监听点击
        [lable addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick:)]];
    }
}
/**
 *  监听label的点击
 */
- (void)labelClick:(UITapGestureRecognizer *)recognizer
{
    // 获得被点击的label
    YYlable *label = (YYlable *)recognizer.view;
    
    // 计算x方向上的偏移量
    CGFloat offsetX = label.tag * contentsScrollView.frame.size.width;
    
    // 设置偏移量
    CGPoint offset = CGPointMake(offsetX,contentsScrollView.contentOffset.y);
    [contentsScrollView setContentOffset:offset animated:YES];
    
    NSLog(@"lable.tag==%i",(int)label.tag);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

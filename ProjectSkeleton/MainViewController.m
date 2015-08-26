

#import "MainViewController.h"
#import "YYlable.h"
@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];

    
    //创建一个导航栏
    navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 20, mainWidth, 50)];
//    [navBar setBackgroundColor:[UIColor redColor]];
    navBar.tintColor=[UIColor redColor];
    
    //创建一个导航栏集合
    UINavigationItem *navItem = [[UINavigationItem alloc] initWithTitle:nil];
    
    //设置导航栏的内容
    [navItem setTitle:@"我的账户"];
//    //把导航栏集合添加到导航栏中，设置动画关闭
    [navBar pushNavigationItem:navItem animated:NO];
    
    //将标题栏中的内容全部添加到主视图当中
    [self.view addSubview:navBar];
    

    //创建scroll
    [self createScroll];
    // 0.添加子控制器
    [self setupChildVces];
    
    // 1.添加顶部的所有标题
    [self setupTitles];
    
    // 2.添加默认控制器
    UIViewController *firstVc = [self.childViewControllers firstObject];
    firstVc.view.frame = contentsScrollView.bounds;
    [contentsScrollView addSubview:firstVc.view];
    // 3.设置内容size
    CGFloat contentsContentW = self.childViewControllers.count * mainWidth;
    contentsScrollView.contentSize = CGSizeMake(contentsContentW, 0);
    
    YYlable * lable=titlesScrollView.subviews[0];
    lable.textColor=YYColor(253, 203, 35);
}
#pragma mark 导航栏事件的处理
-(void)showDialog:(NSString *)str
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"这是一个对话框" message:str delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    UIView *vv=[[UIView alloc] initWithFrame:CGRectMake(0,0, 20, 30)];
    vv.backgroundColor=[UIColor redColor];
    [alert addSubview:vv];
    [alert show];
}
-(void) clickLeftButton
{
    [self showDialog:@"点击了导航栏左边按钮"];
}

-(void) clickRightButton
{
    [self showDialog:@"点击了导航栏右边按钮"];
}

#pragma mark 创建scroll
- (void) createScroll
{
    //顶部
    titlesScrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0,70, mainWidth, 50)];
    titlesScrollView.backgroundColor=YYColor(255,255,255);
    titlesScrollView.contentSize = CGSizeMake(mainWidth, 0);
    titlesScrollView.scrollEnabled = YES;
    titlesScrollView.delegate = self;
    titlesScrollView.bounces = YES;
    titlesScrollView.pagingEnabled = YES;
    titlesScrollView.showsHorizontalScrollIndicator = NO;
    titlesScrollView.showsVerticalScrollIndicator=NO;
    [self.view addSubview:titlesScrollView];
    //底部
    CGFloat num=titlesScrollView.y+titlesScrollView.height;
    NSLog(@"contentsScrollView.y===%f",num);
    contentsScrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0,num, mainWidth, mainHeight-contentsScrollView.y)];
    contentsScrollView.backgroundColor=[UIColor whiteColor];
    contentsScrollView.delegate=self;
    contentsScrollView.scrollEnabled = YES;
    contentsScrollView.delegate = self;
    contentsScrollView.bounces = YES;
    contentsScrollView.pagingEnabled = YES;
    contentsScrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:contentsScrollView];

}
#pragma mark 添加子控制器
- (void)setupChildVces
{
    MyCountViewControll * mycountView=[[MyCountViewControll alloc] init];
    mycountView.title=@"我的账户";
    [self addChildViewController:mycountView];
    BorrowManagementViewControll * borrowView=[[BorrowManagementViewControll alloc] init];
    borrowView.title=@"借款管理";
    [self addChildViewController:borrowView];
    InvestmentManagementViewControll * invesView=[[InvestmentManagementViewControll alloc] init];
    invesView.title=@"投资管理";
    [self addChildViewController:invesView];
    DebtManagementViewControll * debtManageView=[[DebtManagementViewControll alloc] init];
    debtManageView.title=@"债权管理";
    [self addChildViewController:debtManageView];
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
- (void) setupTitles
{
    NSUInteger count=self.childViewControllers.count;
    CGFloat labW=mainWidth/4;
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

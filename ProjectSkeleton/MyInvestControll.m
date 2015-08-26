

#import "MyInvestControll.h"
#import "TheCalculatorControll.h"
@interface MyInvestControll ()

@end

@implementation MyInvestControll

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建一个导航栏
    UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 20, mainWidth, 50)];
    //创建一个导航栏集合
    UINavigationItem *navItem = [[UINavigationItem alloc] initWithTitle:nil];
    //在这个集合Item中添加标题，按钮
    //style:设置按钮的风格，一共有三种选择
    //action：@selector:设置按钮的点击事件
    //创建一个左边按钮
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"计算器" style:UIBarButtonItemStylePlain target:self action:@selector(blackClick)];
    
    //创建一个右边按钮
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"🔍" style:UIBarButtonItemStyleDone target:self action:nil];
    
    //设置导航栏的内容
    [navItem setTitle:@"我要投资"];
    
    
    //设置NavigationBar背景颜色
    //[[UINavigationBar appearance] setBarTintColor:[UIColor redColor]];Color.rgb(250, 102, 3)
    [UINavigationBar appearance].barTintColor=YYColor(250, 102, 3);
    //@{}代表Dictionary
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];

    
    
    //把导航栏集合添加到导航栏中，设置动画关闭
    [navBar pushNavigationItem:navItem animated:NO];
    
    //把左右两个按钮添加到导航栏集合中去
    [navItem setLeftBarButtonItem:leftButton];
    [navItem setRightBarButtonItem:rightButton];
    
    //将标题栏中的内容全部添加到主视图当中
    [self.view addSubview:navBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark 跳转控制器
-(void) blackClick
{
    NSLog(@"调用计算器。");
    TheCalculatorControll * theCalculator=[[TheCalculatorControll alloc] init];
    [self presentViewController:theCalculator animated:YES completion:nil];
}

@end

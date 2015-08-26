

#import "TheCalculatorControll.h"
#import "YYlable.h"
#import "MyInvestControll.h"
#import "ResultControll.h"
@interface TheCalculatorControll ()

@end

@implementation TheCalculatorControll

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    //创建一个导航栏
    UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 20, mainWidth, 50)];
    //创建一个导航栏集合
    UINavigationItem *navItem = [[UINavigationItem alloc] initWithTitle:nil];
    //在这个集合Item中添加标题，按钮
    //style:设置按钮的风格，一共有三种选择
    //action：@selector:设置按钮的点击事件
    //创建一个左边按钮
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(blackClick)];
    //设置导航栏的内容
    [navItem setTitle:@"计算器"];
    
    //把导航栏集合添加到导航栏中，设置动画关闭
    [navBar pushNavigationItem:navItem animated:NO];
    
    //把左右两个按钮添加到导航栏集合中去
    [navItem setLeftBarButtonItem:leftButton];
    
    //将标题栏中的内容全部添加到主视图当中
    [self.view addSubview:navBar];
    
    self.arrayOne=@[@"借款金额：",@"年利率：",@"借款期限："];
    self.arrayTwo=@[@"请输入",@"0.001%~20%",@"请输入"];
    [self addLable];
}

#pragma mark 添加标题
- (void) addLable
{
    JYLog(@"添加顶部标题。");
    NSUInteger count=self.arrayOne.count;
    CGFloat labW=mainWidth/3;
    CGFloat labH=45;
    CGFloat labX=20;
    for (NSUInteger i=0; i<count; i++)
    {
        YYlable * lable=[[YYlable alloc] init];
        lable.tag=i;
        [self.view addSubview:lable];
        CGFloat labY=i*(20+labH)+100;
        lable.frame=CGRectMake(labX,labY,labW,labH);
        lable.text=[self.arrayOne objectAtIndex:i];
    }
    //根据tag取出相应的lable
    YYlable *lab=(YYlable *)[self.view viewWithTag:1];
    CGFloat textX=lab.x+lab.width;
    CGFloat textW=150;
    CGFloat textH=45;
    
    textview1=[[UITextField alloc] init];
    textview1.frame=CGRectMake(textX+20, lab.y-lab.height-20, textW, textH);
    textview1.backgroundColor=[UIColor grayColor];
    textview1.text=[self.arrayTwo objectAtIndex:0];
    textview1.textAlignment=NSTextAlignmentLeft;
    textview1.delegate=self;
    [self.view addSubview:textview1];
    
    textview2=[[UITextField alloc] init];
    textview2.frame=CGRectMake(textX+20, lab.y, textW, textH);
    textview2.backgroundColor=[UIColor grayColor];
    textview2.text=[self.arrayTwo objectAtIndex:1];
    textview2.delegate=self;
    [self.view addSubview:textview2];
    
    textview3=[[UITextField alloc] init];
    textview3.frame=CGRectMake(textX+20, lab.y+lab.height+20, textW, textH);
    textview3.backgroundColor=[UIColor grayColor];
    textview3.text=[self.arrayTwo objectAtIndex:2];
    textview3.delegate=self;
    [self.view addSubview:textview3];
    
    //还款方式
    YYlable * reimLab=[[YYlable alloc] init];
    reimLab.x=lab.x;
    reimLab.y=textview3.y+textview3.height+25;
    reimLab.width=lab.width;
    reimLab.height=lab.height;
    reimLab.text=@"还款方式：";
    [self.view addSubview:reimLab];
    
    QRadioButton *_radio1 = [[QRadioButton alloc] initWithDelegate:self groupId:@"groupId1"];
    _radio1.frame = CGRectMake(textview1.x, textview3.y+textview3.height+20, 150, 20);
    [_radio1 setTitle:@"按月分期还款" forState:UIControlStateNormal];
    [_radio1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_radio1.titleLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
    [self.view addSubview:_radio1];
    [_radio1 setChecked:YES];
    
    QRadioButton *_radio2 = [[QRadioButton alloc] initWithDelegate:self groupId:@"groupId1"];
    _radio2.frame = CGRectMake(_radio1.x, _radio1.y+_radio1.height+5, 150, 20);
    [_radio2 setTitle:@"按月付息，到期还本" forState:UIControlStateNormal];
    [_radio2 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_radio2.titleLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
    [self.view addSubview:_radio2];
    
    //开始计算
    YYlable * startNum=[[YYlable alloc] init];
    startNum.text=@"开始计算";
    startNum.textAlignment=NSTextAlignmentCenter;
    startNum.font=[UIFont systemFontOfSize:15];
    startNum.frame=CGRectMake(5, _radio2.y+_radio2.height+20, mainWidth-10, 60);
    [self.view addSubview:startNum];
    //UILable添加边框
    startNum.layer.borderWidth = 2;
    startNum.layer.borderColor = [[UIColor grayColor] CGColor];
    // 监听点击
    [startNum addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick:)]];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

/**
 *  监听label的点击
 */
- (void)labelClick:(UITapGestureRecognizer *)recognizer
{
    NSLog(@"开始计算。");
    ResultControll * theCalculator=[[ResultControll alloc] init];
    [self presentViewController:theCalculator animated:YES completion:nil];
}
- (void)didSelectedRadioButton:(QRadioButton *)radio groupId:(NSString *)groupId {
    NSLog(@"did selected radio:%@ groupId:%@", radio.titleLabel.text, groupId);
}

- (void) textViewDidBeginEditing:(UITextView *)textView
{
    NSLog(@"清空输入框初始化数据。");
    textView.text=@"";
}
#pragma mark 跳转控制器
-(void) blackClick
{
    NSLog(@"返回。");
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end

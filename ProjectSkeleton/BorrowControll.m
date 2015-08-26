
#import "BorrowControll.h"
#import "YYlable.h"
#import "MJExtension/MJExtension.h"
#import "SDWebImage/SDWebImageManager.h"
@interface BorrowControll ()

@end

@implementation BorrowControll


- (YYTCity *) locate
{
    if (self.cityLocation==nil)
    {
        self.cityLocation=[[YYTCity alloc] init];
    }
    return self.cityLocation;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建一个导航栏
    UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 20, mainWidth, 50)];
    //创建一个导航栏集合
    UINavigationItem *navItem = [[UINavigationItem alloc] initWithTitle:nil];
    //在这个集合Item中添加标题，按钮
    //style:设置按钮的风格，一共有三种选择
    //action：@selector:设置按钮的点击事件
    
    //设置导航栏的内容
    [navItem setTitle:@"我要借款"];
    
    //把导航栏集合添加到导航栏中，设置动画关闭
    [navBar pushNavigationItem:navItem animated:NO];
    
    //将标题栏中的内容全部添加到主视图当中
    [self.view addSubview:navBar];
    
    //初始化数据
    [self LoadArray];
    
    //添加子控件
    [self addChildView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];

}
- (void) keyboardWasShown:(NSNotification *) notif
{
    pickView.hidden=YES;
    speciesView.hidden=YES;
    measureView.hidden=YES;
    timeView.hidden=YES;
    labDown.hidden=YES;
}

#pragma mark 初始化数据
- (void) LoadArray
{
    self.titArray=@[@"申请人:",@"地址:",@"手机号:",@"借款金额:",@"借款期限:",@"贷款种类:",@"担保措施"];
    self.cityLocation=[[YYTCity alloc] init];
    //加载数据
    self.array = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"city.plist" ofType:nil]];
    self.cityArray=[[self.array objectAtIndex:0] objectForKey:@"cities"];
    self.cityLocation.state = [[self.array objectAtIndex:0] objectForKey:@"state"];
    self.cityLocation.city = [self.cityArray objectAtIndex:0];
    
    self.timeArray=@[@"1个月",@"2个月",@"3个月",@"4个月",@"5个月",@"6个月",@"7个月",@"8个月",@"9个月",@"10个月",@"11个月",@"12个月以上",];
    self.specArray=@[@"小微企业信贷",@"个人车贷",@"个人房贷"];
    self.measuArray=@[@"配偶",@"股东",@"关联企业",@"车辆",@"房产",@"设备",@"保险单",@"股权",@"有价证劵",@"其它"];
    
}
#pragma mark 添加背景图片 整个界面的UI布局
- (void) addChildView
{
    //添加背景图片
//    UIImageView * imgView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 70, mainWidth, mainHeight-70)];
    UIImageView * imgView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 70, mainWidth, 60)];
    [self.view addSubview:imgView];
    imgView.userInteractionEnabled=YES;
    imgView.image=[UIImage imageNamed:@"Borrow.png"];
    self.view.backgroundColor=YYColor(245, 201, 181);

    
    //以下是正确代码
    //添加标题
    NSUInteger count=self.titArray.count;
    CGFloat labW=mainWidth/4;
    CGFloat labH=25;
    CGFloat labX=20;
    for (NSUInteger i=0; i<count; i++)
    {
        YYlable * lable=[[YYlable alloc] init];
        lable.tag=i;
        [self.view addSubview:lable];
        CGFloat labY=i*(20+labH)+imgView.y+imgView.height+20;
        lable.frame=CGRectMake(labX,labY,labW,labH);
        lable.text=[self.titArray objectAtIndex:i];
        lable.textAlignment=NSTextAlignmentRight;
    }
    
    //根据tag取出相应的lable
    YYlable *lab=(YYlable *)[self.view viewWithTag:1];
    CGFloat textX=lab.x+lab.width;
    CGFloat textW=150;
    CGFloat textH=lab.height;
    
    applicantText=[[UITextField alloc] init];
    applicantText.delegate=self;
    applicantText.frame=CGRectMake(textX+20, lab.y-lab.height-20, textW, textH);
    applicantText.text=@"";
    applicantText.textAlignment=NSTextAlignmentLeft;
    applicantText.backgroundColor=[UIColor whiteColor];
    applicantText.delegate=self;
    [self.view addSubview:applicantText];
    
    addressText=[[UILabel alloc] initWithFrame:CGRectMake(applicantText.x, applicantText.y+applicantText.height+20, applicantText.width, applicantText.height)];
    addressText.text=@"北京市 V 朝阳区 V";
    addressText.tag=111;
    addressText.backgroundColor=[UIColor whiteColor];
    addressText.userInteractionEnabled=YES;
    // 监听点击
    [addressText addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick:)]];
    [self.view addSubview:addressText];
    
    phoneNum=[[UITextField alloc] initWithFrame:CGRectMake(addressText.x, addressText.y+addressText.height+20, addressText.width, addressText.height)];
    phoneNum.backgroundColor=[UIColor whiteColor];
    phoneNum.text=@"";
    phoneNum.delegate=self;
    [self.view addSubview:phoneNum];
    
    moneyNum=[[UITextField alloc] initWithFrame:CGRectMake(phoneNum.x, phoneNum.y+phoneNum.height+20, phoneNum.width, phoneNum.height)];
    moneyNum.text=@"";
    moneyNum.backgroundColor=[UIColor whiteColor];
    moneyNum.delegate=self;
    [self.view addSubview:moneyNum];
    
    timeText=[[UILabel alloc] initWithFrame:CGRectMake(moneyNum.x, moneyNum.y+moneyNum.height+20, moneyNum.width, moneyNum.height)];
    timeText.text=@"1个月";
    timeText.tag=222;
    timeText.backgroundColor=[UIColor whiteColor];
    timeText.userInteractionEnabled=YES;
    // 监听点击
    [timeText addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick:)]];
    
    [self.view addSubview:timeText];
    
    
    speciesText=[[UILabel alloc] initWithFrame:CGRectMake(timeText.x, timeText.y+timeText.height+20, timeText.width, timeText.height)];
    speciesText.text=@"小微企业信贷";
    speciesText.backgroundColor=[UIColor whiteColor];
    speciesText.tag=333;
    speciesText.userInteractionEnabled=YES;
    // 监听点击
    [speciesText addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick:)]];
    
    [self.view addSubview:speciesText];
    
    
    measureText=[[UILabel alloc] initWithFrame:CGRectMake(speciesText.x, speciesText.y+speciesText.height+20, speciesText.width, speciesText.height)];
    measureText.text=@"配偶";
    measureText.tag=444;
    measureText.backgroundColor=[UIColor whiteColor];
    measureText.userInteractionEnabled=YES;
    // 监听点击
    [measureText addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick:)]];
    
    [self.view addSubview:measureText];
    
//    UIButton * btn=[[UIButton alloc] initWithFrame:CGRectMake(mainWidth/2-50,measureText.y+measureText.height+20,100,35)];
//    btn.backgroundColor=YYColor(250, 102, 3);
//    [btn setTitle:@"提交申请" forState:UIControlStateNormal];
//    btn.hidden=NO;
//    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn];
    
    
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(mainWidth/2-50,measureText.y+measureText.height+20,100,35);
    [btn.layer setMasksToBounds:YES];
    [btn.layer setCornerRadius:10.0]; //设置矩形四个圆角半径
    [btn.layer setBorderWidth:1.0]; //边框宽度
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 1, 0, 0, 1 });
    [btn.layer setBorderColor:colorref];//边框颜色
    [self.view addSubview:btn];
    [btn setTitle:@"提交申请" forState:UIControlStateNormal];
        btn.hidden=NO;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor=YYColor(250, 102, 3);
    
    
    viewDown=[[UIView alloc] initWithFrame:CGRectMake(5,mainHeight/2-20, mainWidth-10, 40)];
    viewDown.backgroundColor=YYColor(89, 89, 89);
    viewDown.hidden=YES;
    [self.view addSubview:viewDown];
    
    UIButton * btnExit=[[UIButton alloc] initWithFrame:CGRectMake(mainWidth-55,0,45, 40)];
    [btnExit setTitle:@"退出" forState:UIControlStateNormal];
    [btnExit addTarget:self action:@selector(clickDown:) forControlEvents:UIControlEventTouchUpInside];
    [viewDown addSubview:btnExit];
    
    UIButton * btnOk=[[UIButton alloc] initWithFrame:CGRectMake(5,0,45, 40)];
    [btnOk setTitle:@"确定" forState:UIControlStateNormal];
    [btnOk addTarget:self action:@selector(clickDown:) forControlEvents:UIControlEventTouchUpInside];
    [viewDown addSubview:btnOk];
    
    pickView =[[UIPickerView alloc] initWithFrame:CGRectMake(5,viewDown.y+viewDown.height, mainWidth-10, 25)];
    pickView.backgroundColor=YYColor(235, 235, 235);
    pickView.userInteractionEnabled=YES;
    pickView.delegate=self;
    pickView.dataSource=self;
    pickView.hidden=YES;
    [self.view addSubview:pickView];
    
    timeView =[[UIPickerView alloc] initWithFrame:CGRectMake(5,viewDown.y+viewDown.height, mainWidth-10, 25)];
    timeView.backgroundColor=YYColor(235, 235, 235);
    timeView.userInteractionEnabled=YES;
    timeView.delegate=self;
    timeView.dataSource=self;
    timeView.hidden=YES;
    [self.view addSubview:timeView];
    
    speciesView =[[UIPickerView alloc] initWithFrame:CGRectMake(5,viewDown.y+viewDown.height, mainWidth-10, 25)];
    speciesView.backgroundColor=YYColor(235, 235, 235);
    speciesView.userInteractionEnabled=YES;
    speciesView.delegate=self;
    speciesView.dataSource=self;
    speciesView.hidden=YES;
    [self.view addSubview:speciesView];
    
    measureView =[[UIPickerView alloc] initWithFrame:CGRectMake(5,viewDown.y+viewDown.height, mainWidth-10, 25)];
    measureView.backgroundColor=YYColor(235, 235, 235);
    measureView.userInteractionEnabled=YES;
    measureView.delegate=self;
    measureView.dataSource=self;
    measureView.hidden=YES;
    [self.view addSubview:measureView];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (void)timerFireMethod:(NSTimer*)theTimer//弹出框
{
    UIAlertView *promptAlert = (UIAlertView*)[theTimer userInfo];
    [promptAlert dismissWithClickedButtonIndex:0 animated:NO];
    promptAlert =NULL;
}
- (void)showAlert:(NSString *) _message{//时间
    UIAlertView *promptAlert = [[UIAlertView alloc] initWithTitle:@"" message:_message delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    promptAlert.backgroundColor=[UIColor redColor];
    promptAlert.frame=CGRectMake(50,100, 50, 30);
    [NSTimer scheduledTimerWithTimeInterval:3.0f
                                     target:self
                                   selector:@selector(timerFireMethod:)
                                   userInfo:promptAlert
                                    repeats:YES];
    [promptAlert show];
}
- (void) btnClick:(id)sender
{
    
    if ([applicantText.text isEqualToString:@""])
    {
        [PromptBox showMessage:@"申请人不能为空！！"];

    }
    else if([phoneNum.text isEqualToString:@""])
    {
    [PromptBox showMessage:@"手机号码不能为空！！"];
    }
    else if([moneyNum.text isEqualToString:@""])
    {
        [PromptBox showMessage:@"借款金额不能为空！！"];
    }
    else
    {
       
    NSArray * arr=@[applicantText.text,addressText.text,phoneNum.text,moneyNum.text,timeText.text,speciesText.text,measureText.text];
    for (int i=0; i<[arr count];i++)
    {
        NSLog(@"%@",[arr objectAtIndex:i]);
    }
            NSLog(@"提交审核。");
    }
}
#pragma mark pickview隐藏
- (void) NOHidden
{
    pickView.hidden=YES;
    viewDown.hidden=YES;
    timeView.hidden=YES;
    speciesView.hidden=YES;
    measureView.hidden=YES;
}
- (void) clickDown:(id)sender
{
    [self NOHidden];
    NSLog(@"pickview的隐藏。");
}
/**
 *  监听label的点击
 */
- (void)labelClick:(UITapGestureRecognizer *)recognizer
{
    // 获得被点击的label
    YYlable *label = (YYlable *)recognizer.view;
    if (label.tag==111)
    {
        pickView.hidden=NO;
        viewDown.hidden=NO;
        timeView.hidden=YES;
        speciesView.hidden=YES;
        measureView.hidden=YES;
        NSLog(@"选择地址。");
    }
    else if (label.tag==222)
    {
        pickView.hidden=YES;
        speciesView.hidden=YES;
        measureView.hidden=YES;
        timeView.hidden=NO;
        viewDown.hidden=NO;
        NSLog(@"借款期限.");
    }
    else if (label.tag==333)
    {
        pickView.hidden=YES;
        speciesView.hidden=NO;
        measureView.hidden=YES;
        timeView.hidden=YES;
        viewDown.hidden=NO;
        NSLog(@"贷款种类.");
    }
    else if (label.tag==444)
    {
        pickView.hidden=YES;
        speciesView.hidden=YES;
        measureView.hidden=NO;
        timeView.hidden=YES;
        viewDown.hidden=NO;
        NSLog(@"担保措施.");
    }
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (pickerView==pickView)
    {
        return 2;
    }
    else
    {
        return 1;
    }
    return 0;
}
-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pickerView==pickView)
    {
        switch (component)
        {
            case 0:
                return [self.array count];
                break;
            case 1:
                return [self.cityArray count];
                break;
            default:
                return 0;
                break;
        }
    }
    else if (pickerView==timeView)
    {
        return [self.timeArray count];
    }
    else if (pickerView==speciesView)
    {
        return [self.specArray count];
    }
    else if (pickerView==measureView)
    {
        return [self.measuArray count];
    }
    return 0;
}
-(NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (pickerView==pickView)
    {
        switch (component)
        {
            case 0:
                return [[self.array objectAtIndex:row] objectForKey:@"state"];
                break;
            case 1:
                return [self.cityArray objectAtIndex:row];
                break;
            default:
                return @"";
                break;
        }
    }
    else if (pickerView==timeView)
    {
        return [self.timeArray objectAtIndex:row];
    }
    else if (pickerView==speciesView)
    {
        return [self.specArray objectAtIndex:row];
    }
    else if (pickerView==measureView)
    {
        return [self.measuArray objectAtIndex:row];
    }
    return @"";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView==pickView)
    {
        switch (component)
        {
            case 0:
                self.cityArray = [[self.array objectAtIndex:row] objectForKey:@"cities"];
                [pickerView selectRow:0 inComponent:1 animated:YES];
                [pickerView reloadComponent:1];
                
                self.cityLocation.state = [[self.array objectAtIndex:row] objectForKey:@"state"];
                
                self.cityLocation.city = [self.cityArray objectAtIndex:0];
                addressText.text = [NSString stringWithFormat:@"%@%@%@%@", self.cityLocation.state,@" V ",self.cityLocation.city,@" V"];
                break;
            case 1:
                self.cityLocation.city = [self.cityArray objectAtIndex:row];
                addressText.text = [NSString stringWithFormat:@"%@%@%@%@",self.cityLocation.state,@" V ",self.cityLocation.city,@" V"];
                break;
            default:
                break;
        }
    }
    else if (pickerView==timeView)
    {
        timeText.text=[NSString stringWithFormat:@"%@",[self.timeArray objectAtIndex:row]];
    }
    else if (pickerView==speciesView)
    {
        speciesText.text=[NSString stringWithFormat:@"%@",[self.specArray objectAtIndex:row]];
    }
    else if (pickerView==measureView)
    {
        measureText.text=[NSString stringWithFormat:@"%@",[self.measuArray objectAtIndex:row]];
    }
}
//- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
//{
//    return NO;
//}
- (void) textViewDidBeginEditing:(UITextView *)textView
{
    NSLog(@"清空输入框初始化数据。");
    [self NOHidden];
    textView.text=@"";
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

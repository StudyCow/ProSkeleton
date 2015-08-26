

#import "ResultControll.h"
#import "YYlable.h"
#define cellH 45
@interface ResultControll ()

@end

@implementation ResultControll

- (void)viewDidLoad {
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
    [navItem setTitle:@"计算结果"];
    
    //把导航栏集合添加到导航栏中，设置动画关闭
    [navBar pushNavigationItem:navItem animated:NO];
    //把左右两个按钮添加到导航栏集合中去
    [navItem setLeftBarButtonItem:leftButton];
    //将标题栏中的内容全部添加到主视图当中
    [self.view addSubview:navBar];
    //初始化array
    self.array=@[@"10",@"100",@"1000",@"10000"];
    self.titleArray=@[@"序号",@"月还本息",@"月还本金",@"利息",@"余额",];
    
    //添加table
    [self createTable];
}
#pragma mark 跳转控制器
-(void) blackClick
{
    NSLog(@"返回。");
    [self dismissViewControllerAnimated:YES completion:nil];
}
//创建列表
- (void) createTable
{
    //添加标题
    UIView * view =[[UIView alloc] initWithFrame:CGRectMake(5, 70, mainWidth-10, 40)];
    [self.view addSubview:view];
    view.layer.borderWidth = 1;
    view.layer.borderColor = [[UIColor grayColor] CGColor];
    CGFloat lalY=0;
    NSLog(@"YY====:%f",lalY);
    CGFloat lalW=(view.width-30)/4;
    CGFloat lalH=view.height;
    YYlable * titNum=[[YYlable alloc] initWithFrame:CGRectMake(0, 0, 30,lalH)];
    titNum.text=@"序号";
    titNum.backgroundColor=YYColor(255, 246, 233);
    [view addSubview:titNum];
    for (NSUInteger i=1; i<=4; i++)
    {
        YYlable * lable=[[YYlable alloc] init];
        YYlable * lineLab=[[YYlable alloc] init];
        lable.tag=i;
        [view addSubview:lable];
        CGFloat labX=(i-1)*lalW+30;
        lineLab.frame=CGRectMake((i-1)*lalW+30, lalY, 1, lalH);
        lineLab.backgroundColor=[UIColor blackColor];
        [view addSubview:lineLab];
        lable.frame=CGRectMake(labX,lalY,lalW,lalH);
        lable.text=[self.titleArray objectAtIndex:i];
        lable.backgroundColor=YYColor(255, 246, 233);
    }
    
    
    self.tableView= [[UITableView alloc] initWithFrame:CGRectMake(view.x,view.y+view.height,view.width,cellH*self.array.count)];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.scrollEnabled = YES;
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView   setSeparatorColor:[UIColor blackColor]];  //设置分割线为蓝色
    [self.view addSubview:self.tableView];
    CGFloat contentsContentW = self.array.count * 200;
    self.tableView.contentSize = CGSizeMake(0,contentsContentW);
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tableView.layer.borderWidth = 1;
    self.tableView.layer.borderColor = [[UIColor grayColor] CGColor];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 12;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *listViewCellId = @"AlbumListViewCellId";
    UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:listViewCellId];
    if (cell==nil)
    {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.height=cellH;
    }
    //    cell.textLabel.text=[self.array objectAtIndex:indexPath.row];
    //UITableViewCellAccessoryDisclosureIndicator 出现右边的小尖头
    //    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    //    cell.textLabel.textColor=[UIColor redColor];
    
    //设置cell的颜色
    cell.selectionStyle=UITableViewCellSelectionStyleBlue;
    cell.alpha=0.5;
    
    
    
    UIView *view = [[UIView alloc] init];
    view.frame=cell.bounds;
    [cell.contentView addSubview:view];
    CGFloat lalY=0;
    NSLog(@"YY====:%f",lalY);
    CGFloat lalW=70;
    
    CGFloat lalH=view.height;
    YYlable * titNum=[[YYlable alloc] initWithFrame:CGRectMake(0, 0, 30,lalH)];
    titNum.text=[NSString stringWithFormat:@"%ld",(long)indexPath.row+1];
    
    titNum.backgroundColor=YYColor(255, 246, 233);
    [view addSubview:titNum];
    for (NSUInteger i=1; i<=4; i++)
    {
        YYlable * lable=[[YYlable alloc] init];
        
        YYlable * lineLab=[[YYlable alloc] init];
        lable.tag=i;
        [view addSubview:lable];
        CGFloat labX=(i-1)*lalW+30;
        lable.frame=CGRectMake(labX,lalY,lalW,lalH);
        
        lineLab.frame=CGRectMake(lable.x, lalY, 1, lalH);
        lineLab.backgroundColor=[UIColor yellowColor];
        [view addSubview:lineLab];
        
        lable.text=[self.titleArray objectAtIndex:i];
        lable.backgroundColor=YYColor(255, 246, 233);
    }
    return  cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end

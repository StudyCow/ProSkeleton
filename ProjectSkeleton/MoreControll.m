

#import "MoreControll.h"

@interface MoreControll ()

@end

@implementation MoreControll

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
    [navItem setTitle:@"更多"];
    
    //把导航栏集合添加到导航栏中，设置动画关闭
    [navBar pushNavigationItem:navItem animated:NO];
    //将标题栏中的内容全部添加到主视图当中
    [self.view addSubview:navBar];
    //初始化array
    self.array=@[@"登录/注册",@"信用说明",@"还款方式",@"帮助",@"关于",@"版本升级"];
    //添加table
    [self createTable];
}
//创建列表
- (void) createTable
{
    self.tableView= [[UITableView alloc] initWithFrame:CGRectMake(0,70,mainWidth,100*self.array.count)];
    self.tableView.backgroundColor = [UIColor redColor];
    self.tableView.scrollEnabled = YES;
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView   setSeparatorColor:[UIColor    blueColor]];  //设置分割线为蓝色
    [self.view addSubview:self.tableView];
    CGFloat contentsContentW = self.array.count * 200;
    self.tableView.contentSize = CGSizeMake(0,contentsContentW);
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *listViewCellId = @"AlbumListViewCellId";
    UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:listViewCellId];
    if (cell==nil)
    {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.height=100;
    }
    cell.textLabel.text=[self.array objectAtIndex:indexPath.row];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.textColor=[UIColor redColor];
//    UIView *viewCel = [[UIView alloc] initWithFrame:CGRectMake(5, 0, mainWidth, 90)];
//    //名字
//    viewCel.backgroundColor=[UIColor yellowColor];
//    [cell.contentView addSubview:viewCel];
    
    return  cell;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

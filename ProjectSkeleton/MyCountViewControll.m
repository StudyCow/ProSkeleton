

#import "MyCountViewControll.h"
#import "YYlable.h"
@interface MyCountViewControll ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic)UICollectionView *collectionView;
@end

@implementation MyCountViewControll
@synthesize collectionView,layout;
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=YYColor(221,221,221);
    //********
    self.navigationController.navigationBar.translucent=NO;
    layout=[[UICollectionViewFlowLayout alloc] init];
    layout.itemSize=CGSizeMake(50, 70);//cell的大小
    layout.scrollDirection=UICollectionViewScrollDirectionVertical;//滑动方式
    //self.scrollDirection=UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing=10.0f;//每行的间距
    layout.minimumInteritemSpacing=10;//每行cell内部的间距
    //Section Inset就是某个section中cell的边界范围。
    layout.sectionInset=UIEdgeInsetsMake(20, 10, 10, 10);//离上左下右的边界
    // self.headerReferenceSize=CGSizeMake(300, 230);//头部视图的大小  只有一个属性起作用
    collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) collectionViewLayout:layout];
    
    //加入代理
    collectionView.delegate=self;
    collectionView.dataSource=self;
    collectionView.backgroundColor=YYColor(221, 221, 221);;
    //注册cell
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"myCell"];
    //    [collectionView registerClass:Nil forCellWithReuseIdentifier:@"myCell"];
    [self.view addSubview:collectionView];

}
- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 25;
}

- (UICollectionViewCell *) collectionView:(UICollectionView *)collection cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellId=@"myCell";
    UICollectionViewCell *cell = [collection dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    cell.backgroundColor =YYColor(221, 221, 221);

    UIView * view=[[UIView alloc] init];
    view.frame=cell.bounds;
    [cell.viewForBaselineLayout addSubview:view];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, view.width, view.height-20)];
    //imageView.image=[UIImage imageNamed:@"0.png"];
    imageView.layer.masksToBounds=YES;
     //最重要的是这个地方要设成imgview高的一半
    imageView.layer.cornerRadius=imageView.height/2;
    imageView.backgroundColor = [UIColor redColor];
    [view addSubview:imageView];
    YYlable * lable=[[YYlable alloc] init];
    lable.frame=CGRectMake(0,imageView.y+imageView.height,view.width,20);
    lable.text=@"我的账户";
    lable.font=[UIFont systemFontOfSize:12];
    [view addSubview:lable];

    return cell;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

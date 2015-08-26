

#import <UIKit/UIKit.h>

@interface ResultControll : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,retain) NSArray * array;
@property (nonatomic,retain) NSArray * titleArray;
@end


#import <UIKit/UIKit.h>

@interface MoreControll : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,retain) NSArray * array;
@end

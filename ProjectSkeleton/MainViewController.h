

#import <UIKit/UIKit.h>
#import "MyCountViewControll.h"
#import "BorrowManagementViewControll.h"
#import "InvestmentManagementViewControll.h"
#import "DebtManagementViewControll.h"
@interface MainViewController : UIViewController<UIScrollViewDelegate>
{
    UIScrollView * titlesScrollView;
    UIScrollView * contentsScrollView;
    UINavigationBar *navBar;
}
@end


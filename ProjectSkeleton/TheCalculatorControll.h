
//计算器
#import <UIKit/UIKit.h>
#import "QRadioButton.h"
@interface TheCalculatorControll : UIViewController<UITextFieldDelegate,QRadioButtonDelegate>
{
    UITextField *textview1;
    UITextField *textview2;
    UITextField *textview3;
}
@property (nonatomic,retain) NSArray * arrayOne;
@property (nonatomic,retain) NSArray * arrayTwo;
@end

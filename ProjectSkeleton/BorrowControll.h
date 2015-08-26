

#import <UIKit/UIKit.h>
#import "YYTCity.h"
#import "YYlable.h"
typedef enum {
    HZAreaPickerWithStateAndCity,
    HZAreaPickerWithStateAndCityAndDistrict
} HZAreaPickerStyle;
@interface BorrowControll : UIViewController<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
{
    UITextField * applicantText;
    UILabel * addressText;
    UITextField * phoneNum;
    UITextField * moneyNum;
    UILabel * timeText;
    UILabel * speciesText;
    UILabel * measureText;
    UIButton *labDown;
     UIPickerView * pickView;
     UIPickerView * timeView;
     UIPickerView * speciesView;
     UIPickerView * measureView;
    UIView * viewDown;
}
@property (strong, nonatomic) YYTCity * cityLocation;
@property (nonatomic) HZAreaPickerStyle pickerStyle;
//城市
@property (nonatomic,retain) NSArray * titArray;
@property (nonatomic,retain) NSArray * array;
@property (nonatomic,retain) NSMutableArray * cityArray;
@property (nonatomic,retain) NSArray * areaArray;
//借款期限
@property (nonatomic,retain) NSArray * timeArray;
//借款种类
@property (nonatomic,retain) NSArray * specArray;
//担保措施
@property (nonatomic,retain) NSArray * measuArray;

@end

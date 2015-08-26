
#import "YYlable.h"

@implementation YYlable
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.textAlignment = NSTextAlignmentCenter;
        self.font = [UIFont systemFontOfSize:13];
        self.userInteractionEnabled = YES;
    }
    return self;
}
@end

//
//  PromptBox.m
//  ProjectSkeleton
//
//  Created by zhangshengyu on 15/8/10.
//  Copyright (c) 2015年 zhangshengyu. All rights reserved.
//

#import "PromptBox.h"

@implementation PromptBox
+(void)showMessage:(NSString *)message

{
    
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    
    UIView *showview =  [[UIView alloc]init];
    
    showview.backgroundColor = [UIColor blackColor];
    
    showview.frame = CGRectMake(1, 1, 1, 1);
    
    showview.alpha = 1.0f;
    
    showview.layer.cornerRadius = 5.0f;
    
    showview.layer.masksToBounds = YES;
    
    [window addSubview:showview];
    
    
    
    UILabel *label = [[UILabel alloc]init];
    
    CGSize LabelSize = [message sizeWithFont:[UIFont systemFontOfSize:20] constrainedToSize:CGSizeMake(290, 9000)];
    
    label.frame = CGRectMake(0,0, LabelSize.width, LabelSize.height);
    
    label.text = message;
    
    label.textColor = [UIColor whiteColor];
    
    label.textAlignment = 1;
    
    label.backgroundColor = [UIColor clearColor];
    
    label.font = [UIFont boldSystemFontOfSize:15];
    
    [showview addSubview:label];
    
    //提示框的位置
    
    showview.frame = CGRectMake((window.bounds.size.width-label.width)/2,(window.bounds.size.height-label.height)/2,label.width,label.height);
    
    [UIView animateWithDuration:3.5 animations:^{
        
        showview.alpha = 0;
        
    } completion:^(BOOL finished) {
        
        [showview removeFromSuperview];
        
    }];
    
}
@end

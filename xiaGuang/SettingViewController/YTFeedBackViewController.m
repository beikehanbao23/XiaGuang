//
//  YTFeedBackViewController.m
//  HighGuang
//
//  Created by Ke ZhuoPeng on 14-9-28.
//  Copyright (c) 2014年 Yuan Tao. All rights reserved.
//

#import "YTFeedBackViewController.h"
#import "UIColor+ExtensionColor_UIImage+ExtensionImage.h"
@interface YTFeedBackViewController ()<UITextViewDelegate>{
    UITextView *_textView;
    BOOL _isSend;
}
@end

@implementation YTFeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"shop_bg_1"]];
    self.navigationItem.title = @"意见反馈";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStyleDone target:self action:@selector(sender)];
    
    _textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 10, CGRectGetWidth(self.view.frame), 160)];
    _textView.textColor = [UIColor colorWithString:@"909090"];
    _textView.layer.borderWidth = 0.5;
    _textView.userInteractionEnabled = NO;
    _textView.layer.borderColor = [UIColor colorWithString:@"dcdcdc"].CGColor;
    _textView.font = [UIFont systemFontOfSize:14];
    _textView.text = @"写写您使用感受和建议...";
    _textView.delegate = self;
    _textView.textContainerInset = UIEdgeInsetsMake(15, 15, 0, 15);
    [self.view addSubview:_textView];
    self.automaticallyAdjustsScrollViewInsets = NO;
   
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.clipsToBounds = NO;
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName]];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"all_bg_navbar"] forBarMetrics:UIBarMetricsDefault];
}

- (void)sender{
    if (!_isSend) {
        [[[UIAlertView alloc]initWithTitle:@"虾逛提示" message:@"您所填的反馈不能为空" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil]show];
        return;
    }
    AVObject *feedBack = [[AVObject alloc] initWithClassName:@"Feedback"];
    [feedBack setObject:_textView.text forKey:@"feedBack"];
    [feedBack saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if(error){
            NSLog(@"error uploading feedback");
        }
        else{
            NSLog(@"successfully uploaded feedback");
        }
    }];
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *tmpTouch = [touches anyObject];
    CGPoint clickToPoint = [tmpTouch locationInView:self.view];
    if (CGRectContainsPoint(_textView.frame, clickToPoint) && !_textView.isFirstResponder) {
        NSRange tmpRange;
        tmpRange.length = 0;
        tmpRange.location = 0;
        _textView.selectedRange = tmpRange;
        [_textView becomeFirstResponder];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    _textView.userInteractionEnabled = YES;
    if ([textView.text rangeOfString:@"写写您使用感受和建议..."].length > 0) {
        _isSend = YES;
        textView.text = @"";
        _textView.textColor = [UIColor colorWithString:@"202020"];
    }
    return YES;
}

-(void)dealloc{
    _textView.delegate = nil;
    [_textView resignFirstResponder];
    [_textView removeFromSuperview];
    
    NSLog(@"feedBack dealloc");
}
@end

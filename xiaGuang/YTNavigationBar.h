//
//  YTNavigationBar.h
//  HighGuang
//
//  Created by Ke ZhuoPeng on 14-10-16.
//  Copyright (c) 2014年 Yuan Tao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YTNavigationBar;
@protocol YTNavigationBarDelegate <NSObject>
@required
-(void)backButtonClicked;
-(void)searchButtonClicked;
@end
@interface YTNavigationBar : UIView
@property (weak,nonatomic) id<YTNavigationBarDelegate> delegate;
@property (strong,nonatomic) NSString *backTitle;

-(void)changeSearchButton;

-(void)changeBackButton;
@end
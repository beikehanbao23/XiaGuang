//
//  YTCategoryResultsView.h
//  HighGuang
//
//  Created by Ke ZhuoPeng on 14-9-22.
//  Copyright (c) 2014年 Yuan Tao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YTMall.h"

@protocol YTCategoryResultsDelegete <NSObject>
-(void)searchKeyForCategoryTitle:(NSString *)category subCategoryTitle:(NSString *)subCategory mallName:(NSString *)mallName floor:(NSString *)floorName;
@end

@interface YTCategoryResultsView : UIView
@property (weak,nonatomic)id<YTCategoryResultsDelegete> delegate;

-(id)initWithFrame:(CGRect)frame andmall:(id<YTMall>)mall categoryKey:(NSString *)key subCategory:(NSString *)subKey;

-(void)setKey:(NSString *)key subKey:(NSString *)subKey;
@end
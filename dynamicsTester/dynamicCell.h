//
//  dynamicCell.h
//  dynamicsTester
//
//  Created by Cam Feenstra on 2/8/17.
//  Copyright © 2017 Cam Feenstra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "stackView.h"

@protocol dynamicLayoutManager;

@interface dynamicCell : UIStackView <UIScrollViewDelegate>

-(id _Nonnull)initWithFrame:(CGRect)frame barHeight:(CGFloat)barHeight;

@property (strong, nonatomic, nonnull) stackView *barView;

@property (strong, nonatomic, nullable) stackView *accessoryView;

-(BOOL)hasAccessoryView;

-(BOOL)isAccessoryViewShowing;

-(void)tapBar;

@property (readonly) CGFloat barHeight;

@property (nonatomic, nullable) id<dynamicLayoutManager> layoutManager;

@property BOOL swipeToDismiss;

@end

@protocol dynamicLayoutManager <NSObject>

-(void)dynamicCell:(dynamicCell* _Nonnull)cell accessoryShowingWillChangeTo:(BOOL)showing;

-(void)dynamicCell:(dynamicCell * _Nonnull)cell accessoryShowingDidChangeTo:(BOOL)showing;

@optional

-(void)dynamicCellWasDismissed:(dynamicCell* _Nonnull)cell;

@end

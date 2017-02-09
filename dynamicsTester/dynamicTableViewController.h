//
//  dynamicTableViewController.h
//  dynamicsTester
//
//  Created by Cam Feenstra on 2/9/17.
//  Copyright © 2017 Cam Feenstra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "dynamicCell.h"

@interface dynamicTableViewController : UIViewController <dynamicLayoutManager>

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) IBOutlet UIStackView *stackView;

-(void)addDynamicCell:(dynamicCell*)cell;

-(void)insertDynamicCell:(dynamicCell*)cell atIndex:(NSInteger)index;

-(void)removeDynamicCell:(dynamicCell*)cell;

-(void)removeDynamicCellAtIndex:(NSInteger)index;

-(NSArray<dynamicCell*>*)dynamicCells;

@property BOOL doesCollapse;

@end

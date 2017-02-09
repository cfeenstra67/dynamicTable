//
//  dynamicTableViewController.m
//  dynamicsTester
//
//  Created by Cam Feenstra on 2/9/17.
//  Copyright © 2017 Cam Feenstra. All rights reserved.
//

#import "dynamicTableViewController.h"

@interface dynamicTableViewController (){
    NSMutableArray<dynamicCell*>* cells;
}

@end

@implementation dynamicTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialize];
    _doesCollapse=YES;
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStyleDone target:self action:@selector(addPressed:)]];
    // Do any additional setup after loading the view.
    
}

-(IBAction)addPressed:(id)sender
{
    dynamicCell *new=[[dynamicCell alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.frame.size.height/3) barHeight:60];
    new.hidden=YES;
    [self insertDynamicCell:new atIndex:0];
    [UIView animateWithDuration:.25 animations:^{
        new.hidden=NO;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    for(NSInteger i=0; i<10; i++)
    {
        [self insertDynamicCell:[[dynamicCell alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.frame.size.height/3) barHeight:60] atIndex:0];
    }
    [_stackView setFrame:self.view.bounds];
    [_scrollView setContentOffset:CGPointZero];
    [self recalculateContentSize];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)initialize
{
    cells=[[NSMutableArray alloc] init];
    [_scrollView setContentSize:CGSizeMake(self.view.frame.size.width, 1000)];
    [_stackView setDistribution:UIStackViewDistributionFill];
    [_stackView setAlignment:UIStackViewAlignmentLastBaseline];
    [_stackView setAxis:UILayoutConstraintAxisVertical];
    [_stackView setBaselineRelativeArrangement:YES];
}

-(NSArray<dynamicCell*>*)dynamicCells
{
    return cells;
}

//Methods for adding, deleting cells

-(void)addDynamicCell:(dynamicCell *)cell
{
    [self insertDynamicCell:cell atIndex:cells.count];
}

-(void)insertDynamicCell:(dynamicCell*)cell atIndex:(NSInteger)index
{
    NSLog(@"@%ld",index);
    [_stackView insertArrangedSubview:cell atIndex:index];
    [cells insertObject:cell atIndex:index];
    cell.layoutManager=self;
    [self recalculateContentSize];
}

-(void)removeDynamicCell:(dynamicCell *)cell
{
    cell.layoutManager=nil;
    [_stackView removeArrangedSubview:cell];
    [cells removeObject:cell];
    [self recalculateContentSize];
}

-(void)removeDynamicCellAtIndex:(NSInteger)index
{
    [self removeDynamicCell:cells[index]];
}

-(void)dynamicCell:(dynamicCell *)cell accessoryShowingWillChangeTo:(BOOL)showing
{
    if(!_doesCollapse)
    {
        return;
    }
    for(NSInteger i=0; i<cells.count; i++)
    {
        if(cells[i]==cell)
        {
            NSInteger savei=i;
            while(i>0)
            {
                i--;
                if([cells[i] isAccessoryViewShowing])
                {
                    [cells[i] tapBar];
                }
            }
            i=savei;
            while(i<cells.count-1)
            {
                i++;
                if([cells[i] isAccessoryViewShowing])
                {
                    [cells[i] tapBar];
                }
                
            }
            break;
        }
    }
}

-(void)dynamicCell:(dynamicCell *)cell accessoryShowingDidChangeTo:(BOOL)showing
{
    [self recalculateContentSize];
}

-(void)recalculateContentSize
{
    NSLog(@"%ld arranged",_stackView.subviews.count);
    CGFloat totalHeight=0;
    for(dynamicCell *v in cells)
    {
        totalHeight+=v.barView.frame.size.height;
        if([v isAccessoryViewShowing])
        {
            totalHeight+=v.accessoryView.frame.size.height;
        }
    }
    NSLog(@"%f",totalHeight);
    [UIView animateWithDuration:.25 animations:^{
        [_scrollView setContentSize:CGSizeMake(_scrollView.contentSize.width, totalHeight)];
    }];
}

-(void)dynamicCellWasDismissed:(dynamicCell *)cell
{
    [UIView animateWithDuration:.25 animations:^{
        cell.hidden=YES;
    } completion:^(BOOL finished){
        [self removeDynamicCell:cell];
    }];
}

@end

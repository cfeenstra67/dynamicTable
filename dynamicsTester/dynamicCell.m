//
//  dynamicCell.m
//  dynamicsTester
//
//  Created by Cam Feenstra on 2/8/17.
//  Copyright © 2017 Cam Feenstra. All rights reserved.
//

#import "dynamicCell.h"
#import "stackView.h"

@interface dynamicCell(){
    CGFloat barHeight;
}

-(void)configureBarView;

-(void)configureAccessoryView;

@end

@implementation dynamicCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)initWithFrame:(CGRect)frame
{
    self=[self initWithFrame:frame barHeight:60];
    return self;
}

-(id)initWithFrame:(CGRect)frame barHeight:(CGFloat)barHeigh
{
    self=[super initWithFrame:frame];
    barHeight=barHeigh;
    _accessoryView=[[stackView alloc] init];
    _layoutManager=nil;
    self.swipeToDismiss=YES;
    self.axis=UILayoutConstraintAxisVertical;
    self.distribution=UIStackViewDistributionFill;
    self.alignment=UIStackViewAlignmentFill;
    [self configureBarView];
    if([self hasAccessoryView])
    {
        [self configureAccessoryView];
    }
    return self;
}

-(CGFloat)barHeight
{
    return _barView.frame.size.height;
}

-(stackView*)defaultBarView
{
    
    stackView *new=[[stackView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, barHeight)];
    [new setBackgroundColor:[UIColor clearColor]];
    new.showsVerticalScrollIndicator=NO;
    new.showsHorizontalScrollIndicator=NO;
    new.bounces=NO;
    UIView *sub=[[UIView alloc] initWithFrame:CGRectMake(0, 0, new.frame.size.width, new.frame.size.height)];
    [sub setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    [new setContentSize:CGSizeMake(new.bounds.size.width*2, new.bounds.size.height)];
    [new setContentOffset:CGPointMake(new.bounds.size.width, 0)];
    new.pagingEnabled=YES;
    new.delegate=self;
    [new addSubview:sub];
    [sub setFrame:CGRectMake(new.frame.size.width, 0, new.frame.size.width, new.frame.size.height)];
    CGFloat width=0.5f;
    UIView *bottom=[[UIView alloc] initWithFrame:CGRectMake(0, new.frame.size.height-width, new.frame.size.width, width)];
    [bottom setBackgroundColor:[UIColor blackColor]];
    [sub addSubview:bottom];
    UIView *top=[[UIView alloc] initWithFrame:CGRectMake(0, 0, new.frame.size.width, width)];
    [top setBackgroundColor:[UIColor blackColor]];
    [sub addSubview:top];
    [new.layer setShadowColor:[UIColor darkGrayColor].CGColor];
    [new.layer setShadowRadius:8.0f];
    [new.layer setShadowOpacity:.5f];
    if([self hasAccessoryView])
    {
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
        [new addGestureRecognizer:tap];
    }
    return new;
}

-(IBAction)tapped:(id)sender{
    [self tapBar];
}

-(BOOL)hasAccessoryView
{
    return _accessoryView!=nil;
}

-(BOOL)isAccessoryViewShowing
{
    if([self hasAccessoryView])
    {
        return !_accessoryView.hidden;
    }
    return NO;
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

-(void)setSwipeToDismiss:(BOOL)swipeToDismiss
{
    _barView.scrollEnabled=swipeToDismiss;
}

-(BOOL)swipeToDismiss
{
    return _barView.scrollEnabled;
}

-(void)tapBar
{
    if(_accessoryView!=nil)
    {
        if(_layoutManager!=nil)
        {
            [_layoutManager dynamicCell:self accessoryShowingWillChangeTo:![self isAccessoryViewShowing]];
        }
        [UIView animateWithDuration:.25 animations:^{
            _accessoryView.hidden=!_accessoryView.hidden;
        } completion:^(BOOL finished){
            if(_layoutManager!=nil)
            {
                [_layoutManager dynamicCell:self accessoryShowingDidChangeTo:[self isAccessoryViewShowing]];
                _barView.scrollEnabled=![self isAccessoryViewShowing];
            }
        }];
        
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if(_layoutManager!=nil&&self.barView.contentOffset.x==0)
    {
        [_layoutManager dynamicCellWasDismissed:self];
    }
}

-(void)configureBarView
{
    _barView=[self defaultBarView];
    _barView.scrollEnabled=self.swipeToDismiss;
    [self addArrangedSubview:_barView];
}

-(void)configureAccessoryView
{
    _accessoryView=[[stackView alloc] initWithFrame:CGRectMake(0, barHeight, _barView.frame.size.width, self.frame.size.height-barHeight)];
    [_accessoryView setBackgroundColor:[UIColor grayColor]];
    [self addArrangedSubview:_accessoryView];
    _accessoryView.hidden=YES;
    if(_accessoryView!=nil)
    {
        [self addArrangedSubview:_accessoryView];
    }
}

@end

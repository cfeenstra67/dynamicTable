//
//  stackView.m
//  LTHosting
//
//  Created by Cam Feenstra on 2/7/17.
//  Copyright © 2017 Cam Feenstra. All rights reserved.
//

#import "stackView.h"

@implementation stackView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)init
{
    self=[super init];
    [self initialize];
    return self;
}

-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    [self initialize];
    return self;
}

-(void)initialize
{
    self.layer.masksToBounds=YES;
}

-(CGSize)intrinsicContentSize
{
    return self.bounds.size;
}

@end

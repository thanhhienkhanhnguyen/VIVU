//
//  CustomeButton.m
//  VIVU
//
//  Created by Khanh on 4/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CustomeButton.h"

@implementation CustomeButton
@synthesize imageId;
@synthesize url;
@synthesize arrayPhotos;
-(void)dealloc
{
    [arrayPhotos release];
    [url release];
    [imageId release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

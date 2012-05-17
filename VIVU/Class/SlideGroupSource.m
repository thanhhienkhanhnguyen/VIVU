//
//  SlideGroupSource.m
//  VIVU
//
//  Created by MacPro on 4/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SlideGroupSource.h"

@implementation SlideGroupSource
@synthesize childs = _childs;
@synthesize isExpanded = _isExpanded;
@synthesize groupName = _groupName;

-(NSInteger)count
{
    return [_childs count];
}

-(id)initWithGroupName:(NSString*)groupName
{
    self = [self init];
    if (self) {
        self.groupName = groupName;
    }
    return self;
}

-(id)init
{
    self = [super init];
    if (self) {
        _childs = [[NSMutableArray alloc] init];
        _isExpanded = YES;
    }
    return self;
}

-(void)dealloc
{
    [_childs release];
    [super dealloc];
}

+(SlideGroupSource*)findGroupName:(NSString*)groupName inArray:(NSMutableArray*)array
{
    SlideGroupSource *result = nil;
    for (id item in array)
    {
        if ([item isKindOfClass:[SlideGroupSource class]]) {
            if ([((SlideGroupSource*)item).groupName isEqualToString:groupName]) {
                result = (SlideGroupSource*)item;
                break;
            }
        }
    }
    return result;
}

@end

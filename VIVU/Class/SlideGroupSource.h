//
//  SlideGroupSource.h
//  VIVU
//
//  Created by MacPro on 4/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SlideGroupSource : NSObject
@property (nonatomic, retain) NSString *groupName;
@property (nonatomic, retain) NSMutableArray *childs;
@property (nonatomic, assign) BOOL isExpanded;

-(NSInteger)count;
-(id)initWithGroupName:(NSString*)groupName;
+(SlideGroupSource*)findGroupName:(NSString*)groupName inArray:(NSArray*)array;

@end

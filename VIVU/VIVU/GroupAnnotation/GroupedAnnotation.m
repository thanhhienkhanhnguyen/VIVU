

#import "GroupedAnnotation.h"


@implementation GroupedAnnotation
@synthesize categoryName;
@synthesize listAnnotations;
@synthesize count;
-(void)dealloc
{
    [listAnnotations release];
    [categoryName release];
    [super dealloc];
}
- (NSString *)subtitle
{
	return @"";
}
- (NSString *)title
{
	return [NSString stringWithFormat:@"grouping of %d",count];
}

-(CLLocationCoordinate2D) coordinate
{
	return coordinate;
}

-(id) initWithCoordinate:(CLLocationCoordinate2D)cord count:(int)cnt
{
	self = [super init];
	if(!self)
		return nil;
	listAnnotations= nil;
	coordinate = cord;
	self.count = cnt;
	
	return self;
}

@end

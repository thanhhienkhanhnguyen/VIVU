

#import "SingleAnnotation.h"


@implementation SingleAnnotation
@synthesize categoryName;
@synthesize itemId;
@synthesize distance;
@synthesize dictInfor;

-(void)dealloc
{
//    NSLog(@"tetea:%d",dictInfor.retainCount);
    [dictInfor release];
//    self.dictInfor = nil;
    [categoryName release];
    [itemId release];
    [super dealloc];
}

- (NSString *)subtitle
{
	return @"";
}
- (NSString *)title
{
	return [NSString stringWithFormat:@"single at %.2f %.2f",coordinate.latitude,coordinate.longitude];
}

-(CLLocationCoordinate2D) coordinate
{
	return coordinate;
}

-(id) initWithCoordinate:(CLLocationCoordinate2D)cord
{
	self = [super init];
	if(!self)
		return nil;
	
	coordinate = cord;

	return self;
}
-(id) initSingleAnnatation:(NSString *)categorySpiner itemID:(NSString *)idSpiner coorSpiner:(CLLocationCoordinate2D )coorSpiner distanceParameter:(CGFloat) distanParameter
{
    [self initWithCoordinate:coorSpiner];
    if (self) {
        self.dictInfor = nil;
        coordinate = coorSpiner;
        self.categoryName = categorySpiner;
        self.itemId = idSpiner; 
        distance = distanParameter;
        
    }
    return self;
}


@end

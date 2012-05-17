

#import "SingleAnnotation.h"


@implementation SingleAnnotation
@synthesize categoryName;
@synthesize itemId;
@synthesize distance;
@synthesize dictInfor;

-(void)dealloc
{
    [dictInfor release];
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
        dictInfor = nil;
        coordinate = coorSpiner;
        categoryName = categorySpiner;
        itemId = idSpiner; 
        distance = distanParameter;
        
    }
    return self;
}


@end

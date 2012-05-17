

#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface GroupedAnnotation : NSObject <MKAnnotation>
{
	CLLocationCoordinate2D coordinate;
	int count;
}
@property (nonatomic, retain) NSString *categoryName;
@property (nonatomic, retain) NSArray *listAnnotations;
@property (nonatomic, assign) int count;
-(id) initWithCoordinate:(CLLocationCoordinate2D)cord count:(int)cnt;

@end

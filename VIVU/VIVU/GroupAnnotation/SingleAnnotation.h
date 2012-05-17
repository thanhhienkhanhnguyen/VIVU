
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface SingleAnnotation : NSObject <MKAnnotation>
{
	CLLocationCoordinate2D coordinate;
}
@property (nonatomic, retain) NSString *categoryName;
@property (nonatomic, retain) NSString *itemId;
@property (nonatomic, assign) CGFloat distance;
@property (nonatomic ,retain) NSDictionary *dictInfor;
-(id) initSingleAnnatation:(NSString *)categorySpiner itemID:(NSString *)itemId coorSpiner:(CLLocationCoordinate2D )coorSpiner distanceParameter:(CGFloat) distanParameter;
@end

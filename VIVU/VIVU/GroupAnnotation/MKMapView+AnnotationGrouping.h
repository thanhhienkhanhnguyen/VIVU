
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>


@interface MKMapView(AnnotationGrouping)

-(void) addAnnotations:(NSArray*)annos withGroupDistance:(float)dist;

@end
